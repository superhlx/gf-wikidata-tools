concrete DescriptionsChi of Descriptions = CountriesChi,  CitiesChi, ProvincesChi, CityKindsChi, WaterbodiesChi **

open
  SyntaxChi,
  ParadigmsChi,
  (L = LexiconChi),
  ConstructorsChi,
  SymbolicChi,
  Prelude,
  ResChi

in {

lincat
  Description = CN ;
  Location = Adv ;
  UniversityKinds = CN ;
  Attribute = Adv ;
  IslandKinds = CN ;
  WaterKinds = CN ;

lin
-- common grammars

  CityCountryLocation city country = SyntaxChi.mkAdv (mkPrep "") (SyntaxChi.mkNP city (np2adv country.s)) ;  
  ProvinceCountryLocation province country = SyntaxChi.mkAdv (mkPrep "") (SyntaxChi.mkNP province (np2adv country.s)) ; 
  CountryLocation country = SyntaxChi.mkAdv (mkPrep "") country.s ;
  noLocation = ParadigmsChi.mkAdv "" (ATPlace False) False ; 

-- city grammars
  ProvinceForCaptial province country = mkCN (mkN "首府") (SyntaxChi.mkAdv (mkPrep "") (SyntaxChi.mkNP province (np2adv country.s))) ; 
  CountryForCaptial country = mkCN (mkN "首都") (SyntaxChi.mkAdv (mkPrep "") country.s) ;
  CityDescription kind location = mkCN kind location ;

-- universiity grammars
  university_Kind  = mkCN (mkN "大学") ;  
  publicKind  = mkCN (mkN "公立大学") ;       
  privateKind  = mkCN (mkN "私立大学") ;    

  UniversityDescription kind location attr = mkCN (mkCN kind location) attr ; 

  FoundedIn year = SyntaxChi.mkAdv (mkPrep "建立于") (symb (year.s ++ "年")) ;
  noAttr = ParadigmsChi.mkAdv "" (ATPlace False) True ;

-- island grammars
-- 某国某省的岛屿，位于某海
  Island = mkCN (mkN "岛屿") ;
  IslandDescription water kind location = mkCommaCN (NoWaterIslandDescription kind location) (mkAdv (mkPrep "位于") water) ;
  NoWaterIslandDescription kind location = mkCN kind location ;

-- lake grammars
-- 某国某省的湖泊
  Lake = mkCN (mkN "湖泊") ;
  LakeDescription lake location = mkCN lake location ;


oper
  np2adv : ResChi.NP -> Adv =
  \np -> ss (linNP np) ** {advType = ATPlace False ; hasDe = True ; lock_Adv = <>} ;

  mkCommaCN : CN -> Adv -> CN =
  \cn,adv -> cn ** {s = cn.s ++ "，" ++ adv.s } ;

  addYearsToCN : CN -> Str -> CN =
  \cn,years -> cn ** {s = cn.s ++ " " ++ years } ;

}