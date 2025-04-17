abstract Descriptions = Countries, Region, Year, CityRegions ** {

cat
  Description ;
  Location ;
  Kind ;
  Attribute ;


flags startcat=Description ;
  
fun
  CityDescription : Kind -> Location -> Description ;
--- RegionCountryLocation : Region -> Country -> Location ;
  UniversityDescription : Kind -> Location -> Attribute -> Description ;
  
  
  city_Kind : Kind ;
  capitalKind  : Kind -> Kind ; 

  CityRegionCountryLocation : CityRegion -> Country -> Location ;
  CaptialCityCountryLocation   : Country -> Location ;  

  publicKind      : Kind -> Kind ;
  privateKind     : Kind -> Kind ;

  university_Kind : Kind ;
  CountryLocation         : Country -> Location ;
  RegionCountryLocation   : Region -> Country -> Location ;
  noLocation              : Location ;

  FoundedIn : Year  -> Attribute ;
  noAttr : Attribute ;

}

