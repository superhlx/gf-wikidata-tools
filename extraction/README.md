# Building a lexicon from Wikidata labels

by Aarne Ranta 2024-25

A Python script for extracting multilingual GF lexica from Wikidata labels.

Modified from [gf-math](https://github.com/aarneranta/gf-math/tree/main/grammars/extraction) where it was used for building a lexicon for 5000 mathematical terms in 8 languages.

[Slides](https://docs.google.com/presentation/d/10Z9zz020SnyrIM8gSUVURDCUe-j4gzTGkefTNRcZx1g/edit?usp=sharing)

[YouTube video](https://www.youtube.com/watch?v=EQ-k_JQ7fDM)

## Building the basic lexicon with just the Wikidata labels

The first step is to collect the Wikidata labels that you want to have, from a list of QIDs (Wikidata item idenfiers of form Q*). This is covered in the subdirectory [data](/data). The directory contains an example file qid-lexicon.jsonl, which you can try out before fetching your own data.

After you have created qid-lexicon.jsonl (or just want to use the example file already in data), you can perform lexicon extraction as follows:
```
  ./build_lexicon.py (-first|-added) <fr> <Fre> <STEPNUM>+
```
with a sequence of some of the following steps:
-  Step 0: preparations  
-  Step 1: extract wikidata for that language into qlist  
-  Step 2: parse with UDPipe  
-  Step 3: use the UDPipe parse to clean up corpus and add to lexicon
-  Step 4: build a lexicon extension
-  Step 5: parse the terms with the extended lexicon  
-  Step 6: (if -first) generate GF modules for abstract and the first concrete  
-  Step 7: (if -add) add a new concrete syntax
-  Step 8: test your grammar in GF\n


To start the build (with no abstract syntax available):
```
   ./build_lexicon.py -first en Eng 1 2 3 4 5 6 8
```
To add a new language (when one language and an abstract syntax are in place):
```
  ./build_lexicon.py -add de Ger 1 2 3 4 5 7 8
```
For more information, take a look at `build_lexicon.py`.


## Building a derived lexicon

This is an experimental method to extract parts of Wikidata labels.
The current implementation extracts APs and CNs from adjectivally modified nouns.
You can run it with
```
  ./derived_lexicon.py <lang>+
```
3-letter language codes are used.
The procedure requires that you have the basic lexicon for the mentioned languages.
The first language (typically Eng) is used in the abstract syntax function names.


## Prerequisites

As you will see, this project is not yet neatly packaged, and you will need to acquire
at least the following manually:

- [gf-wikidata-tools](..), this GitHub repository; pull often, it is work in progress
- [GF, Grammatical Framework](https://www.grammaticalframework.org/); one of the binary
  packages from the Download directory should be enough if available for your architecture,
  but you can also clone and install the latest version from
  [gf-core](https://github.com/GrammaticalFramework/gf-core) if you have a
  [Haskell compiler](https://www.haskell.org/ghc/)
- Python 3, at least 3.10 (for structural pattern matching)
- the `pgf` library for GF runtime in Python, installed by `pip install pgf`; this presupposes
  the [C runtime of GF](https://github.com/GrammaticalFramework/gf-core/tree/master/src/runtime/c),
  which is a part of `gf-core`, but may also follow with `pip install pgf` for your architecture
- [GF Resource Grammar Library](https://github.com/GrammaticalFramework/gf-rgl);
  pull the latest version, because it has some updates used in this project, and do
  `make install` in its root directory. 
- Create a symlink to `gf-rgl/src/morphodict`. Add your own language there if is not yet included. You can start with an empty Morphodict*.gf if you don't have any data; the only necessary thing is that this file exists.
- [deptreepy](https://github.com/aarneranta/deptreepy), a Python library for analysing
  CoNLLU files, also providing a wrapper for UDPipe; create a symlink to its directory
  from here. 
- Add your language to deptreepy/udpipe2_models.py if it is not yet there.

All of this has been proven to work with Linux (Intel), Mac OS (Intel, ARM) and Windows (Intel),
but Mac ARM and Windows may have some issues. To resolve them, don't hesitate to look at
[GF Discord](https://discord.com/invite/EvfUsjzmaz) and pose a question there if needed.

