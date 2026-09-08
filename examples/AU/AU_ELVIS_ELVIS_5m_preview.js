var dataset = ee.ImageCollection('AU/ELVIS/ELVIS_5m');
var elevation = dataset.select('elevation').mosaic();
var elevationVis = {
  min: 0.0,
  max: 150.0,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
};

var lon = 153.0251;
var lat = -27.4698;

Map.setCenter(lon, lat, 11);

var delta = 0.08;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var image = elevation.visualize(elevationVis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

Map.addLayer(imageWithBackground, {}, 'Elevation');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
