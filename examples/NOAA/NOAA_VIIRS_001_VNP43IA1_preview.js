var dataset = ee.Image('NOAA/VIIRS/001/VNP43IA1/2017_03_10');

// Sukhanova in Russia.
var lon = 89;
var lat = 58;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

// Degrees in SR-ORG:6974
var delta = 3.5;
// Width and Height of the thumbnail image.
var pixels = 256;

 // cadetblue
var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 1});

// The visualisations are baked into the image properties.
// Benthic habitat classification.
var I1_isotropic = dataset.select('BRDF_Albedo_Parameters_fiso_I1');

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels], region: areaOfInterest, crs: 'SR-ORG:6974',
  format: 'png', min: 0, max:1,
};

var palette = [
    '000080','0000d9','4000ff','8000ff','0080ff','00ffff',
    '00ff80','80ff00','daff00','ffff00','fff500','FFda00',
    'ffb000','ffa400','ff4f00','ff2500','ff0a00','ff00ff',
];

var image = I1_isotropic.visualize({palette: palette, min: 0, max:1});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.addLayer(imageWithBackground, null, 'isotropic parameter');

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));