var dataset = ee.FeatureCollection("EDF/OGIM/OGIM_v2-4_RF06_RF08");

// Filter out the most common categories.
// Optional step. It just helps visualizing smaller categories.
dataset = dataset.filter("CATEGORY != 'OIL AND NATURAL GAS WELLS'")
  .map(function(f) { return f.set('geoType', ee.Geometry(f.geometry()).type()); })
  .filter("CATEGORY != 'OIL AND NATURAL GAS PIPELINES' || geoType != 'Point'");

// Set different color for points and lines
var datasePoints = dataset
  .filter("geoType == 'Point'");
var datasetLines = dataset
  .filter("geoType != 'Point'");
var datasetPointsVis = datasePoints.style({
  color: 'black',
  pointSize: 1,
});
var datasetLinesVis = datasetLines.style({
  color: 'gray',
  width: 0.5,
});

var datasetVis = datasetLinesVis.blend(datasetPointsVis);

// Background
var background = ee.Image.rgb(256, 256, 256).rename('vis-red', 'vis-green', 'vis-blue');
var imageWithBackground = background.blend(datasetVis);

// Visualizing
// Geometry to clip image only to RF06 area.
var region = ee.Geometry.Rectangle(-104.33, 31.42, -103.11, 32.52);
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: region,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));