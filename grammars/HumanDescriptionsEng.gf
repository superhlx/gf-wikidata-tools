concrete HumanDescriptionsEng of HumanDescriptions = CountriesEng, NationalityEng **

open
  SyntaxEng,
  ParadigmsEng,
  (L = LexiconEng),
  ConstructorsEng,
  Prelude,
  SymbolicEng

in {
  
param 
  GenderParam = MaleParam | FemaleParam | UnknownParam ;

lincat
  Description = CN ;
  HumanGender = {s : Str ; g : GenderParam} ;
  Person = {s : Str ; g : GenderParam} ;
  BirthAndDeathYears = Adv ;
  Bornplace = Adv ; 
  Professions = N ; 
  Gender =  A ;


lin

-- constructor of person, contains name and gender
  PersonBuilding str gen = {s = str.s ; g = gen.g} ;

-- constructor of bornday and deathday
  BornAndDied b d =  ParadigmsEng.mkAdv ("(" ++ b.s ++ "–" ++ d.s ++ ")") ;
  OnlyDied d = ParadigmsEng.mkAdv ("( -" ++ d.s ++ ")") ;
  OnlyBorn b = ParadigmsEng.mkAdv ("(" ++ b.s ++ "– )") ;
  NoBirthOrDeath = ParadigmsEng.mkAdv ("") ; 

  Male = mkA "male" ;
  Female = mkA "female" ;


  Bornin country = mkAdv (mkPrep "born in") country ;

  Mathematician = mkN "mathematician" ;

  SameNationalityBuilding p n prof birthtime =  

    case p.g of
        { MaleParam => mkCN (mkCN n (mkCN Male prof)) birthtime   ;
        FemaleParam => mkCN (mkCN n (mkCN Female prof)) birthtime ;
        UnknownParam => mkCN (mkCN n  prof) birthtime  } ;


  DiffNationalityBuilding p n place prof birthtime =
    case p.g of
        { MaleParam => mkCN (mkCN (mkCN n (mkCN Male prof)) place) birthtime ;
        FemaleParam => mkCN (mkCN (mkCN n (mkCN Female prof)) place) birthtime ;
        UnknownParam => mkCN (mkCN (mkCN n prof) place) birthtime } ;

}