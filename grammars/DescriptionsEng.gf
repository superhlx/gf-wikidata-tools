concrete DescriptionsEng of Descriptions = CountriesEng **

open
  SyntaxEng,
  ParadigmsEng,
  (L = LexiconEng)

in {

lincat
  Description = CN ;
  Location = Adv ;
  Region = NP ;
  Kind = CN ;
  Attribute = Adv ;

lin

  city_Kind        = mkCN L.city_N ;
  university_Kind  = mkCN (mkN "university") ;  


  capitalKind k = mkCN (mkA "capital") k ;      
  bigKind k     = mkCN (mkA "big") k ;         
  publicKind k  = mkCN (mkA "public") k ;       
  privateKind k = mkCN (mkA "private") k ;      

  Q956_Beijing_Region = mkNP (mkPN "Beijing");

  CountryLocation country = SyntaxEng.mkAdv in_Prep country ;
  -- RegionCountryLocation reg country =

  noLocation = SyntaxEng.mkAdv in_Prep (mkNP (mkN "unknown")) ;



  FoundedIn = mkAdv ("founded in 1999");
  noAttr = mkAdv ""; 

  CityDescription kind location = mkCN kind location ;
  UniversityDescription kind location attr =
    mkCN (mkCN kind location) attr ;
}