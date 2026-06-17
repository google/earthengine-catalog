var dataset = ee.ImageCollection('UCSB-CHC/CHIRPS/V3/DAILY_SAT')
                  .filter(ee.Filter.date('2018-05-01', '2018-05-31'));
var precipitation = dataset.select('precipitation');
var precipitationVis = {
  min: 1.0,
  max: 17.0,
  palette: ['#001137', '#0aab1e', '#e7eb05', '#2c7fb8', '#253494'],
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
