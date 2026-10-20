var dataset = ee.ImageCollection('projects/openet/assets/reference_et/conus/gridmet/monthly/v1')
  .filterDate('2024-01-01', '2025-01-01');

// Compute the annual reference evapotranspiration (ET) as the sum of the
// monthly reference ET images for the year.
var et = dataset.select('eto').sum();

var visualization = {
  min: 600,
  max: 2200,
  palette: [
    '9e6212', 'ac7d1d', 'ba9829', 'c8b434', 'd6cf40', 'bed44b', '9fcb51',
    '80c256', '61b95c', '42b062', '45b677', '49bc8d', '4dc2a2', '51c8b8',
    '55cece', '4db4ba', '459aa7', '3d8094', '356681', '2d4c6e',
  ]
};

Map.setCenter(-100, 38, 5);

Map.addLayer(et, visualization, 'OpenET Bias Corrected GRIDMET Annual Reference ET');
