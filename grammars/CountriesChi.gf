concrete CountriesChi of Countries = open
  SyntaxChi,
  ParadigmsChi

in {

lincat Country = LinCountry ;

oper
  LinCountry : Type = {
    s : NP ;
    nationality : AP
    } ;

  mkCountry = overload {
    mkCountry : Str -> Str -> LinCountry = \c,n -> {s = mkNP (mkN c) ; nationality = mkAP (mkA n)} ;
    mkCountry : NP -> AP -> LinCountry = \np,ap -> {s = np ; nationality = ap}
    } ;

lin Q43287_German_Empire_Country = mkCountry "德意志帝国" "" ; -- another german
lin Q16_Canada_Country = mkCountry "加拿大" "加拿大" ;
lin Q258_South_Africa_Country = mkCountry "南非" "南非" ;
lin Q262_Algeria_Country = mkCountry "阿尔及利亚" "阿尔及利亚" ;
lin Q17_Japan_Country = mkCountry "日本" "日本" ;
lin Q265_Uzbekistan_Country = mkCountry "乌兹别克斯坦" "乌兹别克斯坦" ;
lin Q20_Norway_Country = mkCountry "挪威" "挪威" ;
lin Q298_Chile_Country = mkCountry "智利" "智利" ;
lin Q27_Ireland_Country = mkCountry "爱尔兰" "爱尔兰" ;
lin Q334_Singapore_Country = mkCountry "新加坡" "新加坡" ;
lin Q28_Hungary_Country = mkCountry "匈牙利" "匈牙利" ;
lin Q347_Liechtenstein_Country = mkCountry "列支敦士登" "列支敦士登" ;
lin Q398_Bahrain_Country = mkCountry "巴林" "巴林" ;  -- no nationality found
lin Q29_Spain_Country = mkCountry "西班牙" "西班牙" ;
lin Q399_Armenia_Country = mkCountry "亚美尼亚" "亚美尼亚" ;
lin Q30_United_States_Country = mkCountry "美国" "美国" ;
lin Q403_Serbia_Country = mkCountry "塞尔维亚" "塞尔维亚" ;
lin Q408_Australia_Country = mkCountry "澳大利亚" "澳大利亚" ;
lin Q31_Belgium_Country = mkCountry "比利时" "比利时" ;
lin Q414_Argentina_Country = mkCountry "阿根廷" "阿根廷" ;
lin Q419_Peru_Country = mkCountry "秘鲁" "秘鲁" ;
lin Q32_Luxembourg_Country = mkCountry "卢森堡" "卢森堡" ;
lin Q423_North_Korea_Country = mkCountry "朝鲜民主主义人民共和国" "朝鲜" ;  -- no nationality found
lin Q424_Cambodia_Country = mkCountry "柬埔寨" "柬埔寨" ;
lin Q33_Finland_Country = mkCountry "芬兰" "芬兰" ;
lin Q34_Sweden_Country = mkCountry "瑞典" "瑞典" ;
lin Q36_Poland_Country = mkCountry "波兰" "波兰" ;
lin Q574_Timor_Leste_Country = mkCountry "东帝汶" "东帝汶" ;  -- no nationality found
lin Q657_Chad_Country = mkCountry "乍得" "乍得" ;  -- no nationality found
lin Q37_Lithuania_Country = mkCountry "立陶宛" "立陶宛" ;
lin Q38_Italy_Country = mkCountry "意大利" "意大利" ;
lin Q664_New_Zealand_Country = mkCountry "新西兰" "新西兰" ;
lin Q668_India_Country = mkCountry "印度" "印度" ;
lin Q672_Tuvalu_Country = mkCountry "图瓦卢" "图瓦卢" ;  -- no nationality found
lin Q39_Switzerland_Country = mkCountry "瑞士" "瑞士" ;
lin Q678_Tonga_Country = mkCountry "汤加" "汤加" ;  -- no nationality found
lin Q683_Samoa_Country = mkCountry "萨摩亚" "萨摩亚" ;  -- no nationality found
lin Q40_Austria_Country = mkCountry "奥地利" "奥地利" ;
lin Q41_Greece_Country = mkCountry "希腊" "希腊" ;
lin Q685_Solomon_Islands_Country = mkCountry "所罗门群岛" "所罗门群岛" ;  -- no nationality found
lin Q686_Vanuatu_Country = mkCountry "瓦努阿图" "瓦努阿图" ;  -- no nationality found
lin Q691_Papua_New_Guinea_Country = mkCountry "巴布亚新几内亚" "巴布亚新几内亚" ;  -- no nationality found
lin Q43_Turkey_Country = mkCountry "土耳其" "土耳其" ;
lin Q695_Palau_Country = mkCountry "帕劳" "帕劳" ;  -- no nationality found
lin Q697_Nauru_Country = mkCountry "瑙鲁" "瑙鲁" ;  -- no nationality found
lin Q45_Portugal_Country = mkCountry "葡萄牙" "葡萄牙" ;
lin Q702_Federated_States_of_Micronesia_Country = mkCountry "密克罗尼西亚联邦" "密克罗尼西亚联邦" ;  -- no nationality found
lin Q77_Uruguay_Country = mkCountry "乌拉圭" "乌拉圭" ;
lin Q710_Kiribati_Country = mkCountry "基里巴斯" "基里巴斯" ;  -- no nationality found
lin Q709_Marshall_Islands_Country = mkCountry "马绍尔群岛" "马绍尔群岛" ;  -- no nationality found
lin Q79_Egypt_Country = mkCountry "埃及" "埃及" ;
lin Q711_Mongolia_Country = mkCountry "蒙古国" "蒙古" ;
lin Q712_Fiji_Country = mkCountry "斐济" "斐济" ;  -- no nationality found
lin Q717_Venezuela_Country = mkCountry "委内瑞拉" "委内瑞拉" ;
lin Q730_Suriname_Country = mkCountry "苏里南" "苏里南" ;  -- no nationality found
lin Q96_Mexico_Country = mkCountry "墨西哥" "墨西哥" ;
lin Q114_Kenya_Country = mkCountry "肯尼亚" "肯尼亚" ;
lin Q733_Paraguay_Country = mkCountry "巴拉圭" "巴拉圭" ;
lin Q115_Ethiopia_Country = mkCountry "埃塞俄比亚" "埃塞俄比亚" ;
lin Q117_Ghana_Country = mkCountry "加纳" "加纳" ;
lin Q734_Guyana_Country = mkCountry "圭亚那" "圭亚那" ;  -- no nationality found
lin Q736_Ecuador_Country = mkCountry "厄瓜多尔" "厄瓜多尔" ;
lin Q739_Colombia_Country = mkCountry "哥伦比亚" "哥伦比亚" ;
lin Q750_Bolivia_Country = mkCountry "玻利维亚" "玻利维亚" ;
lin Q142_France_Country = mkCountry "法国" "法国" ;
lin Q145_United_Kingdom_Country = mkCountry "英国" "英国" ;
lin Q754_Trinidad_and_Tobago_Country = mkCountry "特立尼达和多巴哥" "特立尼达和多巴哥" ;
lin Q757_Saint_Vincent_and_the_Grenadines_Country = mkCountry "圣文森特和格林纳丁斯" "圣文森特和格林纳丁斯" ;  -- no nationality found
lin Q760_Saint_Lucia_Country = mkCountry "圣卢西亚" "圣卢西亚" ;  -- no nationality found
lin Q148_People's_Republic_of_China_Country = mkCountry "中华人民共和国" "中国" ;
lin Q155_Brazil_Country = mkCountry "巴西" "巴西" ;
lin Q763_Saint_Kitts_and_Nevis_Country = mkCountry "圣基茨和尼维斯" "圣基茨和尼维斯" ;  -- no nationality found
lin Q766_Jamaica_Country = mkCountry "牙买加" "牙买加" ;
lin Q769_Grenada_Country = mkCountry "格林纳达" "格林纳达" ;
lin Q774_Guatemala_Country = mkCountry "危地马拉" "危地马拉" ;  -- no nationality found
lin Q159_Russia_Country = mkCountry "俄罗斯" "俄罗斯" ;
lin Q778_The_Bahamas_Country = mkCountry "巴哈马" "巴哈马" ;  -- no nationality found
lin Q781_Antigua_and_Barbuda_Country = mkCountry "安提瓜和巴布达" "安提瓜和巴布达" ;  -- no nationality found
lin Q183_Germany_Country = mkCountry "德国" "德国" ;
lin Q783_Honduras_Country = mkCountry "洪都拉斯" "洪都拉斯" ;  -- no nationality found
lin Q784_Dominica_Country = mkCountry "多米尼克" "多米尼克" ;  -- no nationality found
lin Q184_Belarus_Country = mkCountry "白俄罗斯" "白俄罗斯" ;
lin Q189_Iceland_Country = mkCountry "冰岛" "冰岛" ;
lin Q786_Dominican_Republic_Country = mkCountry "多米尼加" "多米尼加" ;
lin Q790_Haiti_Country = mkCountry "海地" "海地" ;
lin Q191_Estonia_Country = mkCountry "爱沙尼亚" "爱沙尼亚" ;
lin Q792_El_Salvador_Country = mkCountry "萨尔瓦多" "萨尔瓦多" ;  -- no nationality found
lin Q211_Latvia_Country = mkCountry "拉脱维亚" "拉脱维亚" ;
lin Q794_Iran_Country = mkCountry "伊朗" "伊朗" ;
lin Q212_Ukraine_Country = mkCountry "乌克兰" "乌克兰" ;
lin Q796_Iraq_Country = mkCountry "伊拉克" "伊拉克" ;
lin Q213_Czech_Republic_Country = mkCountry "捷克" "捷克" ;
lin Q800_Costa_Rica_Country = mkCountry "哥斯达黎加" "哥斯达黎加" ;
lin Q801_Israel_Country = mkCountry "以色列" "以色列" ;
lin Q214_Slovakia_Country = mkCountry "斯洛伐克" "斯洛伐克" ;
lin Q804_Panama_Country = mkCountry "巴拿马" "巴拿马" ;
lin Q215_Slovenia_Country = mkCountry "斯洛文尼亚" "斯洛文尼亚" ;
lin Q805_Yemen_Country = mkCountry "也门" "也门" ;  -- no nationality found
lin Q218_Romania_Country = mkCountry "罗马尼亚" "罗马尼亚" ;
lin Q217_Moldova_Country = mkCountry "摩尔多瓦" "摩尔多瓦" ;
lin Q219_Bulgaria_Country = mkCountry "保加利亚" "保加利亚" ;
lin Q810_Jordan_Country = mkCountry "约旦" "约旦" ;
lin Q811_Nicaragua_Country = mkCountry "尼加拉瓜" "尼加拉瓜" ;  -- no nationality found
lin Q813_Kyrgyzstan_Country = mkCountry "吉尔吉斯斯坦" "吉尔吉斯斯坦" ;
lin Q221_North_Macedonia_Country = mkCountry "北马其顿" "北马其顿" ;
lin Q817_Kuwait_Country = mkCountry "科威特" "科威特" ;  -- no nationality found
lin Q222_Albania_Country = mkCountry "阿尔巴尼亚" "阿尔巴尼亚" ;
lin Q819_Laos_Country = mkCountry "老挝" "老挝" ;
lin Q224_Croatia_Country = mkCountry "克罗地亚" "克罗地亚" ;
lin Q822_Lebanon_Country = mkCountry "黎巴嫩" "黎巴嫩" ;
lin Q225_Bosnia_and_Herzegovina_Country = mkCountry "波斯尼亚和黑塞哥维那" "波斯尼亚和黑塞哥维那" ;  -- no nationality found
lin Q826_Maldives_Country = mkCountry "马尔代夫" "马尔代夫" ;  -- no nationality found
lin Q833_Malaysia_Country = mkCountry "马来西亚" "马来西亚" ;
lin Q227_Azerbaijan_Country = mkCountry "阿塞拜疆" "阿塞拜疆" ;
lin Q836_Myanmar_Country = mkCountry "缅甸" "缅甸" ;  -- no nationality found
lin Q837_Nepal_Country = mkCountry "尼泊尔" "尼泊尔" ;  -- no nationality found
lin Q228_Andorra_Country = mkCountry "安道尔" "安道尔" ;  -- no nationality found
lin Q229_Cyprus_Country = mkCountry "塞浦路斯" "塞浦路斯" ;
lin Q230_Georgia_Country = mkCountry "格鲁吉亚" "格鲁吉亚" ;
lin Q842_Oman_Country = mkCountry "阿曼" "阿曼" ;  -- no nationality found
lin Q843_Pakistan_Country = mkCountry "巴基斯坦" "巴基斯坦" ;
lin Q232_Kazakhstan_Country = mkCountry "哈萨克斯坦" "哈萨克斯坦" ;
lin Q233_Malta_Country = mkCountry "马耳他" "马耳他" ;
lin Q846_Qatar_Country = mkCountry "卡塔尔" "卡塔尔" ;  -- no nationality found
lin Q851_Saudi_Arabia_Country = mkCountry "沙特阿拉伯" "沙特阿拉伯" ;
lin Q854_Sri_Lanka_Country = mkCountry "斯里兰卡" "斯里兰卡" ;
lin Q237_Vatican_City_Country = mkCountry "梵蒂冈" "梵蒂冈" ;  -- no nationality found
lin Q235_Monaco_Country = mkCountry "摩纳哥" "摩纳哥" ;  -- no nationality found
lin Q236_Montenegro_Country = mkCountry "黑山" "黑山" ;  -- no nationality found
lin Q858_Syria_Country = mkCountry "叙利亚" "叙利亚" ;
lin Q863_Tajikistan_Country = mkCountry "塔吉克斯坦" "塔吉克斯坦" ;
lin Q865_Taiwan_Country = mkCountry "中华民国" "中华民国" ;
lin Q238_San_Marino_Country = mkCountry "圣马力诺" "圣马力诺" ;  -- no nationality found
lin Q878_United_Arab_Emirates_Country = mkCountry "阿拉伯联合酋长国" "阿拉伯联合酋长国" ;  -- no nationality found
lin Q869_Thailand_Country = mkCountry "泰国" "泰国" ;
lin Q874_Turkmenistan_Country = mkCountry "土库曼斯坦" "土库曼斯坦" ;
lin Q242_Belize_Country = mkCountry "伯利兹" "伯利兹" ;  -- no nationality found
lin Q241_Cuba_Country = mkCountry "古巴" "古巴" ;
lin Q244_Barbados_Country = mkCountry "巴巴多斯" "巴巴多斯" ;  -- no nationality found
lin Q881_Vietnam_Country = mkCountry "越南" "越南" ;
lin Q252_Indonesia_Country = mkCountry "印度尼西亚" "印度尼西亚" ;
lin Q958_South_Sudan_Country = mkCountry "南苏丹" "南苏丹" ;  -- no nationality found
lin Q962_Benin_Country = mkCountry "贝宁" "贝宁" ;
lin Q963_Botswana_Country = mkCountry "博茨瓦纳" "博茨瓦纳" ;  -- no nationality found
lin Q884_South_Korea_Country = mkCountry "大韩民国" "韩国" ;
lin Q889_Afghanistan_Country = mkCountry "阿富汗" "阿富汗" ;  -- no nationality found
lin Q902_Bangladesh_Country = mkCountry "孟加拉国" "孟加拉国" ;
lin Q965_Burkina_Faso_Country = mkCountry "布基纳法索" "布基纳法索" ;
lin Q912_Mali_Country = mkCountry "马里" "马里" ;  -- no nationality found
lin Q967_Burundi_Country = mkCountry "布隆迪" "布隆迪" ;
lin Q970_Comoros_Country = mkCountry "科摩罗" "科摩罗" ;  -- no nationality found
lin Q971_Republic_of_the_Congo_Country = mkCountry "刚果共和国" "刚果共和国" ;
lin Q916_Angola_Country = mkCountry "安哥拉" "安哥拉" ;
lin Q917_Bhutan_Country = mkCountry "不丹" "不丹" ;  -- no nationality found
lin Q974_Democratic_Republic_of_the_Congo_Country = mkCountry "刚果民主共和国" "刚果民主共和国" ;  -- no nationality found
lin Q921_Brunei_Country = mkCountry "文莱" "文莱" ;  -- no nationality found
lin Q924_Tanzania_Country = mkCountry "坦桑尼亚" "坦桑尼亚" ;
lin Q977_Djibouti_Country = mkCountry "吉布提" "吉布提" ;  -- no nationality found
lin Q983_Equatorial_Guinea_Country = mkCountry "赤道几内亚" "赤道几内亚" ;  -- no nationality found
lin Q986_Eritrea_Country = mkCountry "厄立特里亚" "厄立特里亚" ;  -- no nationality found
lin Q928_Philippines_Country = mkCountry "菲律宾" "菲律宾" ;
lin Q929_Central_African_Republic_Country = mkCountry "中非共和国" "中非共和国" ;
lin Q1000_Gabon_Country = mkCountry "加蓬" "加蓬" ;
lin Q945_Togo_Country = mkCountry "多哥" "多哥" ;
lin Q1006_Guinea_Country = mkCountry "几内亚" "几内亚" ;  -- no nationality found
lin Q1005_The_Gambia_Country = mkCountry "冈比亚" "冈比亚" ;
lin Q948_Tunisia_Country = mkCountry "突尼斯" "突尼斯" ;
lin Q953_Zambia_Country = mkCountry "赞比亚" "赞比亚" ;
lin Q1007_Guinea_Bissau_Country = mkCountry "几内亚比绍" "几内亚比绍" ;  -- no nationality found
lin Q1008_Ivory_Coast_Country = mkCountry "科特迪瓦" "科特迪瓦" ;
lin Q1009_Cameroon_Country = mkCountry "喀麦隆" "喀麦隆" ;
lin Q200686_French_Fifth_Republic_Country = mkCountry "法兰西第五共和国" "" ;  -- historical
lin Q954_Zimbabwe_Country = mkCountry "津巴布韦" "津巴布韦" ;
lin Q756617_Kingdom_of_Denmark_Country = mkCountry "丹麦王国" "" ; -- another
lin Q1011_Cape_Verde_Country = mkCountry "佛得角" "佛得角" ;  -- no nationality found
lin Q219060_Palestine_Country = mkCountry "巴勒斯坦" "巴勒斯坦" ;
lin Q1013_Lesotho_Country = mkCountry "莱索托" "莱索托" ;
lin Q1014_Liberia_Country = mkCountry "利比里亚" "利比里亚" ;  -- no nationality found
lin Q1016_Libya_Country = mkCountry "利比亚" "利比亚" ;
lin Q1019_Madagascar_Country = mkCountry "马达加斯加" "马达加斯加" ;  -- no nationality found
lin Q1020_Malawi_Country = mkCountry "马拉维" "马拉维" ;
lin Q1025_Mauritania_Country = mkCountry "毛里塔尼亚" "毛里塔尼亚" ;
lin Q1027_Mauritius_Country = mkCountry "毛里求斯" "毛里求斯" ;  -- no nationality found
lin Q1028_Morocco_Country = mkCountry "摩洛哥" "摩洛哥" ;
lin Q1030_Namibia_Country = mkCountry "纳米比亚" "纳米比亚" ;
lin Q1029_Mozambique_Country = mkCountry "莫桑比克" "莫桑比克" ;  -- no nationality found
lin Q1032_Niger_Country = mkCountry "尼日尔" "尼日尔" ;
lin Q1033_Nigeria_Country = mkCountry "尼日利亚" "尼日利亚" ;
lin Q1036_Uganda_Country = mkCountry "乌干达" "乌干达" ;
lin Q1037_Rwanda_Country = mkCountry "卢旺达" "卢旺达" ;
lin Q1039_São_Tomé_and_Príncipe_Country = mkCountry "圣多美和普林西比" "圣多美和普林西比" ;  -- no nationality found
lin Q1041_Senegal_Country = mkCountry "塞内加尔" "塞内加尔" ;
lin Q1042_Seychelles_Country = mkCountry "塞舌尔" "塞舌尔" ;  -- no nationality found
lin Q1044_Sierra_Leone_Country = mkCountry "塞拉利昂" "塞拉利昂" ;
lin Q1045_Somalia_Country = mkCountry "索马里" "索马里" ;
lin Q1049_Sudan_Country = mkCountry "苏丹" "苏丹" ;
lin Q1050_Eswatini_Country = mkCountry "斯威士兰" "斯威士兰" ;  -- no nationality found
lin Q29999_Kingdom_of_the_Netherlands_Country = mkCountry "荷兰王国" "" ; -- another dutch
lin Q6744020_Mallabhum_Country = mkCountry "马拉布姆王国" "" ;  --  another   India
lin Q129619467_First_Republic_of_Seychelles_Country = mkCountry "塞舌尔第一共和国" "" ;  -- another Seychellois
lin Q131839713_Kingdom_of_Patones_Country = mkCountry "帕托内斯王国" "" ;  -- no nationality found another spain
lin Q12548_Holy_Roman_Empire_Country = mkCountry "神圣罗马帝国" "神圣罗马帝国" ;
lin Q153015_Kingdom_of_Saxony_Country = mkCountry "萨克森王国" "萨克森王国" ;  -- another german
lin Q148499_Margraviate_of_Brandenburg_Country = mkCountry "勃兰登堡边领" "勃兰登堡边领" ;
lin Q27306_Kingdom_of_Prussia_Country = mkCountry "普鲁士王国" "" ; -- another german
lin Q38872_Prussia_Country = mkCountry "普魯士" "普魯士" ;  -- another german
lin Q1206012_German_Reich_Country = mkCountry "德意志国" "" ; -- another german
lin Q577867_Kingdom_of_Poland_Country = mkCountry "波兰王国" "波兰王国" ;  -- another polan
lin Q10985258_German_Empire_Country = mkCountry "德意志帝国" "" ;  -- another german
lin Q41304_Weimar_Republic_Country = mkCountry "魏瑪共和国" "魏瑪共和国" ;  -- another german
lin Q35_Denmark_Country = mkCountry "丹麦" "丹麦" ;  
lin Q154741_Confederation_of_the_Rhine_Country = mkCountry "莱茵邦联" "莱茵邦联" ;  -- another german,historical
lin Q155570_Saxe_Weimar_Eisenach_Country = mkCountry "萨克森-魏玛-艾森纳赫" "萨克森-魏玛-艾森纳赫" ;  -- another german 
lin Q186320_Grand_Duchy_of_Baden_Country = mkCountry "巴登大公國" "巴登大公國" ;  -- another german
lin Q34266_Russian_Empire_Country = mkCountry "俄罗斯帝国" "俄罗斯帝国" ;  -- another russian,historical
lin Q159631_Kingdom_of_Wurttemberg_Country = mkCountry "符腾堡王国" "符腾堡王国" ;
lin Q15180_Soviet_Union_Country = mkCountry "苏联" "苏联" ;
lin Q160440_Crimean_Khanate_Country = mkCountry "克里米亚汗国" "克里米亚汗国" ;  
lin Q172107_PolishLithuanian_Commonwealth_Country = mkCountry "波兰立陶宛联邦" "波兰立陶宛联邦" ;  -- problem
lin Q156020_State_of_the_Teutonic_Order_Country = mkCountry "条顿骑士团国" "条顿骑士团国" ;  -- no nationality found
lin Q529605_Electorate_of_Hesse_Country = mkCountry "黑森选侯国" "黑森选侯国" ;  -- no nationality found,historical
lin Q154195_Kingdom_of_Bavaria_Country = mkCountry "巴伐利亚王国" "巴伐利亚王国" ;  -- no nationality found,historical
lin Q1055_Hamburg_Country = mkCountry "汉堡" "汉堡" ;
lin Q153091_Duchy_of_Prussia_Country = mkCountry "普鲁士公国" "普鲁士公国" ;  -- no nationality found,historical
lin Q675127_Palatinate_Neuburg_Country = mkCountry "普法尔茨-诺伊堡" "普法尔茨-诺伊堡" ;  -- no nationality found,historical
lin Q16550783_Duchy_of_Anhalt_Country = mkCountry "安哈尔特公国" "安哈尔特公国" ;  -- no nationality found,historical
lin Q552033_Bavaria_Munich_Country = mkCountry "巴伐利亚-慕尼黑" "巴伐利亚-慕尼黑" ;  -- another german,historical
lin Q600018_Kingdom_of_Hungary_Country = mkCountry "匈牙利王国" "匈牙利王国" ;  
lin Q645981_Roman_Catholic_Diocese_of_Halberstadt_Country = mkCountry "哈爾伯施塔特" "哈爾伯施塔特" ;  -- problem
lin Q164079_Kingdom_of_Hanover_Country = mkCountry "汉诺威王国" "汉诺威王国" ;  -- another german,historical
lin Q186096_Tsardom_of_Russia_Country = mkCountry "俄罗斯沙皇国" "俄罗斯沙皇国" ;  -- another russian,historical
lin Q326029_Duchy_of_Brunswick_Country = mkCountry "不伦瑞克公国" "不伦瑞克公国" ;  -- another german,historical
lin Q42199_Principality_of_Ansbach_Country = mkCountry "勃兰登堡-安斯巴赫" "勃兰登堡-安斯巴赫" ;  -- another german,historical
lin Q693669_Grand_Duchy_of_Oldenburg_Country = mkCountry "奥尔登堡大公国" "奥尔登堡大公国" ;  -- another german,historical
lin Q156199_Electorate_of_Saxony_Country = mkCountry "萨克森选侯国" "萨克森选侯国" ;  -- another roman empire,historical
lin Q131964_Austrian_Empire_Country = mkCountry "奥地利帝国" "奥地利帝国" ;
lin Q28513_Austria_Hungary_Country = mkCountry "奥匈帝国" "奥匈帝国" ;  -- another austrian,historical
lin Q173065_Kingdom_of_Naples_Country = mkCountry "那不勒斯王国" "那不勒斯王国" ;  -- another italian,historical
lin Q155019_Duchy_of_Lorraine_Country = mkCountry "洛林公国" "洛林公国" ;  -- another french,historical
lin Q533534_Cisleithania_Country = mkCountry "內萊塔尼亞" "內萊塔尼亞" ;  -- another austrian,historical
lin Q1133431_Artuqids_Country = mkCountry "阿尔图格王朝" "阿尔图格王朝" ;  -- problem
lin Q129286_British_Raj_Country = mkCountry "英属印度" "英属印度" ;  -- another english,historical
lin Q174193_United_Kingdom_of_Great_Britain_and_Ireland_Country = mkCountry "大不列颠及爱尔兰联合王国" "大不列颠及爱尔兰联合王国" ;  -- another english,historical
lin Q172579_Kingdom_of_Italy_Country = mkCountry "意大利王国" "意大利王国" ;  -- another italian,historical
lin Q2277_Roman_Empire_Country = mkCountry "罗马帝国" "罗马帝国" ;  -- people born there are called Roman
lin Q389004_Wallachia_Country = mkCountry "瓦拉几亚公国" "瓦拉几亚公国" ;  -- another romanian,historical
lin Q1031430_Habsburg_Netherlands_Country = mkCountry "哈布斯堡荷蘭" "哈布斯堡荷蘭" ;  -- another dutch,historical
lin Q55_Netherlands_Country = mkCountry "荷兰" "荷兰" ;
lin Q11750528_Duchy_of_Moscow_Country = mkCountry "莫斯科公国" "" ;  -- another russian,historical
lin Q153529_Duchy_of_Milan_Country = mkCountry "米兰公国" "米兰公国" ;  -- another italian,historical
lin Q49697_Liu_Song_dynasty_Country = mkCountry "刘宋" "刘宋" ;  -- another chinese,historical
lin Q274488_Eastern_Wu_Country = mkCountry "东吴" "东吴" ;  -- another chinese,historical
lin Q170174_Papal_States_Country = mkCountry "教皇国" "教皇国" ;  -- problem
lin Q171150_Kingdom_of_Hungary_Country = mkCountry "匈牙利王国" "匈牙利王国" ;  -- another hungarian,historical
lin Q203493_Kingdom_of_Romania_Country = mkCountry "罗马尼亚王国" "罗马尼亚王国" ;  -- another romanian,historical
lin Q12536_Abbasid_Caliphate_Country = mkCountry "阿拔斯王朝" "阿拔斯王朝" ;  -- another arab,historical
lin Q179876_Kingdom_of_England_Country = mkCountry "英格兰王国" "英格兰王国" ;
lin Q844930_Classical_Athens_Country = mkCountry "古雅典" "古雅典" ;
lin Q45670_Kingdom_of_Portugal_Country = mkCountry "葡萄牙王國" "葡萄牙王國" ;  -- another portuguese,historical
lin Q154849_Grand_Duchy_of_Tuscany_Country = mkCountry "托斯卡纳大公国" "托斯卡纳大公国" ;  -- another italian,historical
lin Q70972_Kingdom_of_France_Country = mkCountry "法兰西王国" "法兰西王国" ;  -- another french,historical
lin Q7462_Song_dynasty_Country = mkCountry "宋朝" "宋朝" ;  -- another chinese,historical
lin Q12544_Byzantine_Empire_Country = mkCountry "拜占庭帝国" "拜占庭帝国" ;  -- people born there are called Byzantine
lin Q1747689_Ancient_Rome_Country = mkCountry "古罗马" "古罗马" ;  -- people born there are called Roman
lin Q75613_Almoravid_dynasty_Country = mkCountry "穆拉比特王朝" "穆拉比特王朝" ;  -- another arab,historical
lin Q169460_Miletus_Country = mkCountry "米利都" "米利都" ;  -- another greek,historical
lin Q161885_Kingdom_of_Great_Britain_Country = mkCountry "大不列颠王国" "大不列颠王国" ;  -- another english,historical
lin Q63134381_Khwarazmian_Empire_Country = mkCountry "花剌子模帝国" "花剌子模帝国" ;  -- another persian,historical
lin Q2017684_French_protectorate_of_Tunisia_Country = mkCountry "法属突尼斯" "法属突尼斯" ;  -- another tunisian,historical
lin Q31945_Arabian_Peninsula_Country = mkCountry "阿拉伯半岛" "阿拉伯半岛" ;  -- another arab,historical
lin Q208169_Republic_of_Ragusa_Country = mkCountry "拉古萨共和国" "拉古萨共和国" ;  -- another croatian,historical
lin Q215530_Kingdom_of_Ireland_Country = mkCountry "爱尔兰王国" "爱尔兰王国" ;  -- another english,historical
lin Q230791_Kingdom_of_Scotland_Country = mkCountry "苏格兰王国" "苏格兰王国" ;  -- another english,historical
lin Q23366230_Republic_of_Geneva_Country = mkCountry "日内瓦共和国" "日内瓦共和国" ;  -- another swiss,historical
lin Q320930_Cao_Wei_Country = mkCountry "曹魏" "曹魏" ;  -- another chinese,historical
lin Q64576860_Lordship_of_Bologna_Country = mkCountry "未知" "未知" ;  -- another italian,historical
lin Q4948_Republic_of_Venice_Country = mkCountry "威尼斯共和国" "威尼斯共和国" ;  -- people born there are called Venetian
lin Q170072_Dutch_Republic_Country = mkCountry "荷兰共和国" "荷兰共和国" ;  -- another dutch,historical
lin Q1147037_Eastern_Han_Country = mkCountry "东汉" "东汉" ;  -- another chinese,historical
lin Q148540_Republic_of_Florence_Country = mkCountry "佛罗伦萨共和国" "佛罗伦萨共和国" ;  -- another italian,historical
lin Q249578_Ghaznavid_Empire_Country = mkCountry "加茲尼王朝" "加茲尼王朝" ;  -- another persian,historical
lin Q13426199_Republic_of_China_Country = mkCountry "中华民国大陆时期" "中华民国大陆时期" ;
lin Q221457_Congress_Poland_Country = mkCountry "波兰会议王国" "波兰会议王国" ;  -- another polish,historical
lin Q217196_Crown_of_Castile_Country = mkCountry "卡斯提尔联合王国" "卡斯提尔联合王国" ;  -- another spanish,historical
lin Q48685_Kingdom_of_Judah_Country = mkCountry "猶大王國" "猶大王國" ;  -- another jewish,historical
lin Q273874_Buyid_dynasty_Country = mkCountry "白益王朝" "白益王朝" ;  -- another persian,historical
lin Q178084_Ilkhanate_Country = mkCountry "伊利汗国" "伊利汗国" ;  -- another mongol,historical
lin Q7313_Yuan_dynasty_Country = mkCountry "元朝" "元朝" ;  -- another chinese,historical
lin Q389688_Achaemenid_Empire_Country = mkCountry "阿契美尼德帝国" "阿契美尼德帝国" ;  -- another persian,historical
lin Q484195_Timurid_Empire_Country = mkCountry "帖木儿帝国" "帖木儿帝国" ;  -- another turco-mongol,historical
lin Q204920_Crown_of_Aragon_Country = mkCountry "阿拉贡联合王国" "阿拉贡联合王国" ;  -- another spanish,historical
lin Q2252973_Duchy_of_Florence_Country = mkCountry "佛羅倫斯公國" "佛羅倫斯公國" ;  -- another italian,historical
lin Q1649871_Kingdom_of_Poland_Country = mkCountry "波蘭王國" "波蘭王國" ;  -- another polish,historical
lin Q47261_Duchy_of_Bavaria_Country = mkCountry "巴伐利亚公国" "巴伐利亚公国" ;  -- another german,historical
lin Q435583_Old_Swiss_Confederacy_Country = mkCountry "舊瑞士邦聯" "舊瑞士邦聯" ;  -- another swiss,historical
lin Q4420718_ancient_Syracuse_Country = mkCountry "未知" "未知" ;  -- another greek,historical
lin Q1365493_Republic_of_Pisa_Country = mkCountry "比萨共和国" "比萨共和国" ;  -- another italian,historical
lin Q2227570_Duchy_of_Wurttemberg_Country = mkCountry "符腾堡公国" "符腾堡公国" ;  -- another german,historical
lin Q22_Scotland_Country = mkCountry "苏格兰" "苏格兰" ;  -- another english,historical
lin Q1072949_Western_Han_Country = mkCountry "西汉" "西汉" ;  -- another chinese,historical
lin Q13580795_Samos_Country = mkCountry "未知" "未知" ;  -- another greek,historical
lin Q33061_Taifa_of_Sarakusta_Country = mkCountry "薩拉戈薩王國" "薩拉戈薩王國" ;  -- another arab,historical
lin Q8575586_Umayyad_Caliphate_Country = mkCountry "倭马亚哈里发国" "倭马亚哈里发国" ;  -- another arab,historical
lin Q12150341_Samanid_Empire_Country = mkCountry "萨曼帝國" "萨曼帝國" ;  -- another persian,historical
lin Q153136_Habsburg_monarchy_Country = mkCountry "哈布斯堡君主国" "哈布斯堡君主国" ;  -- another austrian,historical
lin Q158151_Saxe_Altenburg_Country = mkCountry "萨克森-阿尔滕堡" "萨克森-阿尔滕堡" ;  -- another german,historical
lin Q1233672_County_of_Barcelona_Country = mkCountry "巴塞隆納伯國" "巴塞隆納伯國" ;  -- another spanish,historical
lin Q11768_Ancient_Egypt_Country = mkCountry "古埃及" "古埃及" ;  -- another egyptian,historical
lin Q3708094_Seljuk_Empire_Country = mkCountry "塞尔柱帝国" "塞尔柱帝国" ;  -- another turkic,historical
lin Q871091_British_Malaya_Country = mkCountry "英属马来亚" "英属马来亚" ;  -- another english,historical
lin Q1236847_Lordship_of_Kniphausen_Country = mkCountry "未知" "未知" ;  -- another german,historical
lin Q694594_Duchy_of_Bremen_and_Verden_Country = mkCountry "不来梅-维尔登" "不来梅-维尔登" ;  -- another german,historical
lin Q693551_Landgraviate_of_Hesse_Darmstadt_Country = mkCountry "黑森-达姆施塔特伯爵領地" "黑森-达姆施塔特伯爵領地" ;  -- another german,historical
lin Q3139179_Hohenlohe_Kirchberg_Country = mkCountry "霍恩洛厄-基希貝格" "霍恩洛厄-基希貝格" ;  -- another german,historical
lin Q561334_Prince_Bishopric_of_Bamberg_Country = mkCountry "班贝格采邑主教" "班贝格采邑主教" ;  -- another german,historical
lin Q26167_Duchy_of_Schleswig_Country = mkCountry "石勒蘇益格" "石勒蘇益格" ;  -- another danish,historical
lin Q16957_German_Democratic_Republic_Country = mkCountry "东德" "东德" ;  -- another german,historical
lin Q13427044_Prince_Bishopric_of_Wurzburg_Country = mkCountry "维尔茨堡主教区" "维尔茨堡主教区" ;  -- another german,historical
lin Q20135_Grand_Duchy_of_Hesse_Country = mkCountry "黑森-达姆施塔特" "黑森-达姆施塔特" ;  -- another german,historical
lin Q696640_Duchy_of_Pomerania_Country = mkCountry "波美拉尼亚公国" "波美拉尼亚公国" ;  -- another german,historical
lin Q1410_Gibraltar_Country = mkCountry "直布罗陀" "直布罗陀" ;
lin Q2281221_Principality_of_Orange_Country = mkCountry "奧蘭治親王國" "奧蘭治親王國" ;  -- another french,historical
lin Q43048_Rhodes_Country = mkCountry "罗得岛" "罗得岛" ;  -- another greek,historical
lin Q207272_Second_Polish_Republic_Country = mkCountry "波兰第二共和国" "波兰第二共和国" ;  -- another polish,historical
lin Q330533_Seventeen_Provinces_Country = mkCountry "17個省" "17個省" ;  -- another dutch,historical
lin Q49683_Grand_Duchy_of_Lithuania_Country = mkCountry "立陶宛大公国" "立陶宛大公国" ;  -- another lithuanian,historical
lin Q9903_Ming_dynasty_Country = mkCountry "明朝" "明朝" ;  -- another chinese,historical
lin Q33946_Czechoslovakia_Country = mkCountry "捷克斯洛伐克" "捷克斯洛伐克" ;  -- another czech,historical
lin Q188712_Empire_of_Japan_Country = mkCountry "大日本帝国" "大日本帝国" ;  -- another japanese,historical
lin Q62651_DenmarkNorway_Country = mkCountry "丹麥-挪威" "丹麥-挪威" ;  -- another danish,historical
lin Q8733_Qing_dynasty_Country = mkCountry "清朝" "清朝" ;  -- another chinese,historical
lin Q4453007_Tashkent_Khanate_Country = mkCountry "未知" "未知" ;  -- another uzbek,historical
lin Q62633_Grand_Principality_of_Finland_Country = mkCountry "芬兰大公国" "芬兰大公国" ;  -- another finnish,historical
lin Q11225429_Thebes_Country = mkCountry "古底比斯" "古底比斯" ;  -- another greek,historical
lin Q211274_Polish_People_s_Republic_Country = mkCountry "波兰人民共和国" "波兰人民共和国" ;  -- another polish,historical
lin Q15102440_Kingdom_of_Serbs_Croats_and_Slovenes_Country = mkCountry "未知" "未知" ;  -- another yugoslav,historical
lin Q241748_Kingdom_of_Serbia_Country = mkCountry "塞尔维亚王国" "塞尔维亚王国" ;  -- another serbian,historical
lin Q171740_Caliphate_of_Cordoba_Country = mkCountry "后倭马亚王朝" "后倭马亚王朝" ;  -- another arab,historical
lin Q1337854_emirate_of_Cordoba_Country = mkCountry "科尔多瓦酋长国" "科尔多瓦酋长国" ;  -- another arab,historical
lin Q583038_Ostrogothic_Kingdom_Country = mkCountry "東哥德王國" "東哥德王國" ;  -- no nationality found,historical
lin Q4734309_Alokopennesos_Country = mkCountry "未知" "未知" ;  -- another greek,historical
lin Q11772_Ancient_Greece_Country = mkCountry "古希腊" "古希腊" ;  -- another greek,historical
lin Q29520_China_Country = mkCountry "中国" "中国" ;
lin Q160307_Fatimid_Caliphate_Country = mkCountry "法蒂玛王朝" "法蒂玛王朝" ;  -- another arab,historical
lin Q12560_Ottoman_Empire_Country = mkCountry "奥斯曼帝国" "奥斯曼帝国" ;  -- another turkish,historical
lin Q42585_Kingdom_of_Bohemia_Country = mkCountry "波希米亞王國" "波希米亞王國" ;  -- another czech,historical
lin Q13526919_Kroton_Country = mkCountry "未知" "未知" ;  -- another greek,historical
lin Q622783_Spanish_Netherlands_Country = mkCountry "西屬尼德蘭" "西屬尼德蘭" ;  -- another spanish,historical
lin Q193714_Mandatory_Palestine_Country = mkCountry "英属巴勒斯坦托管地" "英属巴勒斯坦托管地" ;  -- another palestinian,historical
lin Q70802_French_Third_Republic_Country = mkCountry "法兰西第三共和国" "法兰西第三共和国" ;  -- another french,historical
lin Q684030_Principality_of_Serbia_Country = mkCountry "塞尔维亚公国" "塞尔维亚公国" ;  -- another serbian,historical
lin Q180393_Kingdom_of_the_Two_Sicilies_Country = mkCountry "两西西里王国" "两西西里王国" ;  -- another italian,historical
lin Q158835_Prince_Bishopric_of_Liege_Country = mkCountry "列日采邑主教區" "列日采邑主教區" ;  -- another belgian,historical
lin Q6581823_Southern_Netherlands_Country = mkCountry "南尼德蘭" "南尼德蘭" ;  -- another belgian,historical
lin Q551067_Northern_Zhou_Country = mkCountry "北周" "北周" ;  -- another chinese,historical
lin Q487829_Chagatai_Khanate_Country = mkCountry "察合台汗国" "察合台汗国" ;  -- another mongol,historical
lin Q9683_Tang_dynasty_Country = mkCountry "唐朝" "唐朝" ;  -- another chinese,historical
lin Q7209_Han_dynasty_Country = mkCountry "汉朝" "汉朝" ;  -- another chinese,historical
lin Q5066_Jin_dynasty_Country = mkCountry "金朝" "金朝" ;  -- another chinese,historical
lin Q13498_Taranto_Country = mkCountry "塔兰托" "塔兰托" ;  -- another italian,historical
lin Q2022162_Kingdom_of_Pergamon_Country = mkCountry "帕加马王国" "帕加马王国" ;  -- another greek,historical
lin Q252580_Duchy_of_Modena_and_Reggio_Country = mkCountry "摩德納和雷焦公國" "摩德納和雷焦公國" ;  -- another italian,historical
lin Q174306_Republic_of_Genoa_Country = mkCountry "热那亚共和国" "热那亚共和国" ;  -- another italian,historical
lin Q80702_Spanish_Empire_Country = mkCountry "西班牙帝国" "西班牙帝国" ;  -- another spanish,historical
lin Q1233764_Doric_hexapolis_Country = mkCountry "多丽丝" "多丽丝" ;  -- another greek,historical
lin Q2305208_Russian_Socialist_Federative_Soviet_Republic_Country = mkCountry "蘇維埃俄國" "蘇維埃俄國" ;  -- another russian,historical
lin Q2396442_Kingdom_of_Galicia_and_Lodomeria_Country = mkCountry "加利西亚和洛多梅里亚王国" "加利西亚和洛多梅里亚王国" ;  -- another polish,historical
lin Q319460_Northern_Song_dynasty_Country = mkCountry "北宋" "北宋" ;  -- another chinese,historical
lin Q83286_Socialist_Federal_Republic_of_Yugoslavia_Country = mkCountry "南斯拉夫社会主义联邦共和国" "南斯拉夫社会主义联邦共和国" ;  -- another yugoslav,historical
lin Q49696_Northern_and_Southern_dynasties_Country = mkCountry "南北朝" "南北朝" ;  -- another chinese,historical
lin Q3149991_Ancient_India_Country = mkCountry "古印度" "古印度" ;  -- another indian,historical
lin Q21_England_Country = mkCountry "英格兰" "英格兰" ;
lin Q123559_al_Andalus_Country = mkCountry "安达卢斯" "安达卢斯" ;
lin Q21_England_Country = mkCountry "英格兰" "英格兰" ;
lin Q123559_al_Andalus_Country = mkCountry "安达卢斯" "安达卢斯" ;  -- another spanish,historical
lin Q33296_Mughal_Empire_Country = mkCountry "莫卧儿帝国" "莫卧儿帝国" ;  -- another indian,historical
lin Q108865218_Lebanese_Republic_under_French_mandate_Country = mkCountry "未知" "未知" ;  -- another lebanese,historical
lin Q656954_Soli_Country = mkCountry "未知" "未知" ;  -- another greek,historical
lin Q6681_Crotone_Country = mkCountry "克罗托内" "克罗托内" ;  -- another italian,historical
lin Q704300_Free_City_of_Frankfurt_Country = mkCountry "法蘭克福自由市" "法蘭克福自由市" ;  -- another german,historical
lin Q256961_Electorate_of_Bavaria_Country = mkCountry "巴伐利亚选帝侯國" "巴伐利亚选帝侯國" ;  -- another german,historical
lin Q836680_Duchy_of_Nassau_Country = mkCountry "拿騷" "拿騷" ;  -- another german,historical
lin Q18234383_Safavid_Iran_Country = mkCountry "薩法維帝國" "薩法維帝國" ;  -- another iranian,historical
lin Q15864_United_Kingdom_of_the_Netherlands_Country = mkCountry "荷蘭聯合王國" "荷蘭聯合王國" ;  -- another dutch,historical
lin Q157070_County_of_Flanders_Country = mkCountry "佛兰德伯国" "佛兰德伯国" ;  -- another belgian,historical
lin Q170603_New_Spain_Country = mkCountry "新西班牙总督辖区" "新西班牙总督辖区" ;  -- another mexican,historical
lin Q30623_Manchukuo_Country = mkCountry "满洲国" "满洲国" ;  -- another chinese,historical
lin Q188161_Dutch_East_Indies_Country = mkCountry "荷属东印度" "荷属东印度" ;  -- another indonesian,historical
lin Q2662372_Principality_of_Minsk_Country = mkCountry "未知" "未知" ;  -- another belarusian,historical
lin Q7318_Nazi_Germany_Country = mkCountry "纳粹德国" "纳粹德国" ;  -- another german,historical
lin Q25_Wales_Country = mkCountry "威尔士" "威尔士" ;
lin Q8646_Hong_Kong_Country = mkCountry "香港" "香港" ;
lin Q165154_Kingdom_of_Sardinia_Country = mkCountry "萨丁尼亚王国" "萨丁尼亚王国" ;  -- another italian,historical
lin Q170770_Grand_Principality_of_Moscow_Country = mkCountry "莫斯科大公国" "莫斯科大公国" ;  -- another russian,historical
lin Q34754_Somaliland_Country = mkCountry "索马里兰" "索马里兰" ;  -- another somali,historical
lin Q212439_Cossack_Hetmanate_Country = mkCountry "哥萨克酋长国" "哥萨克酋长国" ;  -- another ukrainian,historical
lin Q107258515_Pahlavi_Iran_Country = mkCountry "伊朗王國" "伊朗王國" ;  -- another iranian,historical
lin Q133356_Ukrainian_Soviet_Socialist_Republic_Country = mkCountry "乌克兰苏维埃社会主义共和国" "乌克兰苏维埃社会主义共和国" ;  -- another ukrainian,historical
lin Q9676_Isle_of_Man_Country = mkCountry "马恩岛" "马恩岛" ;
lin Q702224_Duchy_of_Carinthia_Country = mkCountry "卡林西亞公爵" "卡林西亞公爵" ;  -- another austrian,historical
lin Q28179_Joseon_Country = mkCountry "朝鲜王朝" "朝鲜王朝" ;  -- another korean,historical
lin Q137816_Taiwan_under_Japanese_rule_Country = mkCountry "台湾日治时期" "台湾日治时期" ;  -- another taiwanese,historical
lin Q243610_Ukrainian_People_s_Republic_Country = mkCountry "乌克兰人民共和国" "乌克兰人民共和国" ;  -- another ukrainian,historical
lin Q42406_English_people_Country = mkCountry "英格蘭人" "英格蘭人" ;  -- another english,historical
lin Q1246_Kosovo_Country = mkCountry "科索沃" "科索沃" ;
lin Q28025_Ryukyu_Kingdom_Country = mkCountry "琉球国" "琉球国" ;  -- another japanese,historical
lin Q26234937_First_Syrian_Republic_Country = mkCountry "敘利亞第一共和國" "敘利亞第一共和國" ;  -- another syrian,historical
lin Q124943_Kingdom_of_Egypt_Country = mkCountry "埃及王国" "埃及王国" ;  -- another egyptian,historical
lin Q3431885_Sallarid_dynasty_Country = mkCountry "萨拉里王朝" "萨拉里王朝" ;  -- another iranian,historical
lin Q131337_Azerbaijan_Soviet_Socialist_Republic_Country = mkCountry "阿塞拜疆苏维埃社会主义共和国" "阿塞拜疆苏维埃社会主义共和国" ;  -- another azerbaijani,historical
lin Q426025_Duchy_of_Savoy_Country = mkCountry "萨伏依公国" "萨伏依公国" ;  -- another italian,historical
lin Q12060881_Chinese_Empire_Country = mkCountry "帝制中国" "帝制中国" ;  -- another chinese,historical
lin Q1183_Puerto_Rico_Country = mkCountry "波多黎各" "波多黎各" ;
lin Q2184_Russian_Soviet_Federative_Socialist_Republic_Country = mkCountry "俄罗斯苏维埃联邦社会主义共和国" "俄罗斯苏维埃联邦社会主义共和国" ;  -- another russian,historical
lin Q1290149_Federal_People_s_Republic_of_Yugoslavia_Country = mkCountry "未知" "未知" ;  -- another yugoslav,historical
lin Q6744657_Crown_Colony_of_Malta_Country = mkCountry "马耳他直辖殖民地" "马耳他直辖殖民地" ;  -- another maltese,historical
lin Q151624_German_Confederation_Country = mkCountry "德意志邦联" "德意志邦联" ;  -- another german,historical
lin Q188586_Kingdom_of_Sicily_Country = mkCountry "西西里王国" "西西里王国" ;  -- another italian,historical
lin Q785_Jersey_Country = mkCountry "泽西" "泽西" ;
lin Q130229_Georgian_Soviet_Socialist_Republic_Country = mkCountry "格鲁吉亚苏维埃社会主义共和国" "格鲁吉亚苏维埃社会主义共和国" ;  -- another georgian,historical
lin Q158445_Grand_Duchy_of_Mecklenburg_Schwerin_Country = mkCountry "梅克伦堡-什未林大公国" "梅克伦堡-什未林大公国" ;  -- another german,historical
lin Q9648_Falkland_Islands_Country = mkCountry "福克兰群岛" "福克兰群岛" ;
lin Q200464_Portuguese_Empire_Country = mkCountry "葡萄牙帝国" "葡萄牙帝国" ;  -- another portuguese,historical
lin Q31354462_Republic_of_Abkhazia_Country = mkCountry "阿布哈兹共和国" "阿布哈兹共和国" ;
lin Q209857_Kingdom_of_LombardyVenetia_Country = mkCountry "伦巴第-威尼西亚王国" "伦巴第-威尼西亚王国" ;  -- another italian,historical
lin Q1054923_British_Hong_Kong_Country = mkCountry "英属香港" "英属香港" ;  -- another chinese,historical
lin Q713750_West_Germany_Country = mkCountry "西德" "西德" ;  -- another german,historical
lin Q264970_Anhalt_Kothen_Country = mkCountry "安哈尔特-克滕" "安哈尔特-克滕" ;  -- another german,historical
lin Q21203_Aruba_Country = mkCountry "阿鲁巴" "阿鲁巴" ;
lin Q18097_Korea_Country = mkCountry "朝鲜地区" "朝鲜地区" ;
lin Q211435_Viceroyalty_of_Peru_Country = mkCountry "秘鲁总督区" "秘鲁总督区" ;  -- another peruvian,historical
lin Q2162698_Duchy_of_Bohemia_Country = mkCountry "波希米亚公国" "波希米亚公国" ;  -- another czech,historical
lin Q2670751_Margraviate_of_Moravia_Country = mkCountry "摩拉维亚伯国" "摩拉维亚伯国" ;  -- another czech,historical
lin Q205662_Tokugawa_shogunate_Country = mkCountry "江户幕府" "江户幕府" ;  -- another japanese,historical
lin Q503585_Korea_under_Japanese_rule_Country = mkCountry "日治朝鲜" "日治朝鲜" ;  -- another korean,historical
lin Q170895_Moldavian_Soviet_Socialist_Republic_Country = mkCountry "摩尔达维亚苏维埃社会主义共和国" "摩尔达维亚苏维埃社会主义共和国" ;  -- another moldovan,historical
lin Q85842461_Aleman_Country = mkCountry "未知" "未知" ;  -- no nationality found,historical
lin Q8680_British_Empire_Country = mkCountry "大英帝国" "大英帝国" ;  -- another british,historical
lin Q12738_Neuchatel_Country = mkCountry "纳沙泰尔州" "纳沙泰尔州" ;  -- another swiss,historical
lin Q245160_Democratic_Republic_of_Georgia_Country = mkCountry "格鲁吉亚民主共和国" "格鲁吉亚民主共和国" ;  -- another georgian,historical
}