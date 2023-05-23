
// Retrieve the last date from the SPEI dataset
var dataset = ee.ImageCollection("CSIC/SPEI/2_8").
  filterDate('2021-12-01', '2022-01-01');

// Convert ee.ImageCollection to ee.Image
dataset = ee.Image(ee.List(dataset.toList(1)).get(0));

// Select the 24-month analysis
var spei24 = dataset.select('SPEI_24_month');

// Degrees in EPSG:3857.
var delta = 60;
// Width and Height of the thumbnail image.
var pixels = 256;

var lon = 0;
var lat = 15;

Map.setCenter(lon, lat, 2);

var areaOfInterest = ee.Geometry.Rectangle(
  [-120, lat - delta, 60, lat + delta], null, false);

// Set the visualization ranges and color palette
var vis = {
  min: -2.33,
  max:  2.33,
  palette: [
    "#8B1A1A","#DE2929", "#F3641D",
    "#FDC404", "#9AFA94", "#03F2FD",
    "#12ADF3", "#1771DE", "#00008B"
  ],
  region: areaOfInterest,
  dimensions: [pixels, pixels],
  crs: 'EPSG:3857',
  format: 'png',
};

// Display the SPEI 24-month layer
Map.addLayer(spei24, vis, 'SPEI 24 month');

print(ui.Thumbnail({image: spei24, params: vis}));
