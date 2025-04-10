import json
from urllib.parse import urlparse
import requests
import time
from tqdm import tqdm


jsonl_path = "/home/heluxue/Wikidata-Thesis/Alldata/University.jsonl"
location_qids = set()

with open(jsonl_path, "r", encoding="utf-8") as f:
    for line in f:
        record = json.loads(line)
        location_url = record.get("prop", {}).get("location")
        if location_url:
            qid = urlparse(location_url).path.split("/")[-1]
            location_qids.add(qid)

# 转为列表形式（可用于 get_qid_labels 函数）
qid_list = sorted(location_qids)



LANG = "en"  # 使用英文输出（可设为 "zh"）

def get_entity_data(qid, lang=LANG):
    url = "https://www.wikidata.org/w/api.php"
    params = {
        "action": "wbgetentities",
        "ids": qid,
        "format": "json",
        "props": "labels|claims",
        "languages": lang
    }

    response = requests.get(url, params=params)
    if response.status_code != 200:
        print(f"❌ API 请求失败：{qid}")
        return None

    data = response.json()
    entity = data["entities"].get(qid)
    if not entity:
        return None

    label = entity.get("labels", {}).get(lang, {}).get("value", qid)
    claims = entity.get("claims", {})

    p31 = [c["mainsnak"]["datavalue"]["value"]["id"]
           for c in claims.get("P31", []) if "datavalue" in c["mainsnak"]]
    p131 = [c["mainsnak"]["datavalue"]["value"]["id"]
            for c in claims.get("P131", []) if "datavalue" in c["mainsnak"]]

    return {
        "label": label,
        "p31": p31,
        "p131": p131
    }

# ===== 判断是否为城市（QID或字符串匹配）=====
def is_city(p31_qids, lang=LANG):
    known_city_qids = {"Q515", "Q3957", "Q1549591"}

    for pid in p31_qids:
        if pid in known_city_qids:
            return True

        data = get_entity_data(pid, lang)
        if data:
            label = data.get("label", "").lower()
            if any(word in label for word in ["city", "town", "municipality"]):
                return True
        time.sleep(0.2)
    return False

# ===== 判断是否要返回上一级城市 =====
def find_parent_if_city(qid, lang=LANG):
    data = get_entity_data(qid, lang)
    if not data:
        return qid, qid

    label = data["label"]
    p131 = data.get("p131", [])

    if not p131:
        return qid, label

    parent_qid = p131[0]
    parent_data = get_entity_data(parent_qid, lang)

    if parent_data and is_city(parent_data.get("p31", []), lang):
        return parent_qid, parent_data["label"]

    return qid, label

# ===== 构造 GF fun 与 lin 输出 =====
def to_gf_fun_line(qid, label):
    safe_label = label.replace(" ", "_").replace("(", "").replace(")", "")
    return f"fun {qid}_{safe_label}_Region : Region ;"

def to_gf_lin_line(qid, label):
    safe_label = label.replace(" ", "_").replace("(", "").replace(")", "")
    return f'lin {qid}_{safe_label}_Region = mkNP (mkPN "{label}") ;'

# ===== 主流程 =====
seen = set()
fun_lines = []
lin_lines = []

for qid in tqdm(qid_list, desc="Processing QIDs"):
    real_qid, real_label = find_parent_if_city(qid)
    key = (real_qid, real_label)

    if key in seen:
        continue

    seen.add(key)
    fun_lines.append(to_gf_fun_line(real_qid, real_label))
    lin_lines.append(to_gf_lin_line(real_qid, real_label))

# ===== 保存到文件 =====
with open("Region.gf", "w", encoding="utf-8") as f:
    f.write("\n".join(fun_lines))

with open("RegionEng.gf", "w", encoding="utf-8") as f:
    f.write("\n".join(lin_lines))