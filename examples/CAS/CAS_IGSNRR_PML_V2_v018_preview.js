var dataset = ee.ImageCollection('CAS/IGSNRR/PML/V2_v018')

// test. for raw data
// var dataset = ee.ImageCollection('projects/pml_evapotranspiration/PML/OUTPUT/PML_V2_8day_v018')

var visualization = {
  bands: ['GPP'],
  min: 0.0,
  max: 9.0,
  palette: [
    'a50026', 'd73027', 'f46d43', 'fdae61', 'fee08b', 'ffffbf',
    'd9ef8b', 'a6d96a', '66bd63', '1a9850', '006837',
  ]
};


var image = dataset.select('GPP').filterDate('2001-01-01', '2023-12-31').mean()

// test. with sclae factor 0.01
// var image = dataset.select('GPP').filterDate('2001-01-01', '2023-12-31').mean().multiply(0.01)

Map.addLayer(
    image, visualization, 'PML_V2 0.1.7 Gross Primary Product (GPP)');

// create image 
image = image.visualize(visualization)

var lon = -58;
var lat = -11;

Map.setCenter(lon, lat, 6);

// Degrees in SR-ORG:6974
var delta = 24;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

    
print(ui.Thumbnail({image: image, params: visParams}));