

import collections
import pandas as pd

# 读取 CoNLL-U 文件
file_path = "/home/heluxue/gf-wikidata-tools/conllu_data/city/cities_en.conllu"
output_file = "pos_frequency_analysis.csv"  # 修改为当前目录下

# 解析 CoNLL-U 文件
pos_counts = collections.defaultdict(lambda: collections.Counter())

with open(file_path, "r", encoding="utf-8") as f:
    for line in f:
        if line.startswith("#") or not line.strip():
            continue
        parts = line.split("\t")
        if len(parts) > 4:
            form, pos = parts[1], parts[3]  # 第4列是UPOS（词性）
            pos_counts[pos][form] += 1

# 统计每个词性中最常见的前50个词
pos_stats = []
for pos, forms in pos_counts.items():
    for form, freq in forms.most_common(50):
        pos_stats.append((pos, form, freq))

# 转换为 DataFrame 并按词频排序
df = pd.DataFrame(pos_stats, columns=["POS", "Form", "Frequency"])
df = df.sort_values(by="Frequency", ascending=False)

# 保存结果到 CSV 文件
df.to_csv(output_file, index=False, encoding="utf-8", header=True)

# 在终端打印前50行数据
print(df.head(50))
print(f"Results saved to {output_file}")
