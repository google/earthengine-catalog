var dataset = ee.Image('ACA/reef_habitat/v2_0');

// Teti'aroa, an atoll in French Polynesia.
var lon = -149.56194;
var lat = -17.00872;

Map.setCenter(lon, lat, 13);
Map.setOptions('SATELLITE');

// Degrees in EPSG:3857.
var delta = 0.05;
// Width and height of the thumbnail image.
var pixels = 256;

// cadetblue
var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 255});

// The visualizations are baked into the image properties.
// Benthic habitat classification.
var benthicHabitat = dataset.select('benthic').selfMask();

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:3857',
    format: 'png',
  };

// TODO(b/267786257): Trouble here: This is just black and white.
print(ui.Thumbnail({image: benthicHabitat, params: imageParams}));

var visParams = {
  min: 11,
  max: 18,
  palette: [
    'ffffbe', 'e0d05e', 'b19c3a', '668438',
    'ff6161', '000000', '000000', '9bcc4f'],
};

var image = benthicHabitat.visualize(visParams);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.addLayer(imageWithBackground, {}, 'Benthic habitat');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
