concrete DescriptionsChi of Descriptions = CountriesChi **

open
  SyntaxChi,
  ParadigmsChi,
  (L = LexiconChi),
  (G = GrammarChi)

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
--  CountryLocation country = SyntaxChi.mkAdv in_Prep country ;
  CountryLocation country = SyntaxChi.mkAdv possess_Prep country ;

  city_Kind = mkCN L.city_N ;

  bigKind kind = mkCN L.big_A kind ;

}