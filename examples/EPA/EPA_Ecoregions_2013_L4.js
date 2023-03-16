var dataset = ee.FeatureCollection('EPA/Ecoregions/2013/L4');
var visParams = {
  palette: ['0a3b04', '1a9924', '15d812'],
  min: 0.0,
  max: 67800000000.0,
  opacity: 0.8,
};
var image = ee.Image().float().paint(dataset, 'shape_area');
Map.setCenter(-99.814, 40.166, 5);
Map.addLayer(image, visParams, 'EPA/Ecoregions/2013/L4');
Map.addLayer(dataset, null, 'for Inspector', false);
