/* This feedback is taking into account when no value might be returned when you select features. 

var layer is making sure only features which have crop type defined are returned.
it The first if statement is counting how many features are returned. 
If none are returned then the null is returned. 

*/

var layer  = Filter(FeatureSetByName($selection,"Crops"), "TYPE<>'NONE' AND TYPE<>'UNDESG'")
if (count(layer)<1) { 
    return null; 
}

/* var ag is summing up the field IncomePotential by crop type and these values are being added to a new field income.
The second if statement is making sure that a value is being calculated in income. If no values are passed in then null is returned.
Income is used as the series field */
var ag = aggregate(layer, ["Type"], ["SUM(IncomePotential)", "Income"]);
if (count(ag)<1) { 
    return null; 
}

return ag;