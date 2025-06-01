abstract CreatureDescriptions = Genus, Family ** {
cat 
    SpeciesDescription ;
    GenusDescription ;



flags startcat=Description ;


fun

    SpeciesDescriptionBuilding : Genus -> Family -> SpeciesDescription ;
    GenusDescriptionBuilding : Family -> GenusDescription ;
}