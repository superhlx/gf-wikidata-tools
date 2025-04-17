import sys
import json
import pgf
import requests


GRAMMAR = '../grammars/Descriptions.pgf'


grammar = pgf.readPGF(GRAMMAR)
english = grammar.languages['DescriptionsEng']


region_functions = {f.split('_')[0]: f for f in grammar.functions if f.endswith('_Region')}
country_functions = {f.split('_')[0]: f for f in grammar.functions if f.endswith('_Country')}

def get_p131_region_qid(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    try:
        resp = requests.get(url, timeout=10)
        data = resp.json()
        entity_data = data['entities'][qid]
        p131 = entity_data['claims'].get('P131')
        if p131:
            region_qid = p131[0]['mainsnak']['datavalue']['value']['id']
            return region_qid
    except Exception as e:
        print(f"[WARN] Failed to fetch P131 for {qid}: {e}")
    return None

def find_cityregion_fun_by_qid(qid):
    target_prefix = f"{qid}_"
    for f in grammar.functions:
        ftype = str(grammar.functionType(f))
        if f.startswith(target_prefix) and 'CityRegion' in ftype:
            return f

def city_description(entity):
    props = entity.get('prop', {})
    qid = entity['url'].split('/')[-1]

    country_uri = props.get('country')
    capital_of = props.get('capital')

    country_qid = country_uri.split('/')[-1] if country_uri else None
    capital_qid = capital_of.split('/')[-1] if capital_of else None
    country_fun = country_functions.get(country_qid)

    region_fun = None

    region_qid = get_p131_region_qid(qid)
    region_fun = find_cityregion_fun_by_qid(region_qid) if region_qid else None


    if capital_qid and capital_qid == country_qid:
        city_type = 'capital'
    elif capital_qid:
        city_type = 'provincial_capital'
    else:
        city_type = 'normal'


    kind_expr = '(capitalKind city_Kind)' if city_type in ['capital', 'provincial_capital'] else 'city_Kind'

    if city_type == 'capital' and country_fun:
        location_expr = f'(CaptialCityCountryLocation {country_fun})'
    elif city_type == 'provincial_capital' and region_fun and country_fun:
        location_expr = f'(CityRegionCountryLocation {region_fun} {country_fun})'
    elif region_fun and country_fun:
        location_expr = f'(CityRegionCountryLocation {region_fun} {country_fun})'
    elif country_fun:
        location_expr = f'(CountryLocation {country_fun})'
    else:
        location_expr = 'noLocation'

    expr_str = f'CityDescription {kind_expr} {location_expr}'
    return pgf.readExpr(expr_str)


def get_instance_of_qids(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    try:
        resp = requests.get(url, timeout=10)
        data = resp.json()
        entity_data = data['entities'][qid]
        p31 = entity_data['claims'].get('P31')
        if not p31:
            return []
        qids = []
        for stmt in p31:
            try:
                qids.append(stmt['mainsnak']['datavalue']['value']['id'])
            except:
                continue
        return qids
    except Exception as e:
        print(f"[WARN] Failed to fetch P31 for {qid}: {e}")
        return []
    

def is_public_or_private(instance_of_qids):
    public_qids = {'Q875538', 'Q62078547'}
    private_qids = {'Q902104', 'Q23002054'}

    if any(q in instance_of_qids for q in private_qids):
        return 'private'
    elif any(q in instance_of_qids for q in public_qids):
        return 'public'
    else:
        return 'unknown'

def find_region_fun_by_qid(qid):
    target_prefix = f"{qid}_"
    for f in grammar.functions:
        ftype = str(grammar.functionType(f))
        if f.startswith(target_prefix) and f.endswith('_Region') and 'Region' in ftype:
            return f
        

def university_description(entity):
    props = entity.get('prop', {})
    qid = entity['url'].split('/')[-1]


    country_uri = props.get('country')
    region_uri = props.get('location')
    inception = props.get('inception')


    country_qid = country_uri.split('/')[-1] if country_uri else None
    region_qid = region_uri.split('/')[-1] if region_uri else None


    country_fun = country_functions.get(country_qid)
    region_fun = find_region_fun_by_qid(region_qid) if region_qid else None

    instance_of_qids = get_instance_of_qids(qid)
    kind_category = is_public_or_private(instance_of_qids)

    kind_expr = 'university_Kind'
    if kind_category == 'private':
        kind_expr = f'(privateKind {kind_expr})'
    elif kind_category == 'public':
        kind_expr = f'(publicKind {kind_expr})'

    if region_fun and country_fun:
        location_expr = f'(RegionCountryLocation {region_fun} {country_fun})'
    elif country_fun:
        location_expr = f'(CountryLocation {country_fun})'
    else:
        location_expr = 'noLocation'


    if inception:
        year_raw = inception.split('-')[0]
        year_code = f'Y{year_raw}'
        if year_code in grammar.functions:
            attr_expr = f'(FoundedIn {year_code})'
        else:
            attr_expr = 'noAttr'
    else:
        attr_expr = 'noAttr'

    expr_str = f'UniversityDescription {kind_expr} {location_expr} {attr_expr}'
    return pgf.readExpr(expr_str)





from tqdm import tqdm  

def generate_descriptions(input_path, output_path, description_func, label="Processing"):
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


if __name__ == "__main__":
    # 配置文件路径
    uni_input = "/home/heluxue/gf-wikidata-tools/scripts/University.jsonl"
    uni_output = "/home/heluxue/gf-wikidata-tools/scripts/University_output.txt"

    city_input = "/home/heluxue/gf-wikidata-tools/scripts/City.jsonl"
    city_output = "/home/heluxue/gf-wikidata-tools/scripts/City_output.txt"

    # 分别处理两个文件
    generate_descriptions(uni_input, uni_output, university_description, label="Universities")
    generate_descriptions(city_input, city_output, city_description, label="Cities")