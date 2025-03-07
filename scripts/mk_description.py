import sys
import json
import pgf

# assumes gf -make Descriptions???.gf in ../grammars/

GRAMMAR = '../grammars/Descriptions.pgf'

DATA_FILE = 'Cities.json'
if sys.argv[1:]:
    DATA_FILE = sys.argv[1]

BIG_POPULATION = 1000000

grammar = pgf.readPGF(GRAMMAR)

with open(DATA_FILE) as file:
    if DATA_FILE.endswith('.jsonl'):
        data = [json.loads(line) for line in file]
    else:
        data = json.load(file)

city_functions = {f.split('_')[0]: f for f in grammar.functions}

def city_description(country, property=None):
    if country:
        qid = country[len('http://www.wikidata.org/entity/'):]
        if fun := city_functions.get(qid, None):
            if property and fun:
                fun = f'CityDescription ({property} city_Kind) (CountryLocation {fun})'
            elif fun:
                fun = f'CityDescription city_Kind (CountryLocation {fun})'
            else:
                fun = 'city_Kind'
            return pgf.readExpr(fun)

def population(city):
    if p := city.get('population', None):
        if p.isdigit():
            return int(p)
    return 0

english = grammar.languages['DescriptionsEng']
chinese = grammar.languages['DescriptionsChi']
greek = grammar.languages['DescriptionsGre']
swedish = grammar.languages['DescriptionsSwe']

for city in data:
    country = city['country']
    if population(city) > BIG_POPULATION:
        tree = city_description(country, 'bigKind')
    elif t := city_description(country):
        tree = t
    else:
        tree = pgf.readExpr('city_Kind')
    if tree is not None:
        print(city['labels']['en'], tree)
        print(city['labels']['en'], english.linearize(tree))
        print(city['labels']['zh'], ''.join([c for c in chinese.linearize(tree) if not c.isspace()]))
        print(city['labels']['sv'], swedish.linearize(tree))
        print(city['labels']['el'], greek.linearize(tree))


