var dataset = ee.ImageCollection('OREGONSTATE/PRISM/AN81m')
                  .filter(ee.Filter.date('2018-07-01', '2018-07-31'));
var precipitation = dataset.select('ppt');
var precipitationVis = {
  min: 0.0,
  max: 300.0,
  palette: ['red', 'yellow', 'green', 'cyan', 'purple'],
};
Map.setCenter(-100.55, 40.71, 4);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
