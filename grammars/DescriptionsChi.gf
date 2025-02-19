concrete DescriptionsChi of Descriptions = CountriesChi **

open
  SyntaxChi,
  ParadigmsChi,
  (L = LexiconChi)

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
  CountryLocation country = SyntaxChi.mkAdv in_Prep country ;

  city_Kind = mkCN L.city_N ;
}