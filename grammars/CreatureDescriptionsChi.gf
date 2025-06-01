concrete CreatureDescriptionsChi of CreatureDescriptions = GenusChi, FamilyChi **

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
    SpeciesDescription = CN ;
    GenusDescription = CN ;


lin


-- constructor of creature description
    SpeciesDescriptionBuilding genus family = mkCN (mkN "物种") (SyntaxChi.mkAdv (mkPrep "") (SyntaxChi.mkNP genus (np2adv family))) ;
    GenusDescriptionBuilding family = mkCN (mkN "属")  (SyntaxChi.mkAdv (mkPrep "")  family) ;



oper
  np2adv : ResChi.NP -> Adv =
  \np -> ss (linNP np) ** {advType = ATPlace False ; hasDe = True ; lock_Adv = <>} ;

}