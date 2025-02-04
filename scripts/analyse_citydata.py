import json

"""
Reorganizing a datafile to give it more structure and convert to jsonl.
"""


DATA_FILE = 'City_Query_example.json'

OUTFILE = 'City.jsonl'

with open(DATA_FILE) as file:
    data = json.load(file)

def reorder(item):
    return {
        'url': item['city'],
        'labels': {
            'en': item.get('cityLabelEN', None),
            'el': item.get('cityLabelEL', None),
            'jp': item.get('cityLabelJP', None),
            'sv': item.get('cityLabelSV', None),
            'zh': item.get('cityLabelZH', None)
            },
        'descriptions': {
            'en': item.get('descriptionEN', None),
            'el': item.get('descriptionEL', None),
            'jp': item.get('descriptionJP', None),
            'sv': item.get('descriptionSV', None),
            'zh': item.get('descriptionZH', None)
            }
          }
    

for item in data:
    print(json.dumps(reorder(item), ensure_ascii=False))

