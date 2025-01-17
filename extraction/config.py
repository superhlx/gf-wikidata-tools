"""
File names and paths used for reading and writing data.
The minimal adaptation to your proiect is to change

- DOMAIN
- WIKIDATA_FILE

"""

# json and tmp files are stored in out, GF files in the current dir

DOMAIN = 'Math'
WIKIDATA_FILE = 'data/qid-lexicon.jsonl'

# these can normally be left as they are

OUT = 'out/'
CORPUS_FILE = OUT + 'corpus.tmp'
NO_WIKILABEL = 'NOWIKILABEL'
DOMAIN_TERMS = DOMAIN+'Terms'
QDICT_SYNOPSIS_FILE = OUT+DOMAIN_TERMS+'_synopsis.json'

