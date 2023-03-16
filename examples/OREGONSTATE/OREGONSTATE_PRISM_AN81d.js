var dataset = ee.ImageCollection('OREGONSTATE/PRISM/AN81d')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var precipitation = dataset.select('ppt');
var precipitationVis = {
  min: 0.0,
  max: 50.0,
  palette: ['red', 'yellow', 'green', 'cyan', 'purple'],
};
Map.setCenter(-100.55, 40.71, 4);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
