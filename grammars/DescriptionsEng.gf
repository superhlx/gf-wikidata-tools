concrete DescriptionsEng of Descriptions = CountriesEng,  CitiesEng, ProvincesEng, CityKindsEng **

open
  SyntaxEng,
  ParadigmsEng,
  (L = LexiconEng),
  ConstructorsEng,
  SymbolicEng,
  Prelude

in {

lincat
  Description = CN ;
  Location = Adv ;
  UniversityKinds = CN ;
  Attribute = Adv ;

lin
-- common grammars

  CityCountryLocation city country = SyntaxEng.mkAdv in_Prep (joinByComma city country.s) ;
  ProvinceCountryLocation province country = SyntaxEng.mkAdv in_Prep (joinByComma province country.s) ; 
  CountryLocation country = SyntaxEng.mkAdv in_Prep country.s ;
  noLocation = ParadigmsEng.mkAdv "" ;

-- city grammars
  capitalKind = mkN "capital" ;
  ProvinceForCaptial province country = mkCN (mkN "capital") (SyntaxEng.mkAdv (mkPrep "of") (joinByComma province country.s)) ; 
  CountryForCaptial country = mkCN (mkN "capital") (SyntaxEng.mkAdv (mkPrep "of") country.s) ;
  CityDescription kind location = mkCN kind location ;

-- universiity grammars
  university_Kind  = mkCN (mkN "university") ;  
  publicKind   = mkCN (mkN "public university");       
  privateKind  = mkCN (mkN "private university") ;    

  UniversityDescription kind location attr = mkCN (mkCN kind location) attr ;

  FoundedIn year = mkAdv (mkPrep "founded in") (symb year) ;
  noAttr = ParadigmsEng.mkAdv ""; 
  

oper
  joinByComma : NP -> NP -> NP  ;
  joinByComma = mkNP comma_Conj ;

  comma_Conj : Conj = and_Conj ** {s2 = bindComma} ;
}