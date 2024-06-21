var dataset = ee.ImageCollection('MODIS/061/MOD09CMG')
                  .filter(ee.Filter.date('2018-01-01', '2018-02-01'));
var trueColor = dataset
                    .select([
                      'Coarse_Resolution_Surface_Reflectance_Band_1',
                      'Coarse_Resolution_Surface_Reflectance_Band_2',
                      'Coarse_Resolution_Surface_Reflectance_Band_3'
                    ])
                    .mean();
var trueColorVis = {
  min: -0.4,
  max: 1.0,
};

var lat = 6.747
var lon = 46.529
var zoom = 6;

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lat, lon, zoom);
Map.addLayer(trueColor, trueColorVis, 'True Color');

// Degrees in EPSG:3857.
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var image = trueColor.visualize(trueColorVis);
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
