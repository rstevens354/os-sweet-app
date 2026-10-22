//Feedback will only display if the tool is new
if ($currenttool!="new") return null;

// A new variable which contains ineligible land features in the extent
var f =  extentcachedfeatures(FeatureSetByName($map,"Ineligible Land"));

// union will create one feature of all the intersections of the feature which is being drawn and the Ineligible land
var d = union(intersection(f, $drawingshape));

var newdrawingshape = $drawingshape;
if (d!=null) {
   newdrawingshape= difference($drawingshape, d);
}

if (newdrawingshape==null) return null;

var crops = intersects(filter(extentcachedfeatures(FeatureSetByName($map,"Crops")),"Type<>'NONE' and Type<>'UNDESG'"),newdrawingshape);

function myLoss(feature) {
    var los = intersection(geometry(feature), newdrawingshape);
    if (los==null) return "NOLOSS";
    var yield = Decode(feature.Type,'BAR',80, 'WHE', 70, 'SUG', 95, 'GRASS', 100, 'POTATO', 40, 100)
    
    var profitPerHectare = Decode(feature.Type,'BAR',200, 'WHE', 300, 'SUG', 500, 'GRASS', 0, 'POTATO', 550, 0);
    var usableland = round(area(los,"meters")/10000,2)

    return "Lost Income : £" + text(Round(usableland  * profitPerHectare,2));
}

filter(addfield(crops,"bad", myLoss), "bad<>'NOLOSS'");
