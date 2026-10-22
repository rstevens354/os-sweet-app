/*see diversity feedback for explanation of calculations*/ 
var layer  = Filter(MapLayer($Map, 'Crops'), "TYPE<>'NONE' AND TYPE<>'UNDESG'")
aggregate(layer, ["Type"], ["SUM(IncomePotential)", "Income"])