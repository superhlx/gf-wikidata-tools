import json

"""
Reorganizing a datafile to give it more structure and convert to jsonl.
"""


DATA_FILE = 'City_Query_example.json'

OUTFILE = 'City.jsonl'

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

with open(DATA_FILE) as file:
    data = json.load(file)
    data = [reorder(d) for d in data]
    languages = data[0]['labels'].keys()

for item in data:
    print(json.dumps(item, ensure_ascii=False))


print("# Items:", len(data))
print("# Labels:", {lang: len([
        d for d in data if d['labels'][lang]]) for lang in languages})
print("# Descriptions:", {lang: len([
        d for d in data if d['descriptions'][lang]]) for lang in languages})
