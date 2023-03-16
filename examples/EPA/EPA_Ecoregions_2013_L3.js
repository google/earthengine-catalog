var dataset = ee.FeatureCollection('EPA/Ecoregions/2013/L3');
var visParams = {
  palette: ['0a3b04', '1a9924', '15d812'],
  min: 23.0,
  max: 3.57e+11,
  opacity: 0.8,
};
var image = ee.Image().float().paint(dataset, 'shape_area');
Map.setCenter(-99.814, 40.166, 5);
Map.addLayer(image, visParams, 'EPA/Ecoregions/2013/L3');
Map.addLayer(dataset, null, 'for Inspector', false);
