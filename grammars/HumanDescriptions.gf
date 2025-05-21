abstract HumanDescriptions = Countries ** {

cat
  Description ;
  Person ; 
  BirthAndDeathYears;
  Professions; 
  HumanGender;
  Bornplace;
  Gender;

flags startcat=Description ;
  


fun

  PersonBuilding : String -> HumanGender  -> Person ; 
  Male : HumanGender;
  Female : HumanGender;
  Unknown : HumanGender;

  BornAndDied : Int -> Int -> BirthAndDeathYears ;
  OnlyBorn : Int -> BirthAndDeathYears ;
  OnlyDied : Int -> BirthAndDeathYears ;
  NoBirthOrDeath : BirthAndDeathYears ;

-- Nationality 在新文件定义

  Bornin : Country -> Bornplace ; 

  Mathematician : Professions ;
  GenderFunction : Person -> Gender ;

-- 

  SameNationalityBuilding: Person -> Country -> Professions -> BirthAndDeathYears -> Description ;
  DiffNationalityBuilding: Person -> Country -> Bornplace -> Professions -> BirthAndDeathYears -> Description ;
}
