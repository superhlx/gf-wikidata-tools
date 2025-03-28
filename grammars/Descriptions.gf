abstract Descriptions = Countries ** {

cat
  Description ;
  Location ;
  Region ;
  Kind ;
  Attribute ;


flags startcat=Description ;
  
fun
  CityDescription : Kind -> Location -> Description ;
--- RegionCountryLocation : Region -> Country -> Location ;
  CountryLocation : Country -> Location ;
  UniversityDescription : Kind -> Location -> Attribute -> Description ;
  
  
  city_Kind : Kind ;
  university_Kind : Kind ;


  capitalKind  : Kind -> Kind ; 

  bigKind -- modifies the Kind with the adjective "big"

   : Kind -> Kind ;

  publicKind      : Kind -> Kind ;
  privateKind     : Kind -> Kind ;


  CountryLocation         : Country -> Location ;
  RegionCountryLocation   : Region -> Country -> Location ;
  noLocation              : Location ;
  Q956_Beijing_Region : Region ;

  FoundedIn : String -> Attribute ;
  noAttr : Attribute ;

}