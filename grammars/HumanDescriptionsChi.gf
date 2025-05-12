concrete HumanDescriptionsChi of HumanDescriptions = CountryChiUnified **

open
  ParadigmsChi,
  SyntaxChi,
  (L = LexiconChi),
  ConstructorsChi,
  Prelude,
  SymbolicChi


in {
  
param 
  GenderParam = MaleParam | FemaleParam | UnknownParam ;

lincat
  Description = NP ;
  HumanGender = {s : Str ; g : GenderParam} ;
  Person = {s : Str ; g : GenderParam} ;
  BirthAndDeathYears = Symb ;
  Bornplace = Adv ; 
  Professions = GenderParam => N ;
  Gender =  A ;


lin


-- constructor of person, contains name and gender
  PersonBuilding str gen = {s = str.s ; g = gen.g} ;

-- constructor of bornday and deathday
  BornAndDied b d = mkSymb ("(" ++ b.s ++ "–" ++ d.s ++ ")") ;
  OnlyDied d = mkSymb ("( -" ++ d.s ++ ")") ;
  OnlyBorn b = mkSymb ("(" ++ b.s ++ "– )") ;
  NoBirthOrDeath = mkSymb "" ;

  Bornin country = mkAdv (mkPrep "出生于") country.s ;

  Mathematician = table {
              MaleParam => mkN "男数学家" ; 
              FemaleParam => mkN "女数学家" ; 
              UnknownParam => mkN "数学家" } ;


  SameNationalityBuilding p n prof birthtime = symb theSg_Det (mkCN n.nationality (mkCN (prof ! p.g))) birthtime ;

  DiffNationalityBuilding p n place prof birthtime = symb theSg_Det (mkCN (mkCN n.nationality (prof ! p.g)) place) birthtime ;

}