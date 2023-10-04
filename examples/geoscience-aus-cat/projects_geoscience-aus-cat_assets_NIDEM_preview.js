var nidem = ee.Image('projects/geoscience-aus-cat/assets/NIDEM');

var elevation = nidem.select('nidem');
var visParams = {
  min: -2.5,
  max: 1.5,
  palette: [
    '440154', '471365', '482475', '463480', '414487', '3b528b', '355f8d',
    '2f6c8e', '2a788e', '25848e', '21918c', '1e9c89', '22a884', '2fb47c',
    '44bf70', '5ec962', '7ad151', '9bd93c', 'bddf26', 'dfe318', 'fde725'
  ],
};

var lon = 122.26;
var lat = -18.15;

Map.setCenter(lon, lat, 10);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Degrees in EPSG:3857.
var delta = 0.13;
// Width and height of the thumbnail image.
var pixels = 256;

Map.addLayer(
    elevation, visParams,
    'National Intertidal Digital Elevation Model (NIDEM; m)', false);

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var image = elevation.visualize(visParams);
var imageWithBackground = ee.ImageCollection([
  background, image]).mosaic();

Map.addLayer(
    imageWithBackground, {},
    'National Intertidal Digital Elevation Model (NIDEM; m)');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
