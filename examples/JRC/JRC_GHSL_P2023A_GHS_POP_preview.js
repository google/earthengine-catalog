var baseChange =
    [{featureType: 'all', stylers: [{saturation: -100}, {lightness: 45}]}];
Map.setOptions('baseChange', {'baseChange': baseChange});
var image1975 = ee.Image('JRC/GHSL/P2023A/GHS_POP/1975');
var populationCountVis = {
  min: 0.0,
  max: 100.0,
  palette:
      ['000004', '320A5A', '781B6C', 'BB3654', 'EC6824', 'FBB41A', 'FCFFA4']
};

var lon = 8;
var lat = 48;

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
image1975 = image1975.updateMask(image1975.gt(0));

Map.addLayer(image1975, populationCountVis, 'Population count, 1975');

var population_count = image1975.select('population_count');
var image = population_count.visualize(populationCountVis);
print(ui.Thumbnail({image: image, params: visParams}));