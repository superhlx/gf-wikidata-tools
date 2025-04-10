concrete DescriptionsEng of Descriptions = CountriesEng, RegionEng, YearEng, CityRegionsEng **

open
  SyntaxEng,
  ParadigmsEng,
  (L = LexiconEng),
  ConstructorsEng,
  Prelude

in {

lincat
  Description = CN ;
  Location = Adv ;
  Kind = CN ;
  Attribute = Adv ;

lin

  city_Kind        = mkCN L.city_N ;
  university_Kind  = mkCN (mkN "university") ;  


  capitalKind k = mkCN (mkA "capital") k ;      
  -- bigKind k     = mkCN (mkA "big") k ;         
  publicKind k  = mkCN (mkA "public") k ;       
  privateKind k = mkCN (mkA "private") k ;      

  CaptialCityCountryLocation c = SyntaxEng.mkAdv (mkPrep "of") c ;
    
  CityRegionCountryLocation r c = SyntaxEng.mkAdv in_Prep (joinByComma r c) ;

  CountryLocation country = SyntaxEng.mkAdv in_Prep country ;
  RegionCountryLocation reg country = ConstructorsEng.mkAdv in_Prep (joinByComma reg country) ;

  noLocation = SyntaxEng.mkAdv in_Prep (mkNP (mkN "unknown")) ;

  FoundedIn year = mkAdv (mkPrep "founded in") year ;

  noAttr = ParadigmsEng.mkAdv ""; 

  CityDescription kind location = mkCN kind location ;
  UniversityDescription kind location attr =
    mkCN (mkCN kind location) attr ;

oper
  joinByComma : NP -> NP -> NP  ;
  joinByComma = mkNP comma_Conj ;

  comma_Conj : Conj = and_Conj ** {s2 = bindComma} ;
}