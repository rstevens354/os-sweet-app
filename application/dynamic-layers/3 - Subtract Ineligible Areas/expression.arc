
if ($currenttool!="subtract") return null;

// For efficiency, cache inelligible land on the map
var ineligbleLandLayer = MapLayer($map,"Ineligible Land")
var ineligbleLand = ExtentCachedFeatures(ineligbleLandLayer)

// Find all inelligible land that intersects with the drawing shape.
var landDrawingIntersection = Intersection(ineligbleLand, $drawingshape, false)

// Return a single geometry which represents the intersection between
// the inelligible land and drawing shape
var landDrawingUnion = Union(landDrawingIntersection);

if (landDrawingUnion == null) return null;

//Now find the impacted crops
var crops = intersects(
                filter(
                    ExtentCachedFeatures(MapLayer($map, "Crops")),
                    "Type<>'NONE' and Type<>'UNDESG'"
                ),
                landDrawingUnion
            );

function myGain(feature) {
    var cropsGeometry = geometry(feature)

    // Find the three-way intersection between crops, land and drawing
    var cropsLandAndDrawingIntersection = intersection(cropsGeometry, landDrawingUnion);
    if (cropsLandAndDrawingIntersection==null) return "NOLOSS";

    // Assign number values to each type of crop feature
    var profitPerHectare = Decode(feature.Type,'BAR',200, 'WHE', 300, 'SUG', 500, 'GRASS', 0, 'POTATO', 550, 0);
    
    // Calculate area of three-way intersection
    var usableland = round(area(cropsLandAndDrawingIntersection,"meters")/10000,2)

    return "Gained Income : £" + text(Round(usableland  * profitPerHectare,2));
}

filter(addfield(crops,"bad", myGain), "bad<>'NOLOSS'");