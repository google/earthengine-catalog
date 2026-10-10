var dataset = ee.ImageCollection(
    'projects/climate-and-sustainability/assets/gem-15_v1');
var mosaic = dataset.mosaic();

var elevationVis = {
  min: 20.0,
  max: 100.0,
  palette: [
    'fadd67', 'b8b257', '7ca88f', '4aa4ca', '3869d1',
    '6f5bc8', 'b862b0', 'bc3a6b', 'cb3438', 'f08429', 'fbd227'
  ]
};

var heightVis = {
  min: 0.0,
  max: 40.0,
  palette: ['ffffff', 'e5f5e0', 'a1d99b', '41ab5d', '238b45', '00441b']
};

Map.setCenter(2.165, 41.395, 14);
Map.addLayer(mosaic.select('dtm'), elevationVis, 'GEM-15 DTM (15m)', false);
Map.addLayer(
    mosaic.select('dsm_percentile_95'), elevationVis,
    'GEM-15 DSM 95th Percentile (15m)', false);
Map.addLayer(
    mosaic.select('dsm').subtract(mosaic.select('dtm')), heightVis,
    'Above-Ground Height (DSM - DTM; m)', false);
Map.addLayer(mosaic.select('dsm'), elevationVis, 'GEM-15 DSM (15m)');
