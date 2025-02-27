import json
import pgf

# assumes gf -make Descriptions???.gf in ../grammars/

GRAMMAR = '../grammars/Descriptions.pgf'
DATA = 'Cities.json'

BIG_POPULATION = 1000000

grammar = pgf.readPGF(GRAMMAR)

with open(DATA) as file:
    data = json.load(file)

city_functions = {f.split('_')[0]: f for f in grammar.functions}

def city_description(country, property=None):
    if country:
        qid = country[len('http://www.wikidata.org/entity/'):]
        if fun := city_functions.get(qid, None):
            if property:
                return f'CityDescription ({property} city_Kind) (CountryLocation {fun})'
            else:
                return f'CityDescription city_Kind (CountryLocation {fun})'

def population(city):
    return city.get('population', int(city['url'][-1])*200000)  # mock up

english = grammar.languages['DescriptionsEng']
chinese = grammar.languages['DescriptionsChi']
greek = grammar.languages['DescriptionsGre']
swedish = grammar.languages['DescriptionsSwe']

for city in data:
    country = city['country']
    if population(city) > BIG_POPULATION:
        tree = pgf.readExpr(city_description(country, 'bigKind'))
    else:
        tree = pgf.readExpr(city_description(country))
    print(city['labels']['en'], english.linearize(tree))
    print(city['labels']['zh'], ''.join([c for c in chinese.linearize(tree) if not c.isspace()]))
    print(city['labels']['sv'], swedish.linearize(tree))
    print(city['labels']['el'], greek.linearize(tree))


