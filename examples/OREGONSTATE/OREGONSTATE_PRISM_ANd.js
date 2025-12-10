var dataset = ee.ImageCollection('OREGONSTATE/PRISM/ANd')
                  .filter(ee.Filter.date('2024-08-01', '2024-08-15'));
var precipitation = dataset.select('ppt');
var precipitationVis = {
  min: 0.0,
  max: 50.0,
  palette: ['green', 'yellow', 'red', 'cyan', 'purple'],
};
Map.setCenter(-100.55, 40.71, 4);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
