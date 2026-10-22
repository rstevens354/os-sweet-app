//Filter crops in the map which do not have the type of none
var cropLayer = Filter(FeatureSetByName($map,"Crops"), "Type<>'NONE'");

/*The most revenue generating crop is 550 per hectare.
This calculation works out the maximum revenue that could be generated
by this land*/
var maxincome = Round(Sum(cropLayer,'UsableLand') * 550,2);

/*This calculation works out the income potential when all crops are
added together based on the crop type selected*/
var actualincome = Round(Sum(cropLayer,'IncomePotential'),2);

/* This type of feedback requires a dictionary to be returned 
which is the following; min, max and value. 
These can be populated by calculations like 
those made above, by fields in the data or hardcoding the values. */
return Dictionary("min",0, "max", maxincome, "value", actualincome)