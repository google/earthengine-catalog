var dataset = ee.ImageCollection('NOAA/CPC/Precipitation')
                  .filter(ee.Filter.date('2018-01-01', '2019-01-01'));
var precipitation = dataset.select('precipitation');
var precipitationVis = {
  min: 0,
  max: 150,
  palette: ['#ADD8E6', '#008000', '#FFFF00', '#FFA500', '#FF0000', '#800080'],
};
Map.setCenter(-68.36, -6.73, 3);
Map.addLayer(precipitation, precipitationVis, 'NOAA CPC Precipitation');
