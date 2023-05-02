var dataset = ee.Image('WORLDCLIM/V1/BIO');
var annualMeanTemperature = dataset.select('bio01').multiply(0.1);
var visParams = {
  min: -23,
  max: 30,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71.7, 52.4, 3);
Map.addLayer(annualMeanTemperature, visParams, 'Annual Mean Temperature');
