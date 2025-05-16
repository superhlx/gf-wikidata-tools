concrete HumanDescriptionsEng of HumanDescriptions = CountriesEng **

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
  Professions = GenderParam => N ;
  Gender =  A ;


lin


-- constructor of person, contains name and gender
  PersonBuilding str gen = {s = str.s ; g = gen.g} ;

-- constructor of bornday and deathday
  BornAndDied b d =  ParadigmsEng.mkAdv ("(" ++ b.s ++ "–" ++ d.s ++ ")") ;
  OnlyDied d = ParadigmsEng.mkAdv ("( -" ++ d.s ++ ")") ;
  OnlyBorn b = ParadigmsEng.mkAdv ("(" ++ b.s ++ "– )") ;
  NoBirthOrDeath = ParadigmsEng.mkAdv ("") ; 


  Bornin country = mkAdv (mkPrep "born in") country.s ;

  Mathematician = table {
              MaleParam => mkN "male mathematician" ; 
              FemaleParam => mkN "female mathematician" ; 
              UnknownParam => mkN "mathematician" } ;


  SameNationalityBuilding p c prof birthtime = mkCN (mkCN c.nationality (mkCN (prof ! p.g))) birthtime ;

  DiffNationalityBuilding p c place prof birthtime = mkCN (mkCN (mkCN c.nationality (mkCN (prof ! p.g))) place) birthtime ;


}