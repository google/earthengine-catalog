var dataset = ee.ImageCollection('NOAA/CDR/VIIRS/LAI_FAPAR/V1')
                  .filter(ee.Filter.date('2018-02-01', '2018-03-01'));
var leafAreaIndex = dataset.select('LAI').first();
var leafAreaIndexVis = {
  min: 0.0,
  max: 4000.0,
  palette: ['3b0200', '977705', 'ca9f06', 'ffca09', '006a03', '003b02'],
};

var lon = 7.71;
var lat = 17.93;


var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var background = waterLand.visualize({palette: backgroundPalette});

Map.setCenter(lon, lat, 3);
Map.addLayer(leafAreaIndex, leafAreaIndexVis, 'LAI');

// Degrees in EPSG:3857.
var delta = 25;
// Width and height of the thumbnail image.
var pixels = 256;

var image = leafAreaIndex.visualize(leafAreaIndexVis);
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
