abstract Descriptions = Countries ** {

cat
  Description ;
  Location ;
  Region ;
  Kind ;
  Attribute ;
  
fun
  CityDescription : Kind -> Location -> Description ;
--- RegionCountryLocation : Region -> Country -> Location ;
  CountryLocation : Country -> Location ;

  city_Kind : Kind ;
}