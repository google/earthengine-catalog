var dataset = ee.ImageCollection('MODIS/006/MOD10A1')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var snowCover = dataset.select('NDSI_Snow_Cover');
var snowCoverVis = {
  min: 0.0,
  max: 100.0,
  palette: ['black', '0dffff', '0524ff', 'ffffff'],
};
Map.setCenter(-41.13, 76.35, 2);
Map.addLayer(snowCover, snowCoverVis, 'Snow Cover');
