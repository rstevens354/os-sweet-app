//Filter crops in the map which do not have the type of none
var layer  = Filter(FeatureSetByName($map,"Crops"), "TYPE<>'NONE' AND TYPE<>'UNDESG'")

//Aggregate crops of the same type and calculate the area of land
return aggregate(layer, ["Type"], ["SUM(UsableLand)", "LandAmount"])