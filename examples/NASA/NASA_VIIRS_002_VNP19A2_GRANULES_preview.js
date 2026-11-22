var collection = ee.ImageCollection('NASA/VIIRS/002/VNP19A2_GRANULES')
                     .select('Optical_Depth_047')
                     .filterDate('2012-01-19', '2012-01-24');

var lon = 76.0;
var lat = 13.0;

Map.setCenter(lon, lat, 6);

var aod = collection.mean();

var band_viz = {
  min: 0,
  max: 500,
  palette: ['black', 'blue', 'purple', 'cyan', 'green', 'yellow', 'red']
};

var visualizedImage = aod.visualize(band_viz);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground = waterLandBackground.blend(visualizedImage);

var pixels = 256;
var delta = 5.0;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBackground, {}, 'Optical Depth 047');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
