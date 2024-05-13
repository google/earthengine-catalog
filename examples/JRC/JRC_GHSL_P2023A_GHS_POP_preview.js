var baseChange =
    [{featureType: 'all', stylers: [{saturation: -100}, {lightness: 45}]}];
Map.setOptions('baseChange', {'baseChange': baseChange});
var image2020 = ee.Image('JRC/GHSL/P2023A/GHS_POP/2020');
var populationCountVis = {
  min: 0.0,
  max: 100.0,
  palette:
    ['000004', '320A5A', '781B6C', 'BB3654', 'EC6824', 'FBB41A', 'FCFFA4']
  };

var lon = -0.2;
var lat = 51;

var delta = 3.5;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

Map.setCenter(lon, lat, 7);
image2020 = image2020.updateMask(image2020.gt(0));
var population_count = image2020.select('population_count');
var image = population_count.visualize(populationCountVis);

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground = ee.ImageCollection([
  waterLandBackground, image]).mosaic();

Map.addLayer(imageWithBackground, {}, 'Population count, 2020');

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));
