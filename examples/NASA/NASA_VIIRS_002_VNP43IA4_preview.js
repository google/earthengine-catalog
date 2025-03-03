var dataset = ee.Image('NASA/VIIRS/002/VNP43IA4/2021_06_01');

// Sukhanova in Russia.
var lon = 80;
var lat = 66;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

// Degrees in SR-ORG:6974
var delta = 3.5;
// Width and height of the thumbnail image.
var pixels = 256;

var I1_band = dataset.select('BRDF_Albedo_Band_Mandatory_Quality_I1');

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'SR-ORG:6974',
  format: 'png',
};

var palette = [
  '000080',
  '0000d9',
  '4000ff',
  '8000ff',
  '0080ff',
  '00ffff',
  '00ff80',
  '80ff00',
  'daff00',
  'ffff00',
  'fff500',
  'ffda00',
  'ffb000',
  'ffa400',
  'ff4f00',
  'ff2500',
  'ff0a00',
  'ff00ff',
];

var image = I1_band.visualize({palette: palette, min: 0, max: 1});

Map.addLayer(image, {}, 'BRDF/Albedo mandatory quality for band I1');

print(ui.Thumbnail({image: image, params: visParams}));
