concrete HumanDescriptionsBen of HumanDescriptions = CountriesBen **

open
  SyntaxBen,
  ParadigmsBen,
  (L = LexiconBen),
  Prelude
  -- SymbolicBen

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
  BornAndDied b d =  ParadigmsBen.mkAdv ("(" ++ b.s ++ "–" ++ d.s ++ ")") ;
  OnlyDied d = ParadigmsBen.mkAdv ("( -" ++ d.s ++ ")") ;
  OnlyBorn b = ParadigmsBen.mkAdv ("(" ++ b.s ++ "– )") ;
  NoBirthOrDeath = ParadigmsBen.mkAdv ("") ; 


  -- Bornin country = mkAdv (mkPrep "born in") country.s ;
  Bornin country = SyntaxBen.mkAdv in_Prep country.s ;

  Mathematician = \\_ => mkN "mathematician" ; 


  SameNationalityBuilding p c prof birthtime = mkCN (mkCN c.nationality (mkCN (prof ! p.g))) birthtime ;

  DiffNationalityBuilding p c place prof birthtime = mkCN (mkCN (mkCN c.nationality (mkCN (prof ! p.g))) place) birthtime ;


}