concrete DescriptionsChi of Descriptions = CountriesChi,  CitiesChi, ProvincesChi, CityKindsChi **

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
  noAttr = ParadigmsChi.mkAdv "" (ATPlace False) False ;

 

oper
  np2adv : ResChi.NP -> Adv =
  \np -> ss (linNP np) ** {advType = ATPlace False ; hasDe = True ; lock_Adv = <>} ;


}