// Load the PRISM dataset
var dataset = ee.ImageCollection('OREGONSTATE/PRISM/ANm')
               .filter(ee.Filter.date('2024-08-01', '2024-11-01'));
var precipitation = dataset.select('ppt');
// Visualization parameters
var precipitationVis = {
 min: 0.0,
 max: 300.0,
 palette: ['green', 'yellow', 'red', 'cyan', 'purple'],
};
// Load a USA boundary for masking
var usa = ee.FeatureCollection('USDOS/LSIB_SIMPLE/2017')
            .filter(ee.Filter.eq('country_na', 'United States'));
// Clip precipitation data to USA boundary
var precipitationUSA = precipitation.mean().clip(usa);

var lon = -98.58;
var lat = 39.83;
Map.setCenter(lon, lat, 4);

// Degrees in EPSG:3857.
var delta = 30;
var delta2 = 20;
// Width and height of the thumbnail image.
var pixels = 256;

var image_viz = precipitationUSA.visualize(precipitationVis);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta2, lon + delta, lat + delta2], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var background = ee.Image(1).visualize({palette: ['white']});
var imageWithBackground = ee.ImageCollection([background, image_viz]).mosaic();

Map.addLayer(imageWithBackground, {}, 'Precipitation');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
