var dataset = ee.FeatureCollection('NOAA/IBTrACS/v4');

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var points = dataset.filter(ee.Filter.eq('SEASON', 2020));

// Find all of the hurricane ids.
var GetId = function(point) {
  return ee.Feature(point).get('SID');
};
var storm_ids = points.toList(5000).map(GetId).distinct();

// Create a line for each hurricane.
var lines = ee.FeatureCollection(storm_ids.map(function(storm_id){
  var pts = points.filter(ee.Filter.eq('SID', ee.String(storm_id)));
  pts = pts.sort('ISO_TIME');
  var line = ee.Geometry.LineString(pts.geometry().coordinates());
  var feature = ee.Feature(line);
  return feature.set('SID', storm_id);
}));

Map.addLayer(lines, {color: 'red'}, 'tracks');

Map.addLayer(points, {color: 'black'}, 'points');

Map.setCenter(-53, 36, 5);
