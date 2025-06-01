concrete CreatureDescriptionsEng of CreatureDescriptions = GenusEng, FamilyEng **

open
  SyntaxEng,
  ParadigmsEng,
  (L = LexiconEng),
  ConstructorsEng,
  Prelude,
  SymbolicEng,
  NounEng

in {

lincat 
    SpeciesDescription = CN ;
    GenusDescription = CN ;


lin
-- constructor of creature description
    SpeciesDescriptionBuilding genus family = mkCN (mkCN (mkN "species") (SyntaxEng.mkAdv (mkPrep "of") genus )) (SyntaxEng.mkAdv in_Prep (mkNP theSg_Det	(mkCN (mkN "family") family)) ) ;
    GenusDescriptionBuilding family = mkCN (mkN "genus")  (SyntaxEng.mkAdv in_Prep (mkNP theSg_Det	(mkCN (mkN "family") family)) ) ;


}
    