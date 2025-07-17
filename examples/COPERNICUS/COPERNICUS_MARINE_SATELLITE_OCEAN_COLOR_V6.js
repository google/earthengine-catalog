var dataset = ee.ImageCollection('COPERNICUS/MARINE/SATELLITE_OCEAN_COLOR/V6')
                  .filter(ee.Filter.date('2024-06-01', '2024-07-01'));
var chlorA = dataset.select('chlor_a');
var chlorAVis = {
  min: 0,
  max: 1,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71, 52, 2);
Map.addLayer(
    chlorA, chlorAVis,
    'Chlorophyll-a concentration');
