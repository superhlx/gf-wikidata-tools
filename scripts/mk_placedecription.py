import sys
import json
import pgf
import re
import requests
from datetime import datetime

GRAMMAR = '../grammars/Descriptions.pgf'


grammar = pgf.readPGF(GRAMMAR)
english = grammar.languages['DescriptionsEng']
chinese = grammar.languages['DescriptionsChi']

# dictionary of cities, city kinds, provinces, and countries

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

cities = extract_qid_functions("../grammars/Cities.gf", "City")
city_kinds = extract_qid_functions("../grammars/CityKinds.gf", "CityKinds")
provinces = extract_qid_functions("../grammars/Provinces.gf", "Province")
countries = extract_qid_functions("../grammars/Countries.gf", "Country")
waterbodies = extract_qid_functions("../grammars/Waterbodies.gf", "Waterbody")


def get_wikidata_entity(qid):
    url = f'https://www.wikidata.org/wiki/Special:EntityData/{qid}.json'
    resp = requests.get(url, timeout=10)
    data = resp.json()
    return data['entities'][qid]

# get the first qid for P31 (instance of) 
def get_first_instance_of_qid(entity):
    claims = entity.get('claims', {})
    p31_claims = claims.get('P31', [])
    instance_qid = None

    for claim in p31_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid is not None:
            instance_qid = qid
            break  # 找到第一个就跳出

    return instance_qid


# get the first qid for P17 (country) 
def get_first_country_qid(entity):
    claims = entity.get('claims', {})
    p17_claims = claims.get('P17', [])
    country_qid = None

    for claim in p17_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid is not None:
            country_qid = qid
            break  # 找到第一个就跳出

    return country_qid

# get the located province qid
# def get_city_located_province_qid(entity, province_qids, country_qids):
#     self_qid = entity.get('id')
#     if self_qid in province_qids:
#         return self_qid

#     claims = entity.get('claims', {}).get('P131', [])
#     for claim in claims:
#         mainsnak = claim.get('mainsnak', {})
#         datavalue = mainsnak.get('datavalue', {})
#         value = datavalue.get('value', {})
#         qid = value.get('id')

#         if qid in country_qids:
#             return None

#         if qid in province_qids:
#             return qid

#     return None

def get_city_located_province_qid(entity, province_qids, country_qids):
    visited = set()
    MAX_DEPTH = 5  # 防止无限递归
    candidates = []

    def _find_province(qid, depth):
        if qid in visited or depth > MAX_DEPTH:
            return
        visited.add(qid)

        if qid in province_qids:
            candidates.append((qid, depth))
            return
        if qid in country_qids:
            return

        parent_entity = get_wikidata_entity(qid)
        claims = parent_entity.get('claims', {}).get('P131', [])
        for claim in claims:
            mainsnak = claim.get('mainsnak', {})
            datavalue = mainsnak.get('datavalue', {})
            value = datavalue.get('value', {})
            parent_qid = value.get('id')
            if parent_qid:
                _find_province(parent_qid, depth + 1)

    self_qid = entity.get('id')
    if self_qid in province_qids:
        return self_qid

    claims = entity.get('claims', {}).get('P131', [])
    for claim in claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid:
            _find_province(qid, 1)

    if candidates:
        # 取深度最小的那个省
        candidates.sort(key=lambda x: x[1])
        return candidates[0][0]
    return None



# check if the city is capital
def get_city_capital_of_qid_and_type(entity, province_qids, country_qids):
    now = datetime.now().year
    claims = entity.get('claims', {})
    p1376_claims = claims.get('P1376', [])

    for claim in p1376_claims:
        # === 判断时间是否仍有效 ===
        qualifiers = claim.get('qualifiers', {})
        start = qualifiers.get('P580', [])
        end = qualifiers.get('P582', [])

        def extract_year(time_obj):
            try:
                time_str = time_obj.get('datavalue', {}).get('value', {}).get('time', '')
                return int(time_str[1:5]) if time_str else None
            except:
                return None

        start_year = extract_year(start[0]) if start else None
        end_year = extract_year(end[0]) if end else None

        if (start_year and now < start_year) or (end_year and now > end_year):
            continue  # 该断言不在当前年份范围内，跳过

        # === 提取 QID 并判断类型 ===
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')

        if qid:
            if qid in country_qids:
                return qid, 'country'
            elif qid in province_qids:
                return qid, 'province'

    return None, None

