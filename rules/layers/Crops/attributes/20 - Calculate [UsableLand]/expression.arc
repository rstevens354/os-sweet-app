/*The script caluculates the area of land minus the area of any intersecting parts of feature from another feature layer.*/

// Find ineligible land features which overlap the current feature
var fs = intersects(FeatureSetByName($map,"Ineligible Land"), Geometry($Feature))

// Get the intersection of each of these features with the current feature
var ds = intersection(fs, Geometry($Feature))

// create a single shape by unioning all the intersections
var single = union( ds)

// Now work out the area of the feature minus the combined intersection
round(Area(difference(Geometry($Feature), single), "meters")/10000,2)