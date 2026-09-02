var dataset = ee.ImageCollection('NASA/VIIRS/002/AERDB_D3_VIIRS_NOAA20')
                  .filter(ee.Filter.date('2023-08-01', '2023-08-10'));

var lon = 0.0;
var lat = 20.0;

Map.setCenter(lon, lat, 2);

var aot = dataset.select('Aerosol_Optical_Thickness_550_Land_Ocean_Mean').mean();

var aotVis = {
  min: 0.0,
  max: 1.0,
  palette: ['0000ff', '00ffff', '00ff00', 'ffff00', 'ff0000']
};

var visualizedImage = aot.visualize(aotVis);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground = waterLandBackground.blend(visualizedImage);

var pixels = 256;
var delta = 40.0;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBackground, {}, 'Aerosol Optical Thickness');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
