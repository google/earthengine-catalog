var dataset = ee.ImageCollection('projects/pml_evapotranspiration/PML/OUTPUT/PML_V22a');

var visualization = {
  min: 0.0,
  max: 9.0,
  palette: [
    'a50026', 'd73027', 'f46d43', 'fdae61', 'fee08b', 'ffffbf',
    'd9ef8b', 'a6d96a', '66bd63', '1a9850', '006837',
  ]
};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Calculate mean GPP and apply the 0.01 scale factor
var image = dataset.select('GPP')
    .filterDate('2001-01-01', '2023-12-31')
    .mean()
    .multiply(0.01);

Map.addLayer(
    image, visualization, 'PML_V2.2a Gross Primary Product (GPP)');

// Visualize the image and layer it over the gray background
var visualizedImage = image.visualize(visualization);
var imageWithBackground = ee.ImageCollection([background, visualizedImage]).mosaic();

var lon = -58;
var lat = -11;
Map.setCenter(lon, lat, 6);

// Viewport parameters for the 256x256 thumbnail
var delta = 24;
var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));