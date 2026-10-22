/* This caluclation allows you to calculate a value based on a domain type, the geometry and a value of another field.

We have in this script assigned values to each of the domain codes in the field type.
We have then performed a calculation which will take into account the different values for each crop type. 
The calculation takes the UseableLand field (area) and * by the ProfitPerHectare variable defined above. However, it also removes the damage to the crop as defined by the DamagePercentate field. */

var profitPerHectare = Decode($Feature.Type,'BAR',20, 'WHE', 300, 'SUG', 500, 'GRASS', 0, 'POTATO', 550, 0);
return Round($Feature.UsableLand *  ((100 - DefaultValue($Feature.DamagePercentage,0))/100) * profitPerHectare,2);