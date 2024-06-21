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
var stormIds = points.toList(5000).map(GetId).distinct();

// Create a line for each hurricane.
var lines = ee.FeatureCollection(stormIds.map(function(stormId){
  var pts = points.filter(ee.Filter.eq('SID', ee.String(stormId)));
  pts = pts.sort('ISO_TIME');
  var line = ee.Geometry.LineString(pts.geometry().coordinates());
  var feature = ee.Feature(line);
  return feature.set('SID', stormId);
}));


// Create thumbnail
var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle([-118, 4, 4, 59]);
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var hurricanePoints = points.style({color: 'black', pointSize: 1});
var hurricaneLines = lines.style(
  {
    color: 'red',
    width: 1
  });

var imageWithBg = waterLandBackground.blend(hurricaneLines).blend(hurricanePoints);

print(ui.Thumbnail({image: imageWithBg, params: imageParams}))

Map.addLayer(lines, {color: 'red'}, 'tracks');
Map.addLayer(points, {color: 'black'}, 'points');
Map.setCenter(-53, 36, 5);
