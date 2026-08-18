// Define the specific image asset.
var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP22Q2')
                  .filter(ee.Filter.date('2017-01-01', '2017-12-31'));
var image = dataset.first();

// Define visualization bands and params.
var rgb = image.select([
  'EVI2_Growing_Season_Area_1',
  'PGQ_Growing_Season_1',
  'Greenness_Agreement_Growing_Season_1'
]);
var rgbVis = {
  min: [0, 0, 0],
  max: [75, 150, 200],
};

// Define center and vertical span of the thumbnail
var lon = 17.93;   // Center of interest (Longitude)
var lat = 7.71;    // Center of interest (Latitude)
var delta = 35;    // The vertical (Latitude) half-span

var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visualizedImage = rgb.visualize(rgbVis);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, visualizedImage]).mosaic();

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.setCenter(lon, lat, 4);
Map.addLayer(imageWithBackground, {}, 'VNP22Q2.002 Preview');
