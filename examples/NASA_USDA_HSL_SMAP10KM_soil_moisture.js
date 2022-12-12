var dataset = ee.ImageCollection('NASA_USDA/HSL/SMAP10KM_soil_moisture')
                  .filter(ee.Filter.date('2017-04-01', '2017-04-30'));
var soilMoisture = dataset.select('ssm');
var soilMoistureVis = {
  min: 0.0,
  max: 28.0,
  palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
};
Map.setCenter(-6.746, 46.529, 2);
Map.addLayer(soilMoisture, soilMoistureVis, 'Soil Moisture');
