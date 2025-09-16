// Import the coffee probability model collection.
var dataset = ee.ImageCollection(
  'projects/forestdatapartnership/assets/coffee/model_2025a');


// Point to center
var lat = 14.57;
var lon = -88.84;

// Filter the collection to the 2020 mosaic.
var coffee2020 =
  dataset.filterDate(ee.Date('2020-01-01'), ee.Date('2020-12-31')).first();

var palette = ['#ffffd4', '#fee391', '#fec44f', '#fe9929', '#d95f0e', '#993404'];
var vis = {min: 0.5, max: 1.0, palette: palette};

// Display land cover on the map.
Map.setCenter(lon, lat, 13);

Map.addLayer(coffee2020, vis);

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

var image = coffee2020.visualize({palette: palette});

print(ui.Thumbnail({image: image, params: parameters}));