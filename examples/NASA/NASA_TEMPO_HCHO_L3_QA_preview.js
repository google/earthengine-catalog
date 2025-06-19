var visParams = {
  min: 0,
  max: 1.5e16,
  bands: ['vertical_column'],
  palette: [
    '000080', '0000D9', '4000FF', '8000FF', '0080FF',
    '00D9FF', '80FFFF', 'FF8080', 'D90000', '800000'
  ]
};

// thumbnail location
var lon = -98.62;
var lat = 33.50;

//Background
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

var delta = 5;
var pixels = 256;


var collection = ee.ImageCollection('NASA/TEMPO/HCHO_L3_QA')
    .filterDate('2024-04-01', '2024-04-05');
var image = collection.mosaic().visualize(visParams);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Specify the thumbnail parameters.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
Map.setCenter(lon, lat, 3)
Map.addLayer(imageWithBackground, {}, 'HCHO vertical column')
