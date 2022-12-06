var dataset = ee.ImageCollection('MODIS/MOD10A1')
    .filterDate('2015-01-01', '2016-01-01');

var visualization = {
  bands: ['Snow_Cover_Daily_Tile'],
  min: 0.0,
  max: 100.0,
  palette: ['black', '0dffff', '0524ff', 'ffffff']
};

Map.setCenter(-41.13, 76.35, 3);

Map.addLayer(dataset, visualization, 'Snow Cover');
