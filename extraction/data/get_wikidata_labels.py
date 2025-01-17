"""
To fetch wikidata for a given set of items (of form Q*) and extract the labels for those.

Example of such an item:

  https://www.wikidata.org/wiki/Special:EntityData/Q18644475.json

The first step is to get a list of Q-ids of items, for instance, with a SPARQL query in
https://query.wikidata.org/ downloaded into QUERY_JSON_FILE.
"""

import urllib.request
import json
import sys

QUERY_JSON_FILE = 'query.json'
ENTITY_PREFIX = 'http://www.wikidata.org/entity/'
QIDS_TMP_FILE = 'qids.tmp'
QIDS_JSONL_FILE = 'qids.jsonl'
ENTITY_DATA_URL = 'https://www.wikidata.org/wiki/Special:EntityData/'
QID_LEXICON_FILE = 'qid-lexicon.jsonl'

# To create the file qs.tmp with one item per line from 
def get_wikidata_items():
    with open(QUERY_JSON_FILE) as file:
        its = json.load(file)
        length = len(ENTITY_PREFIX)
        js = [it['item'][length:] for it in its]
    with open(QIDS_TMP_FILE, 'w') as file:
        for j in js:
            file.write(j + '\n')


# to fetch all data about these items; this can take a lot of time
def get_wikidata_jsonl():
    with open(QIDS_TMP_FILE) as file:
        qids = [line.strip() for line in file]

    with open(QIDS_JSONL_FILE, 'w') as outfile:
        for qid in qids:
            try:
                url = ENTITY_DATA_URL + qid +'.json'
                print('fetching', url)
                with urllib.request.urlopen(url) as url:
                    data = json.load(url)
                    outfile.write(json.dumps(data) + '\n')
            except:
                pass


# To use QIDS_JSONL_FILE to collect labels, direct to qid-lexicon.jsonl
def wikidata2lexicon():
    with open(QIDS_JSONL_FILE) as infile:
        with open(QID_LEXICON_FILE, 'w') as outfile:
            for line in infile:
                dict = json.loads(line)
                qids = dict.get('entities', {})
                labels = (list(qids.keys())[0], list(qids.values())[0].get('labels', {}))
                labdict = {labels[0]: {lab: labels[1][lab]['value'] for lab in labels[1]}}
                outfile.write(json.dumps(labdict, ensure_ascii=False)+'\n')


# to get statistics about the languages covered
def print_wikidata_stats():
    langs = {}
    with open(QID_LEXICON_FILE) as file:
        for line in file:
            dict = json.loads(line)
            labels = list(dict.values())[0]
            for lang in labels:
                langs[lang] = langs.get(lang, 0) + 1
        print(langs)
        print({lang: n for lang, n in langs.items() if n>99})
        print(len(langs))


if __name__ == '__main__':
    # get_wikidata_items()
    # get_wikidata_jsonl()
    wikidata2lexicon()

    print_wikidata_stats()

