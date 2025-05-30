concrete HumanDescriptionsEng of HumanDescriptions = CountriesEng, ProfessionsEng **

open
  SyntaxEng,
  ParadigmsEng,
  (L = LexiconEng),
  ConstructorsEng,
  Prelude,
  SymbolicEng,
  (C=ConjunctionEng)

in {
  


lincat
  Description = CN ;
  HumanGender = {s : Str ; g : GenderParam} ;
  Person = {s : Str ; g : GenderParam} ;
  BirthAndDeathYears = Adv ;
  Bornplace = Adv ; 


  Gender =  A ;


lin


-- constructor of person, contains name and gender
  PersonBuilding str gen = {s = str.s ; g = gen.g} ;
  Male = {s= ""; g = MaleParam} ;
  Female = {s= ""; g = FemaleParam} ;
  Unknown = {s= ""; g = UnknownParam} ;
-- constructor of bornday and deathday
  BornAndDied b d =  ParadigmsEng.mkAdv ("(" ++ b.s ++ "–" ++ d.s ++ ")") ;
  OnlyDied d = ParadigmsEng.mkAdv ("( -" ++ d.s ++ ")") ;
  OnlyBorn b = ParadigmsEng.mkAdv ("(" ++ b.s ++ "– )") ;
  NoBirthOrDeath = ParadigmsEng.mkAdv ("") ; 


  Bornin country = mkAdv (mkPrep "born in") country.s ;



  GenderFunction = \p -> case p.g of {
    MaleParam   => mkA "male" ;
    FemaleParam => mkA "Female" ;
    UnknownParam => mkA ""
  } ;
  -- Mathematician = table {
  --             MaleParam => mkN "male mathematician" ; 
  --             FemaleParam => mkN "female mathematician" ; 
  --             UnknownParam => mkN "mathematician" } ;


  SameNationalityBuilding p c prof birthtime = mkCN (mkCN c.nationality (mkCN (GenderFunction p)(prof ! p.g))) birthtime ;

  DiffNationalityBuilding p c place prof birthtime = mkCN (mkCN (mkCN c.nationality (mkCN (GenderFunction p)(prof ! p.g))) place) birthtime ;

  NationalityUnknown p prof birthtime = mkCN  (mkCN (GenderFunction p)(prof ! p.g)) birthtime ;
}