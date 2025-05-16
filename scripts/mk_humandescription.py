import json
import pgf
import requests
import re
import unicodedata
from tqdm import tqdm

# === 载入语法 ===
GRAMMAR = '../grammars/HumanDescriptions.pgf'
grammar = pgf.readPGF(GRAMMAR)
chinese = grammar.languages['HumanDescriptionsChi']
english = grammar.languages['HumanDescriptionsEng']

# === 历史国家归一映射 ===
ancient_to_modern = {
    'Q43287_German_Empire_Country': 'Q183_Germany_Country',
    'Q29999_Kingdom_of_the_Netherlands_Country': 'Q55_Netherlands_Country',
    'Q153015_Kingdom_of_Saxony_Country': 'Q183_Germany_Country',
    'Q27306_Kingdom_of_Prussia_Country': 'Q183_Germany_Country',
    'Q38872_Prussia_Country': 'Q183_Germany_Country',
    'Q1206012_German_Reich_Country': 'Q183_Germany_Country',
    'Q10985258_German_Empire_Country': 'Q183_Germany_Country',
    'Q41304_Weimar_Republic_Country': 'Q183_Germany_Country',
    'Q154741_Confederation_of_the_Rhine_Country': 'Q183_Germany_Country',
    'Q155570_Saxe_Weimar_Eisenach_Country': 'Q183_Germany_Country',
    'Q186320_Grand_Duchy_of_Baden_Country': 'Q183_Germany_Country',
    'Q34266_Russian_Empire_Country': 'Q159_Russia_Country',
    'Q552033_Bavaria_Munich_Country': 'Q183_Germany_Country',
    'Q164079_Kingdom_of_Hanover_Country': 'Q183_Germany_Country',
    'Q186096_Tsardom_of_Russia_Country': 'Q159_Russia_Country',
    'Q326029_Duchy_of_Brunswick_Country': 'Q183_Germany_Country',
    'Q42199_Principality_of_Ansbach_Country': 'Q183_Germany_Country',
    'Q693669_Grand_Duchy_of_Oldenburg_Country': 'Q183_Germany_Country',
    'Q28513_Austria_Hungary_Country': 'Q40_Austria_Country',
    'Q173065_Kingdom_of_Naples_Country': 'Q38_Italy_Country',
    'Q155019_Duchy_of_Lorraine_Country': 'Q142_France_Country',
    'Q533534_Cisleithania_Country': 'Q40_Austria_Country',
    'Q129286_British_Raj_Country': 'Q145_United_Kingdom_Country',
    'Q174193_United_Kingdom_of_Great_Britain_and_Ireland_Country': 'Q145_United_Kingdom_Country',
    'Q172579_Kingdom_of_Italy_Country': 'Q38_Italy_Country',
    'Q389004_Wallachia_Country': 'Q218_Romania_Country',
    'Q1031430_Habsburg_Netherlands_Country': 'Q55_Netherlands_Country',
    'Q11750528_Duchy_of_Moscow_Country': 'Q159_Russia_Country',
    'Q153529_Duchy_of_Milan_Country': 'Q38_Italy_Country',
    'Q49697_Liu_Song_dynasty_Country': 'Q148_China_Country',
    'Q274488_Eastern_Wu_Country': 'Q148_China_Country',
    'Q171150_Kingdom_of_Hungary_Country': 'Q28_Hungary_Country',
    'Q203493_Kingdom_of_Romania_Country': 'Q218_Romania_Country',
    'Q45670_Kingdom_of_Portugal_Country': 'Q45_Portugal_Country',
    'Q154849_Grand_Duchy_of_Tuscany_Country': 'Q38_Italy_Country',
    'Q70972_Kingdom_of_France_Country': 'Q142_France_Country',
    'Q7462_Song_dynasty_Country': 'Q148_China_Country',
    'Q169460_Miletus_Country': 'Q41_Greece_Country',
    'Q161885_Kingdom_of_Great_Britain_Country': 'Q145_United_Kingdom_Country',
    'Q215530_Kingdom_of_Ireland_Country': 'Q145_United_Kingdom_Country',
    'Q230791_Kingdom_of_Scotland_Country': 'Q145_United_Kingdom_Country',
    'Q23366230_Republic_of_Geneva_Country': 'Q39_Switzerland_Country',
    'Q320930_Cao_Wei_Country': 'Q148_China_Country',
    'Q64576860_Lordship_of_Bologna_Country': 'Q38_Italy_Country',
    'Q170072_Dutch_Republic_Country': 'Q55_Netherlands_Country',
    'Q1147037_Eastern_Han_Country': 'Q148_China_Country',
    'Q148540_Republic_of_Florence_Country': 'Q38_Italy_Country',
    'Q221457_Congress_Poland_Country': 'Q36_Poland_Country',
    'Q217196_Crown_of_Castile_Country': 'Q29_Spain_Country',
    'Q7313_Yuan_dynasty_Country': 'Q148_China_Country',
    'Q204920_Crown_of_Aragon_Country': 'Q29_Spain_Country',
    'Q2252973_Duchy_of_Florence_Country': 'Q38_Italy_Country',
    'Q1649871_Kingdom_of_Poland_Country': 'Q36_Poland_Country',
    'Q47261_Duchy_of_Bavaria_Country': 'Q183_Germany_Country',
    'Q435583_Old_Swiss_Confederacy_Country': 'Q39_Switzerland_Country',
    'Q4420718_ancient_Syracuse_Country': 'Q41_Greece_Country',
    'Q1365493_Republic_of_Pisa_Country': 'Q38_Italy_Country',
    'Q2227570_Duchy_of_Wurttemberg_Country': 'Q183_Germany_Country',
    'Q22_Scotland_Country': 'Q145_United_Kingdom_Country',
    'Q1072949_Western_Han_Country': 'Q148_China_Country',
    'Q13580795_Samos_Country': 'Q41_Greece_Country',
    'Q153136_Habsburg_monarchy_Country': 'Q40_Austria_Country',
    'Q158151_Saxe_Altenburg_Country': 'Q183_Germany_Country',
    'Q1233672_County_of_Barcelona_Country': 'Q29_Spain_Country',
    'Q11768_Ancient_Egypt_Country': 'Q79_Egypt_Country',
    'Q871091_British_Malaya_Country': 'Q145_United_Kingdom_Country',
    'Q1236847_Lordship_of_Kniphausen_Country': 'Q183_Germany_Country',
    'Q694594_Duchy_of_Bremen_and_Verden_Country': 'Q183_Germany_Country',
    'Q693551_Landgraviate_of_Hesse_Darmstadt_Country': 'Q183_Germany_Country',
    'Q3139179_Hohenlohe_Kirchberg_Country': 'Q183_Germany_Country',
    'Q561334_Prince_Bishopric_of_Bamberg_Country': 'Q183_Germany_Country',
    'Q16957_German_Democratic_Republic_Country': 'Q183_Germany_Country',
    'Q13427044_Prince_Bishopric_of_Wurzburg_Country': 'Q183_Germany_Country',
    'Q20135_Grand_Duchy_of_Hesse_Country': 'Q183_Germany_Country',
    'Q696640_Duchy_of_Pomerania_Country': 'Q183_Germany_Country',
    'Q2281221_Principality_of_Orange_Country': 'Q142_France_Country',
    'Q43048_Rhodes_Country': 'Q41_Greece_Country',
    'Q207272_Second_Polish_Republic_Country': 'Q36_Poland_Country',
    'Q330533_Seventeen_Provinces_Country': 'Q55_Netherlands_Country',
    'Q9903_Ming_dynasty_Country': 'Q148_China_Country',
    'Q33946_Czechoslovakia_Country': 'Q213_Czech_Republic_Country',
    'Q188712_Empire_of_Japan_Country': 'Q17_Japan_Country',
    'Q8733_Qing_dynasty_Country': 'Q148_China_Country',
    'Q11225429_Thebes_Country': 'Q41_Greece_Country',
    'Q211274_Polish_People_s_Republic_Country': 'Q36_Poland_Country',
    'Q15102440_Kingdom_of_Serbs_Croats_and_Slovenes_Country': 'Q36704_Yugoslavia_Country',
    'Q241748_Kingdom_of_Serbia_Country': 'Q403_Serbia_Country',
    'Q4734309_Alokopennesos_Country': 'Q41_Greece_Country',
    'Q11772_Ancient_Greece_Country': 'Q41_Greece_Country',
    'Q12560_Ottoman_Empire_Country': 'Q43_Turkey_Country',
    'Q42585_Kingdom_of_Bohemia_Country': 'Q213_Czech_Republic_Country',
    'Q13526919_Kroton_Country': 'Q41_Greece_Country',
    'Q622783_Spanish_Netherlands_Country': 'Q29_Spain_Country',
    'Q70802_French_Third_Republic_Country': 'Q142_France_Country',
    'Q684030_Principality_of_Serbia_Country': 'Q403_Serbia_Country',
    'Q180393_Kingdom_of_the_Two_Sicilies_Country': 'Q38_Italy_Country',
    'Q551067_Northern_Zhou_Country': 'Q148_China_Country',
    'Q9683_Tang_dynasty_Country': 'Q148_China_Country',
    'Q7209_Han_dynasty_Country': 'Q148_China_Country',
    'Q5066_Jin_dynasty_Country': 'Q148_China_Country',
    'Q13498_Taranto_Country': 'Q38_Italy_Country',
    'Q2022162_Kingdom_of_Pergamon_Country': 'Q41_Greece_Country',
    'Q252580_Duchy_of_Modena_and_Reggio_Country': 'Q38_Italy_Country',
    'Q174306_Republic_of_Genoa_Country': 'Q38_Italy_Country',
    'Q80702_Spanish_Empire_Country': 'Q29_Spain_Country',
    'Q1233764_Doric_hexapolis_Country': 'Q41_Greece_Country',
    'Q2305208_Russian_Socialist_Federative_Soviet_Republic_Country': 'Q159_Russia_Country',
    'Q2396442_Kingdom_of_Galicia_and_Lodomeria_Country': 'Q36_Poland_Country',
    'Q319460_Northern_Song_dynasty_Country': 'Q148_China_Country',
    'Q83286_Socialist_Federal_Republic_of_Yugoslavia_Country': 'Q36704_Yugoslavia_Country',
    'Q49696_Northern_and_Southern_dynasties_Country': 'Q148_China_Country',
    'Q3149991_Ancient_India_Country': 'Q668_India_Country',
    'Q123559_al_Andalus_Country': 'Q29_Spain_Country',
    'Q33296_Mughal_Empire_Country': 'Q668_India_Country',
    'Q656954_Soli_Country': 'Q41_Greece_Country',
    'Q6681_Crotone_Country': 'Q38_Italy_Country',
    'Q704300_Free_City_of_Frankfurt_Country': 'Q183_Germany_Country',
    'Q256961_Electorate_of_Bavaria_Country': 'Q183_Germany_Country',
    'Q836680_Duchy_of_Nassau_Country': 'Q183_Germany_Country',
    'Q15864_United_Kingdom_of_the_Netherlands_Country': 'Q55_Netherlands_Country',
    'Q30623_Manchukuo_Country': 'Q148_China_Country',
    'Q7318_Nazi_Germany_Country': 'Q183_Germany_Country',
    'Q165154_Kingdom_of_Sardinia_Country': 'Q38_Italy_Country',
    'Q170770_Grand_Principality_of_Moscow_Country': 'Q159_Russia_Country',
    'Q212439_Cossack_Hetmanate_Country': 'Q212_Ukraine_Country',
    'Q133356_Ukrainian_Soviet_Socialist_Republic_Country': 'Q212_Ukraine_Country',
    'Q702224_Duchy_of_Carinthia_Country': 'Q40_Austria_Country',
    'Q243610_Ukrainian_People_s_Republic_Country': 'Q212_Ukraine_Country',
    'Q42406_English_people_Country': 'Q145_United_Kingdom_Country',
    'Q28025_Ryukyu_Kingdom_Country': 'Q17_Japan_Country',
    'Q26234937_First_Syrian_Republic_Country': 'Q858_Syria_Country',
    'Q124943_Kingdom_of_Egypt_Country': 'Q79_Egypt_Country',
    'Q426025_Duchy_of_Savoy_Country': 'Q38_Italy_Country',
    'Q12060881_Chinese_Empire_Country': 'Q148_China_Country',
    'Q2184_Russian_Soviet_Federative_Socialist_Republic_Country': 'Q159_Russia_Country',
    'Q1290149_Federal_People_s_Republic_of_Yugoslavia_Country': 'Q36704_Yugoslavia_Country',
    'Q151624_German_Confederation_Country': 'Q183_Germany_Country',
    'Q188586_Kingdom_of_Sicily_Country': 'Q38_Italy_Country',
    'Q158445_Grand_Duchy_of_Mecklenburg_Schwerin_Country': 'Q183_Germany_Country',
    'Q200464_Portuguese_Empire_Country': 'Q45_Portugal_Country',
    'Q209857_Kingdom_of_LombardyVenetia_Country': 'Q38_Italy_Country',
    'Q1054923_British_Hong_Kong_Country': 'Q148_China_Country',
    'Q713750_West_Germany_Country': 'Q183_Germany_Country',
    'Q264970_Anhalt_Kothen_Country': 'Q183_Germany_Country',
    'Q2162698_Duchy_of_Bohemia_Country': 'Q213_Czech_Republic_Country',
    'Q2670751_Margraviate_of_Moravia_Country': 'Q213_Czech_Republic_Country',
    'Q205662_Tokugawa_shogunate_Country': 'Q17_Japan_Country',
    'Q12738_Neuchatel_Country': 'Q39_Switzerland_Country',
    "Q156199_Electorate_of_Saxony_Country": "Q183_Germany_Country" ,
    "Q12548_Holy_Roman_Empire_Country": "Q183_Germany_Country"}

