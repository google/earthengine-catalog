var dataset = ee.FeatureCollection('WCMC/WDPCA/current/polygons');
var visParams = {
  palette: ['2ed033', '5aff05', '67b9ff', '5844ff', '0a7618', '2c05ff'],
  min: 0.0,
  max: 1550000.0,
  opacity: 0.8,
};
var image = ee.Image().float().paint(dataset, 'REP_AREA');
Map.setCenter(23.8, -18.26, 4);
Map.addLayer(image, visParams, 'Site Extent');
Map.addLayer(dataset, null, 'for Inspector', false);
