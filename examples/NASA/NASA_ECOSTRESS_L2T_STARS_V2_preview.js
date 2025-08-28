var dataset = ee.ImageCollection('NASA/ECOSTRESS/L2T_STARS/V2')
                  .filter(ee.Filter.date('2025-03-01', '2025-05-01'));

var NDVI = dataset.select('NDVI').mean();

var vis = {
  min: -1.0,
  max: 1.0,
  palette: ['00008B', 'A9A9A9', 'CD853F', 'FFFF00', '90EE90', '006400'],
};

var image = NDVI.visualize(vis);

var lon = -77.1056;
var lat = 38.8904;

var geometry = ee.Geometry.Polygon(
    [[
      [-101.79242340245405, 31.38073552740544],
      [-101.79242340245405, 13.868893720544934],
      [-71.55804840245405, 13.868893720544934],
      [-71.55804840245405, 31.38073552740544]
    ]],
    null, false);

var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});
var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image]).mosaic();

Map.setCenter(lon, lat, 10);
Map.addLayer(imageWithBackground)

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));