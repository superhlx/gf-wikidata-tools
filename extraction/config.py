"""
File names and paths used for reading and writing data.
The minimal adaptation to your proiect is to change

- DOMAIN
- WIKIDATA_FILE

"""

# json and tmp files are stored in out, GF files in the current dir

DOMAIN = 'Math'
WIKIDATA_FILE = 'data/qid-lexicon.jsonl'

NO_WIKILABEL = 'NOWIKILABEL'
EXTRACT_PGF_FILE = 'Extract' + LANG + 'Abs.pgf'
EXTRACT_CNC_NAME = 'Extract' + LANG
QLIST_FILE = 'out/qlist_' + LANG + '.json'
NEW_QLIST_FILE = 'out/new_qlist_' + LANG + '.json'
QDICT_FILE = 'out/qdict_' + LANG + '.json'
CORPUS_FILE = 'out/corpus.tmp'
CONLLU_PARSED_FILE = 'out/terms_' + LANG + '.conllu'
UD_LEXICON_FILE = 'out/lexicon_' + LANG + '.json'
MORPHODICT_CNC =  'MorphoDict' + LANG
MORPHODICT_FILE = MORPHODICT_CNC + 'Abs.pgf'
DOMAIN_WORDS_CNC_PREFIX = DOMAIN + 'Words'
DOMAIN_WORDS_ABS = DOMAIN_WORDS_CNC_PREFIX + LANG + 'Abs'
DOMAIN_TERMS = DOMAIN+'Terms'
QDICT_SYNOPSIS_FILE = 'out/'+DOMAIN_TERMS+'_synopsis.json'
