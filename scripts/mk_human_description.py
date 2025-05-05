import sys
import json
import pgf
import requests
import re
import unicodedata
from tqdm import tqdm

GRAMMAR = '../grammars/HumanDescriptions.pgf'
grammar = pgf.readPGF(GRAMMAR)
english = grammar.languages['HumanDescriptionsEng']


country_functions = {f.split('_')[0]: f for f in grammar.functions if f.endswith('_Country')}


COUNTRIES_GF = "/home/heluxue/gf-wikidata-tools/grammars/Countries.gf"
COUNTRIES_ENG_GF = "/home/heluxue/gf-wikidata-tools/grammars/CountriesEng.gf"

NATIONALITY_GF = "/home/heluxue/gf-wikidata-tools/grammars/Nationality.gf"
NATIONALITY_ENG_GF = "/home/heluxue/gf-wikidata-tools/grammars/NationalityEng.gf"

nationality_functions = {}  


# ---------- tools ----------
missing_demonyms = []


def extract_year(value):
    if isinstance(value, dict) and 'time' in value:
        return value['time'][1:5]
    elif isinstance(value, str):
        return value[:4]
    return None

def fetch_entity_claims(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    try:
        resp = requests.get(url, timeout=3)
        data = resp.json()
        return data['entities'][qid]['claims']
    except Exception as e:
        print(f"[WARN] Failed to fetch claims for {qid}: {e}")
        return {}

def get_claim_value(claims, pid):
    try:
        return claims[pid][0]['mainsnak']['datavalue']['value']
    except:
        return None

def get_country_of_place(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    try:
        resp = requests.get(url, timeout=3)
        data = resp.json()
        claims = data['entities'][qid]['claims']
        if 'P17' in claims:
            return claims['P17'][0]['mainsnak']['datavalue']['value']['id']
    except Exception as e:
        print(f"[WARN] Failed to fetch P17 from {qid}: {e}")
    return None

def get_label(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    try:
        resp = requests.get(url, timeout=3)
        data = resp.json()
        return data['entities'][qid]['labels']['en']['value']
    except Exception as e:
        print(f"[WARN] Could not get label for {qid}: {e}")
        return None

def insert_before_last_brace(path, line):
    with open(path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    if line not in lines:
        for i in range(len(lines) - 1, -1, -1):
            if lines[i].strip() == '}':
                lines.insert(i, line)
                break
        with open(path, 'w', encoding='utf-8') as f:
            f.writelines(lines)

def append_country_entry(qid, label):
    clean_label = sanitize_label(label)
    fun_name = f"{qid}_{clean_label}_Country"       
    fun_line = f"fun {fun_name} : Country ;\n"
    lin_line = f'lin {fun_name} = mkCountry "{label}" ;\n'

    insert_before_last_brace(COUNTRIES_GF, fun_line)
    insert_before_last_brace(COUNTRIES_ENG_GF, lin_line)

    country_functions[qid] = fun_name
    return fun_name

def sanitize_label(label):
    # 1. 去除变音符（ü -> u, é -> e）
    label = unicodedata.normalize('NFKD', label)
    label = label.encode('ascii', 'ignore').decode('ascii')

    # 2. 将连接号、破折号等替换成下划线
    label = re.sub(r"[‐‑‒–—―-]", "_", label)

    # 3. 将非字母数字的符号（空格、标点等）替换为下划线
    label = re.sub(r"[^\w]", "_", label)

    # 4. 压缩连续下划线
    label = re.sub(r"_+", "_", label)

    # 5. 去除开头/结尾下划线
    return label.strip("_")

def get_demonym(qid):
    url = f"https://www.wikidata.org/wiki/Special:EntityData/{qid}.json"
    try:
        resp = requests.get(url, timeout=3)
        data = resp.json()
        claims = data['entities'][qid]['claims']
        for claim in claims.get('P1549', []):
            value = claim['mainsnak']['datavalue']['value']
            if isinstance(value, dict) and value.get('language') == 'en':
                return value['text']
    except Exception as e:
        print(f"[WARN] Could not fetch demonym for {qid}: {e}")
    return None

def append_nationality_entry(qid, demonym):
    clean_adj = sanitize_label(demonym)
    fun_name = f"{qid}_{clean_adj}_Nationality"
    fun_line = f"fun {fun_name} : Nationality ;\n"
    lin_line = f'lin {fun_name} = mkNationality "{demonym}" ;\n'

    insert_before_last_brace(NATIONALITY_GF, fun_line)
    insert_before_last_brace(NATIONALITY_ENG_GF, lin_line)

    nationality_functions[qid] = fun_name
    return fun_name

# ---------- 主逻辑 ----------

def human_description(entity):
    qid = entity['url'].split('/')[-1]
    name = entity.get('labels', {}).get('en', 'Unknown')

    claims = fetch_entity_claims(qid)

    gender_qid = get_claim_value(claims, 'P21')  
    birth_val = get_claim_value(claims, 'P569')
    death_val = get_claim_value(claims, 'P570')
    cid = get_claim_value(claims, 'P27')
    citizenship_qid = cid['id'] if isinstance(cid, dict) and 'id' in cid else cid

    bid = get_claim_value(claims, 'P19')
    birthplace_qid = bid['id'] if isinstance(bid, dict) and 'id' in bid else bid   


    gender_param = 'MaleParam' if gender_qid == 'Q6581097' else 'FemaleParam' if gender_qid == 'Q6581072' else 'UnknownParam'
    person_expr = f'(Person "{name}" {gender_param})'


    birth_year = extract_year(birth_val)
    death_year = extract_year(death_val)
    if birth_year and death_year:
        year_expr = f'(BornAndDied {birth_year} {death_year})'
    elif birth_year:
        year_expr = f'(OnlyBorn {birth_year})'
    elif death_year:
        year_expr = f'(OnlyDied {death_year})'
    else:
        year_expr = 'NoBirthOrDeath'

    # 国籍表达式（补语法）
    citizenship_fun = country_functions.get(citizenship_qid)
    if not citizenship_fun and citizenship_qid:
        label = get_label(citizenship_qid)
        if label:
            citizenship_fun = append_country_entry(citizenship_qid, label)
        else:
            raise Exception(f"Missing label for unknown country {citizenship_qid}")

    # 出生地所属国家表达式（补语法）
    birthplace_country_qid = get_country_of_place(birthplace_qid) if birthplace_qid else None
    birthplace_country_fun = country_functions.get(birthplace_country_qid)
    if not birthplace_country_fun and birthplace_country_qid:
        label = get_label(birthplace_country_qid)
        if label:
            birthplace_country_fun = append_country_entry(birthplace_country_qid, label)

    nationality_fun = nationality_functions.get(citizenship_qid)
    if not nationality_fun and citizenship_qid:
        demonym = get_demonym(citizenship_qid)
        if demonym:
            nationality_fun = append_nationality_entry(citizenship_qid, demonym)
        else:
            missing_demonyms.append(citizenship_qid)
            raise Exception(f"Missing demonym for country {citizenship_qid}")
    nationality_expr = nationality_fun
    birthplace_expr = f'(Bornin {birthplace_country_fun})' if birthplace_country_fun else 'UnknownBirthplace'
    prof_expr = 'Mathematician'  # 默认职业

    # 构造最终表达式
    if citizenship_qid and birthplace_country_qid and citizenship_qid == birthplace_country_qid:
        expr_str = f'SameNationalityBuilding {person_expr} {nationality_expr} {prof_expr} {year_expr}'
    else:
        expr_str = f'DiffNationalityBuilding {person_expr} {nationality_expr} {birthplace_expr} {prof_expr} {year_expr}'

    return pgf.readExpr(expr_str)

def generate_descriptions(input_path, output_path, description_func, label="Humans"):
    with open(input_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    with open(output_path, "w", encoding="utf-8") as out:
        for line in tqdm(lines, desc=label):
            try:
                entity = json.loads(line)
                expr = description_func(entity)
                sentence = english.linearize(expr)
                name = entity.get("labels", {}).get("en", "Unknown")
                out.write(f"{name}: {sentence}\n")
            except Exception as e:
                print(f"[ERROR] Failed to process entity: {e}")

    if missing_demonyms:
        with open("missing_demonyms.txt", "w", encoding="utf-8") as f:
            for qid in sorted(set(missing_demonyms)):
                f.write(qid + "\n")
        print(f"[INFO] Missing demonyms written to missing_demonyms.txt ({len(missing_demonyms)} entries)")


if __name__ == "__main__":
    input_path = "/home/heluxue/gf-wikidata-tools/scripts/mathematicians_new_form .jsonl"
    output_path = "/home/heluxue/gf-wikidata-tools/scripts/Human_output.txt"    
    generate_descriptions(input_path, output_path, human_description)
