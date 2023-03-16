var dataset = ee.ImageCollection('UCSB-CHG/CHIRPS/PENTAD')
                  .filter(ee.Filter.date('2018-05-01', '2018-05-05'));
var precipitation = dataset.select('precipitation');
var precipitationVis = {
  min: 0.0,
  max: 112.0,
  palette: ['001137', '0aab1e', 'e7eb05', 'ff4a2d', 'e90000'],
};
Map.setCenter(17.93, 7.71, 2);
Map.addLayer(precipitation, precipitationVis, 'Precipitation');
