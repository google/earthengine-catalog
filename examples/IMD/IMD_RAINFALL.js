var dataset = ee.ImageCollection('IMD/RAINFALL')
                  .filter(ee.Filter.date('2024-07-15', '2024-07-16'));
var rainfall = dataset.select('rainfall');

var rainfallVis = {
  min: 0.0,
  max: 50.0,
  palette: ['ffffcc', 'a1dab4', '41b6c4', '2c7fb8', '253494'],
};

Map.setCenter(82.5, 22.5, 4);
Map.addLayer(rainfall, rainfallVis, 'Daily Rainfall (mm)');
