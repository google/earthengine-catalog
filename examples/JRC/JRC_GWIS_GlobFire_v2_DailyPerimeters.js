// Folder name for a series of tables.
var folder = 'JRC/GWIS/GlobFire/v2/DailyPerimeters';

// List available tables using ee.data.listAssets with asynchronous callback.
function printAssetList(listAssetsOutput) {
  print('Asset list:', listAssetsOutput['assets']);
}
ee.data.listAssets(folder, {}, printAssetList);

// Define a table name (table id) identified from the list of available tables.
var tableName = 'JRC/GWIS/GlobFire/v2/DailyPerimeters/2020';

var computeArea = function (f) {
  return f.set({'area': f.area()});
}
// Import a selected table as a FeatureCollection.
var features = ee.FeatureCollection(tableName).map(computeArea);

// Visualization parameters for linear fire area gradient.
var visParams = {
  palette: ['f5ff64', 'b5ffb4', 'beeaff', 'ffc0e8', '8e8dff', 'adadad'],
  min: 0.0,
  max: 600000000.0,
  opacity: 0.8,
};

// Paint fire perimeters to an image using computed fire area as the value property.
var image = ee.Image().float().paint(features, 'area')

// Display the image to the map (include features for exploring with Inspector).
Map.addLayer(image, visParams, 'GlobFire 2020');
Map.addLayer(features, null, 'For Inspector', false);
Map.setCenter(-121.23, 39.7, 12);
