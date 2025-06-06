// Import the cocoa probability model collection.
var dataset = ee.ImageCollection(
  'projects/forestdatapartnership/assets/cocoa/model_2025a');

// Point to center
var lat = 5.78;
var lon = -2.84;

// Filter the collection to the 2020 mosaic.
var cocoa2020 =
  dataset.filterDate(ee.Date('2020-01-01'), ee.Date('2020-12-31')).first();

var palette = ['#eff3ff', '#bdd7e7', '#6baed6', '#3182bd', '#08519c'];
var vis = {min: 0, max: 1.0, palette: palette};

// Display land cover on the map.
Map.setCenter(lon, lat, 13);

Map.addLayer(cocoa2020, vis);

// Preview image.

// Degrees in EPSG:3857
var delta = 0.043;
// Width and Height of the Thumbnail image.
var pixels = 256;


var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
dimensions: [pixels, pixels],
region: areaOfInterest,
crs: 'EPSG:3857',
format: 'png'
};

var image = cocoa2020.visualize({palette: palette});

print(ui.Thumbnail({image: image, params: parameters}));