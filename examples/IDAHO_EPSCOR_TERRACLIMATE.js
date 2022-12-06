var dataset = ee.ImageCollection('IDAHO_EPSCOR/TERRACLIMATE')
                  .filter(ee.Filter.date('2017-07-01', '2017-08-01'));
var maximumTemperature = dataset.select('tmmx');
var maximumTemperatureVis = {
  min: -300.0,
  max: 300.0,
  palette: [
    '1a3678', '2955bc', '5699ff', '8dbae9', 'acd1ff', 'caebff', 'e5f9ff',
    'fdffb4', 'ffe6a2', 'ffc969', 'ffa12d', 'ff7c1f', 'ca531a', 'ff0000',
    'ab0000'
  ],
};
Map.setCenter(71.72, 52.48, 3);
Map.addLayer(maximumTemperature, maximumTemperatureVis, 'Maximum Temperature');
