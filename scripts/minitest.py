from mk_description import university_description, grammar, english
import json


entity = {
    "url": "http://www.wikidata.org/entity/Q16955",
    "labels": {
        "en": "Tsinghua University",
        "el": "Πανεπιστήμιο Τσινγκχουά",
        "jp": "清華大学",
        "sv": "Tsinghuauniversitetet",
        "zh": "清华大学",
        "bn": "ছিংহুয়া বিশ্ববিদ্যালয়"
    },
    "descriptions": {
        "en": "public university in Beijing, China",
        "el": None,
        "jp": "中国・北京市にある国立大学",
        "sv": None,
        "zh": "中华人民共和国北京市综合性大学",
        "bn": "চীনের রাজধানী বেইজিংয়ে অবস্থিত উচ্চশিক্ষা প্রতিষ্ঠান"
    },
    "domain": "university",
    "prop": {
        "location": "http://www.wikidata.org/entity/Q956",
        "country": "http://www.wikidata.org/entity/Q148",
        "inception": "1911"
    }
}

tree = university_description(entity)
print("English:", english.linearize(tree))
