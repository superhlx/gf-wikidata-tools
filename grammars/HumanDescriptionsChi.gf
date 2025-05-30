concrete HumanDescriptionsChi of HumanDescriptions = CountriesChi, ProfessionsChi **

open
  ParadigmsChi,
  SyntaxChi,
  (L = LexiconChi),
  ConstructorsChi,
  Prelude,
  SymbolicChi,
  ResChi,
  (C=ConjunctionChi)


in {
  


lincat
  Description = CN ;
  HumanGender = {s : Str ; g : GenderParam} ;
  Person = {s : Str ; g : GenderParam} ;
  BirthAndDeathYears = Str ;
  Bornplace = Adv ; 
  Gender =  A ;


lin


-- constructor of person, contains name and gender
  PersonBuilding str gen = {s = str.s ; g = gen.g} ;
  Male = {s= ""; g = MaleParam} ;
  Female = {s= ""; g = FemaleParam} ;
  Unknown = {s= ""; g = UnknownParam} ;

-- constructor of bornday and deathday
  BornAndDied b d =  ("(" ++ b.s ++ "–" ++ d.s ++ ")") ;
  OnlyDied d = ("( -" ++ d.s ++ ")") ;
  OnlyBorn b = ("(" ++ b.s ++ "– )") ;
  NoBirthOrDeath = "" ;

  Bornin country = mkAdv (mkPrep "出生于") country.s ;



  
  
  -- \\_ => mkN "数学家" ;
  -- -- Mathematician = table {
  -- --             MaleParam => mkN "男数学家" ; 
  -- --             FemaleParam => mkN "女数学家" ; 
  -- --             UnknownParam => mkN "数学家" } ;

  GenderFunction = \p -> case p.g of {
    MaleParam   => mkA "男" True;
    FemaleParam => mkA "女" True;
    UnknownParam => mkA "" True 
  } ;

  SameNationalityBuilding p n prof birthtime = addYearsToCN (mkCN n.nationality (mkCN (GenderFunction p)(prof ! p.g))) birthtime ;

  DiffNationalityBuilding p n place prof birthtime = mkCommaCN (addYearsToCN (mkCN n.nationality (mkCN (GenderFunction p)(prof ! p.g))) birthtime) place ;

  NationalityUnknown p prof birthtime = addYearsToCN (mkCN (GenderFunction p)(prof ! p.g)) birthtime ;

oper
  mkCommaCN : CN -> Adv -> CN =
  \cn,adv -> cn ** {s = cn.s ++ "，" ++ adv.s } ;

  addYearsToCN : CN -> Str -> CN =
  \cn,years -> cn ** {s = cn.s ++ " " ++ years } ;
}