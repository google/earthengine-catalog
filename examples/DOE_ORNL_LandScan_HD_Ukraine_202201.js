var dataset = ee.Image('DOE/ORNL/LandScan_HD/Ukraine_202201');
var vis = {
  min: 0.0,
  max: 10.0,
  palette:['lemonchiffon', 'khaki', 'orange','orangered', 'red', 'maroon'],
};
Map.centerObject(dataset)
Map.addLayer(dataset, vis, 'Population Count');
