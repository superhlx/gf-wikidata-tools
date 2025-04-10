import sys
import json
import pgf

# assumes gf -make Descriptions???.gf in ../grammars/

GRAMMAR = '../grammars/Descriptions.pgf'

# DATA_FILE = 'Cities.json'
# if sys.argv[1:]:
#     DATA_FILE = sys.argv[1]

BIG_POPULATION = 1000000

grammar = pgf.readPGF(GRAMMAR)

# with open(DATA_FILE) as file:
#     if DATA_FILE.endswith('.jsonl'):
#         data = [json.loads(line) for line in file]
#     else:
#         data = json.load(file)

# if 'city' in DATA_FILE.lower():
#     entity_type = 'city'
# elif 'university' in DATA_FILE.lower():
#     entity_type = 'university'
# else:
#     entity_type = 'unknown'



region_functions = {f.split('_')[0]: f for f in grammar.functions if f.endswith('_Region')}
country_functions = {f.split('_')[0]: f for f in grammar.functions if f.endswith('_Country')}

def city_description(country, property=None):
    if country:
        qid = country[len('http://www.wikidata.org/entity/'):]
        fun = country_functions.get(qid)

        if property and fun:
            expr_str = f'CityDescription ({property} city_Kind) (CountryLocation {fun})'
        elif fun:
            expr_str = f'CityDescription city_Kind (CountryLocation {fun})'
        else:
            expr_str = 'city_Kind'

        return pgf.readExpr(expr_str)
        

def university_description(entity):
    props = entity.get('prop', {})

    country_uri = props.get('country')
    country_qid = country_uri.split('/')[-1] if country_uri else None
    country_fun = country_functions.get(country_qid)

    city_uri = props.get('location') 
    city_qid = city_uri.split('/')[-1] if city_uri else None
    city_fun = region_functions.get(city_qid)

    inception = props.get('inception', '')
    # year = inception.split('-')[0] if inception else ''
    # attr_expr = f'(FoundedIn "{year}")' if year else 'noAttr'
    attr_expr = 'noAttr'

    if city_fun and country_fun:
        location_expr = f'(RegionCountryLocation {city_fun} {country_fun})'
    elif country_fun:
        location_expr = f'(CountryLocation {country_fun})'
    else:
        location_expr = 'noLocation'  

    instance_of = props.get('instance_of', [])
    is_public = 'Q875538' in instance_of
    is_private = 'Q902104' in instance_of

    kind_expr = 'university_Kind'
    if is_public:
        kind_expr = f'(publicKind {kind_expr})'
    elif is_private:
        kind_expr = f'(privateKind {kind_expr})'

    expr_str = f'UniversityDescription {kind_expr} {location_expr} {attr_expr}'

    return pgf.readExpr(expr_str)




def population(city):
    if p := city.get('population', None):
        if p.isdigit():
            return int(p)
    return 0

def capital(city):
    return bool(city.get('prop', {}).get('capital', False))

english = grammar.languages['DescriptionsEng']
# chinese = grammar.languages['DescriptionsChi']
# greek = grammar.languages['DescriptionsGre']
# swedish = grammar.languages['DescriptionsSwe']

# for city in data:
#     country = city['prop']['country']
#     if capital(city):
#         tree = city_description(country, 'capitalKind')
#     elif population(city) > BIG_POPULATION:
#         tree = city_description(country, 'bigKind')
#     elif t := city_description(country):
#         tree = t
#     else:
#         tree = pgf.readExpr('city_Kind')
#     if tree is not None:
#         print(city['labels']['en'], tree)
#         print(city['labels']['en'], english.linearize(tree))
#         print(city['labels']['zh'], ''.join([c for c in chinese.linearize(tree) if not c.isspace()]))
#         print(city['labels']['sv'], swedish.linearize(tree))
#         print(city['labels']['el'], greek.linearize(tree))


