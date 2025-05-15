abstract Descriptions = Countries, Cities, Provinces, CityKinds ** {

cat
  Description ;
  Location ;
  UniversityKinds ;
  Attribute ;


flags startcat=Description ;
  
fun
-- common grammars

  CityCountryLocation : City -> Country -> Location ;
  ProvinceCountryLocation : Province -> Country -> Location ;
  CountryLocation         : Country -> Location ;
  noLocation              : Location ;
  
-- city grammars
  capitalKind  : CityKinds ; 
  ProvinceForCaptial : Province -> Country -> Description ;
  CountryForCaptial : Country -> Description ;
  CityDescription : CityKinds -> Location -> Description ;

-- universiity grammars
  university_Kind : UniversityKinds ;
  publicKind      : UniversityKinds ;
  privateKind     : UniversityKinds ;

  UniversityDescription : UniversityKinds -> Location -> Attribute -> Description ;

  FoundedIn : Int  -> Attribute ;
  noAttr : Attribute ;


}

