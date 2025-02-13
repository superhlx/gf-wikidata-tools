import sys
import json

"""
Reorganizing a datafile to give it more structure and convert to jsonl.

Query for data:

select * {
  ?city wdt:P31/wdt:P279* wd:Q515 
}
"""

help_message = "usage: analyse_wikidata (labels|descriptions|both|gf-labels) lang? infile? cat?"

MODE = None
if sys.argv[1:]:
    MODE = sys.argv[1]

LANG = 'en'
if sys.argv[2:]:
    LANG = sys.argv[2]


FIRST_DATA_FILE = 'City_Query_example.json'

INFILE = 'City_merged.jsonl'
if sys.argv[3:]:
    INFILE = sys.argv[3]


CAT = 'Country'
if sys.argv[4:]:
    INFILE = sys.argv[4]


def reorder(item):
    return {
        'url': item['city'],
        'labels': {
            'bn': item.get('cityLabelBN', None),
            'en': item.get('cityLabelEN', None),
            'el': item.get('cityLabelEL', None),
            'ja': item.get('cityLabelJA', None),
            'sv': item.get('cityLabelSV', None),
            'zh': item.get('cityLabelZH', None)
            },
        'descriptions': {
            'bn': item.get('descriptionBN', None),
            'en': item.get('descriptionEN', None),
            'el': item.get('descriptionEL', None),
            'ja': item.get('descriptionJA', None),
            'sv': item.get('descriptionSV', None),
            'zh': item.get('descriptionZH', None)
            }
          }

def quote(s):
    return '\"' + s + '\"'

def mk_gf(ditem, lang, cat):
    id = d['url']
    eng = '_'.join(str(d['labels']['en']).split())
    label = d['labels'][LANG]
    prefix = 'http://www.wikidata.org/entity/'
    fun = '_'.join([id[len(prefix):], eng, cat])
    print('fun', fun, ':', cat, ';')
    if label:
        print('lin', fun, '=', 'mk' + cat, quote(label), ';')


# reorder the first version of data
if __name__ == '__main__':
    if MODE == 'raw':
        with open(FIRST_DATA_FILE) as file:
            data = json.load(file)
            data = [reorder(d) for d in data]
            languages = data[0]['labels'].keys()
        for item in data:
            print("# Items:", len(data))
        print("# Labels:", {lang: len([
                d for d in data if d['labels'][lang]]) for lang in languages})
        print("# Descriptions:", {lang: len([
              d for d in data if d['descriptions'][lang]]) for lang in languages})
    else:
        with open(INFILE) as file:
            data = [json.loads(line) for line in file]
            languages = data[0]['labels'].keys()

        if MODE == 'statistics':
            print("# Items:", len(data))
            print("# Labels:", {lang: len([
                   d for d in data if d['labels'][lang]]) for lang in languages})
            print("# Descriptions:", {lang: len([
                   d for d in data if d['descriptions'][lang]]) for lang in languages})
        elif MODE == 'labels':
            for d in data:
                print(d['labels'][LANG])
        elif MODE == 'gf-labels':
            for d in data:
                print(mk_gf(d, LANG, CAT))
        elif MODE == 'descriptions':
            for d in data:
                print(d['descriptions'][LANG])
                print()
        elif MODE == 'both':
            for d in data:
                print(d['labels'][LANG], '\t', d['descriptions'][LANG])
        else:
            print(help_message)

            


