abstract HumanDescriptions = Countries, Professions ** {

cat
  Description ;
  Person ; 
  BirthAndDeathYears;

  HumanGender;
  Bornplace;
  Gender;

flags startcat=Description ;
  


fun

  PersonBuilding : String -> HumanGender  -> Person ; 
  Male : HumanGender;
  Female : HumanGender;
  Unknown : HumanGender;

  BornAndDied : String -> String -> BirthAndDeathYears ;
  OnlyBorn : String -> BirthAndDeathYears ;
  OnlyDied : String -> BirthAndDeathYears ;
  NoBirthOrDeath : BirthAndDeathYears ;

-- Nationality 在新文件定义

  Bornin : Country -> Bornplace ; 

  GenderFunction : Person -> Gender ;

-- 

  SameNationalityBuilding: Person -> Country -> Profession -> BirthAndDeathYears -> Description ;
  DiffNationalityBuilding: Person -> Country -> Bornplace -> Profession -> BirthAndDeathYears -> Description ;

  NationalityUnknown : Person -> Profession -> BirthAndDeathYears -> Description ;
}