# get the located city qid
# this function is recursive, it will find the city qid in the parent qids
def get_university_located_city_qid(entity, city_qids):
    visited = set()
    MAX_DEPTH = 5  
    def _find_city(qid, depth):
        if qid in visited or depth > MAX_DEPTH:
            return None
        visited.add(qid)
        if qid in city_qids:
            return qid
        up_entity = get_wikidata_entity(qid)
        claims = up_entity.get('claims', {})
        p131s = claims.get('P131', [])
        for claim in p131s:
            mainsnak = claim.get('mainsnak', {})
            datavalue = mainsnak.get('datavalue', {})
            value = datavalue.get('value', {})
            up_qid = value.get('id')
            if up_qid:
                result = _find_city(up_qid, depth + 1)
                if result:
                    return result
        return None

    claims = entity.get('claims', {})
    p131_claims = claims.get('P131', [])
    for claim in p131_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid:
            result = _find_city(qid, 1)
            if result:
                return result
    return None

# get the country qid
def get_university_country_qid(entity):
    claims = entity.get('claims', {})
    p17_claims = claims.get('P17', [])
    for claim in p17_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid:
            return qid
    return None

# check if the university is private or public
public_qids = {'Q875538', 'Q62078547'}     # public university
private_qids = {'Q902104', 'Q23002054'}    # private university

def get_university_type(entity, public_qids, private_qids):
    claims = entity.get('claims', {})
    p31_claims = claims.get('P31', [])
    for claim in p31_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid in public_qids:
            return 'public'
        if qid in private_qids:
            return 'private'
    return None

# founded year
def get_university_foundation_year(entity):
    claims = entity.get('claims', {})
    p571_claims = claims.get('P571', [])
    for claim in p571_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        time_str = value.get('time')
        if time_str and len(time_str) >= 5:
            return time_str[1:5]
    return None

# waterbody
def get_single_body_of_water_qid(entity):
    claims = entity.get('claims', {})
    p206_claims = claims.get('P206', [])

    water_qids = set()
    for claim in p206_claims:
        mainsnak = claim.get('mainsnak', {})
        datavalue = mainsnak.get('datavalue', {})
        value = datavalue.get('value', {})
        qid = value.get('id')
        if qid:
            water_qids.add(qid)

    if len(water_qids) == 1:
        return True, next(iter(water_qids))  
    else:
        return False, None






def build_university_expr(entity):
    uni_type = get_university_type(entity, public_qids, private_qids)
    if uni_type == 'public':
        kind_expr = 'publicKind'
    elif uni_type == 'private':
        kind_expr = 'privateKind'
    else:
        kind_expr = 'university_Kind'
    
    city_qid = get_university_located_city_qid(entity, set(cities.keys()))
    country_qid = get_university_country_qid(entity)

    print(f'[university] city_qid: {city_qid}, country_qid: {country_qid}')

    if city_qid and city_qid in cities and country_qid and country_qid in countries:
        location_expr = f'(CityCountryLocation {cities[city_qid]} {countries[country_qid]})'
        print(f'[university] CityCountryLocation: {location_expr}')
    elif country_qid and country_qid in countries:
        location_expr = f'(CountryLocation {countries[country_qid]})'
        print(f'[university] CountryLocation: {location_expr}')
    else:
        location_expr = 'noLocation'
        print(f'[university] no location found')

    year = get_university_foundation_year(entity)
    if year:
        attr_expr = f'(FoundedIn "{year}")'
    else:
        attr_expr = 'noAttr'

    expr_str = f'UniversityDescription {kind_expr} {location_expr} {attr_expr}'
    print(f'[university] expr_str: {expr_str}')
    expr = pgf.readExpr(expr_str)
    return expr