# === 所有国家函数（QID -> fun名） ===
def extract_qid_functions(filepath, typename):
    with open(filepath, encoding="utf-8-sig") as f:  # 自动去除 BOM
        text = f.read()
    pattern = re.compile(
        rf'(?:fun\s+)?(Q\d+)_([^\s:]+)\s*:\s*{re.escape(typename)}\s*;', 
        re.MULTILINE
    )
    qid_map = {}
    for qid, suffix in pattern.findall(text):
        func_name = f"{qid}_{suffix}"
        qid_map[qid] = func_name
    return qid_map
countries = extract_qid_functions("../grammars/Countries.gf", "Country")

def get_country_fun_from_qid(qid):
    if not qid:
        return None

    # 原始函数名
    func_name = countries.get(qid)
    if not func_name:
        return None

    # 尝试归一化
    mapped = ancient_to_modern.get(func_name)
    if mapped:
        mapped_qid = mapped.split('_')[0]
        return countries.get(mapped_qid, mapped)
    
    return func_name

def get_wikidata_entity(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    resp = requests.get(url, timeout=10)
    data = resp.json()
    return data['entities'][qid]

def get_gender_str(entity):
    claims = entity.get('claims', {})
    p21 = claims.get('P21', [])
    if not p21:
        return "unknown"
    mainsnak = p21[0].get('mainsnak', {})
    datavalue = mainsnak.get('datavalue', {})
    value = datavalue.get('value', {})
    qid = value.get('id')
    if qid == 'Q6581097':
        return "male"
    if qid == 'Q6581072':
        return "female"
    return "unknown"


def get_name(entity):
    return entity.get('labels', {}).get('en', {}).get('value', '')


def get_birth_year(entity):
    claims = entity.get('claims', {})
    p569 = claims.get('P569', [])
    if not p569:
        return None
    mainsnak = p569[0].get('mainsnak', {})
    datavalue = mainsnak.get('datavalue', {})
    value = datavalue.get('value', {})
    time = value.get('time', '')
    if time.startswith('+'):
        return time[1:5]
    return None

def get_citizenship_qid(entity):
    p27 = entity.get('claims', {}).get('P27', [])
    if not p27:
        return None
    return p27[0].get('mainsnak', {}).get('datavalue', {}).get('value', {}).get('id')

def get_death_year(entity):
    claims = entity.get('claims', {})
    p570 = claims.get('P570', [])
    if not p570:
        return None
    mainsnak = p570[0].get('mainsnak', {})
    datavalue = mainsnak.get('datavalue', {})
    value = datavalue.get('value', {})
    time = value.get('time', '')
    if time.startswith('+'):
        return time[1:5]
    return None

def get_birthplace_qid(entity):
    claims = entity.get('claims', {})
    p19 = claims.get('P19', [])
    if not p19:
        return None
    mainsnak = p19[0].get('mainsnak', {})
    datavalue = mainsnak.get('datavalue', {})
    value = datavalue.get('value', {})
    return value.get('id')

def get_country_of_place_at_year(place_qid, year):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{place_qid}.json'
    resp = requests.get(url, timeout=10)
    data = resp.json()
    claims = data['entities'][place_qid].get('claims', {})
    p17 = claims.get('P17', [])

    for claim in p17:
        snak = claim.get('mainsnak', {})
        if snak.get('snaktype') != 'value':
            continue
        qid = snak.get('datavalue', {}).get('value', {}).get('id')

        qualifiers = claim.get('qualifiers', {})
        from_year = to_year = None

        if 'P580' in qualifiers:
            from_time = qualifiers['P580'][0]['datavalue']['value']['time']
            from_year = int(from_time[1:5])  # "+1871-01-01T00:00:00Z" → 1871

        if 'P582' in qualifiers:
            to_time = qualifiers['P582'][0]['datavalue']['value']['time']
            to_year = int(to_time[1:5])  # "+1918-11-09T00:00:00Z" → 1918

        if from_year and to_year and from_year <= int(year) <= to_year:
            return qid
        if from_year and int(year) >= from_year:
            return qid
        if to_year and int(year) <= to_year:
            return qid

    if p17:
        snak = p17[0].get('mainsnak', {})
        return snak.get('datavalue', {}).get('value', {}).get('id')

    return None

def build_human_expr(entity):
    name = get_name(entity)

    gender_str = get_gender_str(entity)
    gender_param = {
        "male": "MaleParam",
        "female": "FemaleParam",
        "unknown": "UnknownParam"
    }[gender_str]
    person_expr = f'(Person "{name}" {gender_param})'

    birth = get_birth_year(entity)
    death = get_death_year(entity)
    if birth and death:
        year_expr = f'(BornAndDied "{birth}" "{death}")'
    elif birth:
        year_expr = f'(OnlyBorn "{birth}")'
    elif death:
        year_expr = f'(OnlyDied "{death}")'
    else:
        year_expr = 'NoBirthOrDeath'

    # 原始 QID 不做拼接处理
    citizenship_qid = get_citizenship_qid(entity)
    birthplace_qid = get_birthplace_qid(entity)
    birthplace_country_qid = get_country_of_place_at_year(birthplace_qid, birth) if birthplace_qid and birth else None

    # 归一化和合法性检查全放在函数里
    citizenship_fun = get_country_fun_from_qid(citizenship_qid) or "UnknownCountry"
    birthplace_fun = get_country_fun_from_qid(birthplace_country_qid)
    birthplace_expr = f'(Bornin {birthplace_fun})' if birthplace_fun else None

    prof_expr = "Mathematician"

    if citizenship_fun == birthplace_fun or not birthplace_expr:
        return f"SameNationalityBuilding {person_expr} {citizenship_fun} {prof_expr} {year_expr}"
    else:
        return f"DiffNationalityBuilding {person_expr} {citizenship_fun} {birthplace_expr} {prof_expr} {year_expr}"



if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Usage: python3 ss.py <QID>")
        sys.exit(1)

    qid = sys.argv[1]
    try:
        entity = get_wikidata_entity(qid)
        expr_str = build_human_expr(entity)
        expr = pgf.readExpr(expr_str)
        zh = chinese.linearize(expr)
        en = english.linearize(expr)
        print("中文：", zh)
        print("English:", en)
    except Exception as e:
        print(f"[ERROR] failed to process {qid}: {e}")