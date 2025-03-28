concrete DescriptionsSwe of Descriptions = CountriesSwe **

open
  SyntaxSwe,
  ParadigmsSwe,
  (L = LexiconSwe)

in {

lincat
  Description = CN ;
  Location = Adv ;
  Region = NP ;
  Kind = CN ;
  Attribute = AP ;
  
lin
  CityDescription kind location = mkCN kind location ; 
---  RegionCountryLocation : Region -> Country -> Location ;
  CountryLocation country = SyntaxSwe.mkAdv in_Prep country ;

  city_Kind = mkCN L.city_N ;
  bigKind kind = mkCN L.big_A kind ;
  capitalKind _ = mkCN (mkN "huvudstad" "huvudstäder") ;
}