import re
from pathlib import Path

# 输入文件
region_path = Path("Region.gf")
regioneng_path = Path("RegionEng.gf")

# 输出文件
region_fixed = Path("Region_cleaned.gf")
regioneng_fixed = Path("RegionEng_cleaned.gf")

# 字符清洗函数：仅保留 ASCII 字母数字和下划线
def normalize_identifier(identifier):
    return ''.join(c if c.isascii() and (c.isalnum() or c == '_') else '_' for c in identifier)

# 处理 Region.gf
def clean_region_file():
    with open(region_path, encoding="utf-8") as f:
        lines = f.readlines()

    cleaned = []
    for line in lines:
        match = re.match(r'\s*fun\s+([^\s:]+)\s*:\s*Region\s*;', line)
        if match:
            original = match.group(1)
            cleaned_id = normalize_identifier(original)
            cleaned.append(f"fun {cleaned_id} : Region ;\n")
        else:
            cleaned.append(line)

    region_fixed.write_text(''.join(cleaned), encoding="utf-8")

# 处理 RegionEng.gf
def clean_regioneng_file():
    with open(regioneng_path, encoding="utf-8") as f:
        lines = f.readlines()

    cleaned = []
    for line in lines:
        match = re.match(r'\s*([^\s=]+)\s*=\s*mkNP\s*\(mkPN\s*"([^"]+)"\)\s*;', line)
        if match:
            original = match.group(1)
            value = match.group(2)
            cleaned_id = normalize_identifier(original)
            cleaned.append(f"{cleaned_id} = mkNP (mkPN \"{value}\") ;\n")
        else:
            cleaned.append(line)

    regioneng_fixed.write_text(''.join(cleaned), encoding="utf-8")

# 执行清洗
clean_region_file()
clean_regioneng_file()
print("✅ 已生成干净版本：Region_cleaned.gf 和 RegionEng_cleaned.gf")