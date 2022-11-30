var dataset = ee.Image('WORLDCLIM/V1/BIO');
var annualMeanTemperature = dataset.select('bio01');
var visParams = {
  min: -230.0,
  max: 300.0,
  palette: ['blue', 'purple', 'cyan', 'green', 'yellow', 'red'],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(annualMeanTemperature, visParams, 'Annual Mean Temperature');
