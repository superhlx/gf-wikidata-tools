abstract HumanDescriptions = Countries, Nationality ** {

cat
  Description ;
  Person ; 
  BirthAndDeathYears;
  Professions; 
  HumanGender;
  Bornplace;
  Gender;

flags startcat=HumanDescription ;
  


fun

  PersonBuilding : String -> HumanGender  -> Person ; 

  BornAndDied : Int -> Int -> BirthAndDeathYears ;
  OnlyBorn : Int -> BirthAndDeathYears ;
  OnlyDied : Int -> BirthAndDeathYears ;
  NoBirthOrDeath : BirthAndDeathYears ;

-- Nationality 在新文件定义

  Bornin : Country -> Bornplace ; 

  Mathematician : Professions ;

  Male : Gender ;
  Female : Gender ;

-- 国籍、出生地，职业 职业先写个数学家

  SameNationalityBuilding: Person -> Nationality -> Professions -> BirthAndDeathYears -> Description ;
  DiffNationalityBuilding: Person -> Nationality -> Bornplace -> Professions -> BirthAndDeathYears -> Description ;
}
