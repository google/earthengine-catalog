// Show hurricane tracks and points for 2017.
var hurricanes = ee.FeatureCollection('NOAA/NHC/HURDAT2/atlantic');

var year = '2017';
var points = hurricanes.filter(ee.Filter.date(ee.Date(year).getRange('year')));

// Find all of the hurricane ids.
var GetId = function(point) {
  return ee.Feature(point).get('id');
};
var storm_ids = points.toList(1000).map(GetId).distinct();

// Create a line for each hurricane.
var lines = ee.FeatureCollection(storm_ids.map(function(storm_id){
  var pts = points.filter(ee.Filter.eq('id', ee.String(storm_id)));
  pts = pts.sort('system:time_start');
  var line = ee.Geometry.LineString(pts.geometry().coordinates());
  var feature = ee.Feature(line);
  return feature.set('id', storm_id);
}));

Map.addLayer(lines, {color: 'red'}, 'tracks');
Map.addLayer(points, {color: 'black'}, 'points');

Map.setCenter(-53, 36, 3);