def build_city_expr(entity):
    province_qids = set(provinces.keys())
    country_qids = set(countries.keys())
    capital_of_qid, capital_type = get_city_capital_of_qid_and_type(entity, province_qids, country_qids)

    print(f'[city] capital_of_qid: {capital_of_qid}, capital_type: {capital_type}')

    if capital_type == 'country' and capital_of_qid in countries:
        print(f'[city] CountryForCaptial: {countries[capital_of_qid]}')
        expr_str = f'CountryForCaptial {countries[capital_of_qid]}'
        print(f'[city] expr_str: {expr_str}')
        expr = pgf.readExpr(expr_str)
        return expr

    elif capital_type == 'province' and capital_of_qid in provinces:
        country_qid = get_first_country_qid(entity)
        print(f'[city] ProvinceForCaptial: {provinces[capital_of_qid]}, country_qid: {country_qid}')
        if country_qid not in countries:
            raise ValueError(f"省会所属国家QID {country_qid} 不在 countries 字典中，数据异常！")
        expr_str = f'ProvinceForCaptial {provinces[capital_of_qid]} {countries[country_qid]}'
        print(f'[city] expr_str: {expr_str}')
        expr = pgf.readExpr(expr_str)
        return expr

    kind_qid = get_first_instance_of_qid(entity)
    kind_fun = city_kinds.get(kind_qid, 'Q515_City')
    kind_expr = kind_fun

    print(f'[city] kind_qid: {kind_qid}, kind_fun: {kind_fun}')

    province_qid = get_city_located_province_qid(entity, province_qids, country_qids)
    country_qid = get_first_country_qid(entity)
    print(f'[debug] province_qid = {province_qid}, in provinces = {province_qid in provinces}')
    print(f'[debug] country_qid = {country_qid}, in countries = {country_qid in countries}')

    if province_qid is not None and province_qid in provinces and country_qid is not None and country_qid in countries:
        location_expr = f'(ProvinceCountryLocation {provinces[province_qid]} {countries[country_qid]})'
        print(f'[city] ProvinceCountryLocation: {location_expr}')
    elif country_qid is not None and country_qid in countries:
        location_expr = f'(CountryLocation {countries[country_qid]})'
        print(f'[city] CountryLocation: {location_expr}')
    else:
        location_expr = 'noLocation'
        print(f'[city] no location found')

    expr_str = f'CityDescription {kind_expr} {location_expr}'
    print(f'[city] expr_str: {expr_str}')
    expr = pgf.readExpr(expr_str)
    return expr

def build_island_expr(entity):
    province_qids = set(provinces.keys())
    country_qids = set(countries.keys())
    waterbody_qids = set(waterbodies.keys())


    has_one_water, water_qid = get_single_body_of_water_qid(entity)
    print(f'[island] water_qid: {water_qid}')


    province_qid = get_city_located_province_qid(entity, province_qids, country_qids)
    country_qid = get_first_country_qid(entity)

    if province_qid and province_qid in provinces and country_qid and country_qid in countries:
        location_expr = f'(ProvinceCountryLocation {provinces[province_qid]} {countries[country_qid]})'
    elif country_qid and country_qid in countries:
        location_expr = f'(CountryLocation {countries[country_qid]})'
    else:
        location_expr = 'noLocation'


    kind_expr = 'Island'  

    if has_one_water and water_qid in waterbodies:
        expr_str = f'IslandDescription {waterbodies[water_qid]} {kind_expr} {location_expr}'
    else:
        expr_str = f'NoWaterIslandDescription {kind_expr} {location_expr}'

    print(f'[island] expr_str: {expr_str}')
    expr = pgf.readExpr(expr_str)
    return expr

def build_lake_expr(entity):
    province_qids = set(provinces.keys())
    country_qids = set(countries.keys())

    kind_expr = 'Lake'  # 默认所有 lake 都用同一个 WaterKinds 构造器

    province_qid = get_city_located_province_qid(entity, province_qids, country_qids)
    country_qid = get_first_country_qid(entity)

    if province_qid and province_qid in provinces and country_qid and country_qid in countries:
        location_expr = f'(ProvinceCountryLocation {provinces[province_qid]} {countries[country_qid]})'
    elif country_qid and country_qid in countries:
        location_expr = f'(CountryLocation {countries[country_qid]})'
    else:
        location_expr = 'noLocation'

    expr_str = f'LakeDescription {kind_expr} {location_expr}'
    print(f'[lake] expr_str: {expr_str}')
    expr = pgf.readExpr(expr_str)
    return expr




def build_description(qid, entity_type):
    entity = get_wikidata_entity(qid)
    if entity_type == 'university':
        expr = build_university_expr(entity)
    elif entity_type == 'city':
        expr = build_city_expr(entity)
    elif entity_type == 'island':
        expr = build_island_expr(entity)
    elif entity_type == 'lake':
        expr = build_lake_expr(entity)
    else:
        raise ValueError("Error")
    desc_zh = chinese.linearize(expr)
    desc_en = english.linearize(expr)
    return desc_zh, desc_en


if __name__ == "__main__":
    import sys
    if len(sys.argv) != 3:
        print("Usage: python script.py <QID> <city|university>")
        sys.exit(1)
    qid = sys.argv[1]
    entity_type = sys.argv[2]
    zh, en = build_description(qid, entity_type)
    print("中文：", zh)
    print("English:", en)