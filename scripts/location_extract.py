import json
from urllib.parse import urlparse

# 设置文件路径
jsonl_path = "University (2).jsonl"

# 用于存储唯一的 location QID
location_entities = set()

# 打开并读取 JSONL 文件
with open(jsonl_path, "r", encoding="utf-8") as f:
    for line in f:
        record = json.loads(line)
        # 尝试获取 location 字段
        location_url = record.get("prop", {}).get("location")
        if location_url:
            # 从 URL 中提取 QID（如 Q23169）
            entity_id = urlparse(location_url).path.split("/")[-1]
            location_entities.add(entity_id)

# 转换为列表并排序
sorted_entities = sorted(location_entities)

# 输出前10个结果作为示例
for qid in sorted_entities[:10]:
    print(qid)

# 如果需要保存到文件（可选）
# with open("location_qids.txt", "w", encoding="utf-8") as f_out:
#     for qid in sorted_entities:
#         f_out.write(qid + "\n")