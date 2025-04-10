from pathlib import Path

# 你想支持的年份区间
start_year = 0
end_year = 2025

# 输出路径
year_file = Path("Year.gf")
yeareng_file = Path("YearEng.gf")

def generate_year_module(start, end):
    lines = ["abstract Year = {"]
    lines.append("cat Year ;")
    for y in range(start, end + 1):
        lines.append(f"fun Y{y} : Year ;")
    lines.append("}")
    return "\n".join(lines)

def generate_yeareng_module(start, end):
    lines = ["concrete YearEng of Year = open SyntaxEng, ParadigmsEng in {"]
    lines.append("lincat Year = NP ;")
    for y in range(start, end + 1):
        lines.append(f'lin Y{y} = mkNP (mkPN "{y}") ;')
    lines.append("}")
    return "\n".join(lines)

# 写入文件
year_file.write_text(generate_year_module(start_year, end_year), encoding="utf-8")
yeareng_file.write_text(generate_yeareng_module(start_year, end_year), encoding="utf-8")

print(f"✅ 生成完成：{year_file.name}, {yeareng_file.name}")
