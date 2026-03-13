var dataset = ee.ImageCollection('OpenET/DISALEXI/CONUS/GRIDMET/MONTHLY/v2_0')
  .filterDate('2020-01-01', '2021-01-01');

// Compute the annual evapotranspiration (ET) as the sum of the monthly ET
// images for the year.
var et = dataset.select('et').sum();

var visualization = {
  min: 0,
  max: 1400,
  palette: [
    '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b', '9fcb51',
    '80c256', '61b95c', '42b062', '45b677', '49bc8d', '4dc2a2', '51c8b8',
    '55cece', '4db4ba', '459aa7', '3d8094', '356681', '2d4c6e',
  ]
};

Map.setCenter(-100, 38, 5);

Map.addLayer(et, visualization, 'OpenET DisALEXI Annual ET');
