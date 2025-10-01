var dataset = ee.ImageCollection('USGS/3DEP/10m_collection');
var elevation = dataset.select('elevation').mean();
var elevationVis = {
  min: 0.0,
  max: 3000.0,
  palette: [
    '3ae237', 'b5e22e', 'd6e21f', 'fff705', 'ffd611', 'ffb613', 'ff8b13',
    'ff6e08', 'ff500d', 'ff0000', 'de0101', 'c21301', '0602ff', '235cb1',
    '307ef3', '269db1', '30c8e2', '32d3ef', '3be285', '3ff38f', '86e26f'
  ],
};

var lon = -112.8598;
var lat = 36.2841;

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 7);
Map.addLayer(elevation, elevationVis, 'Elevation');

// Degrees in EPSG:3857.
var delta = 1;
// Width and height of the thumbnail image.
var pixels = 256;

var image = elevation.visualize(elevationVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));