var dataset = ee.ImageCollection('IDAHO_EPSCOR/MACAv2_METDATA_MONTHLY')
                  .filter(ee.Filter.date('2018-07-01', '2018-08-01'));
var maximumTemperature = dataset.select('tasmax');
var maximumTemperatureVis = {
  min: 290.0,
  max: 314.0,
  palette: ['d8d8d8', '4addff', '5affa3', 'f2ff89', 'ff725c'],
};
Map.setCenter(-115.356, 38.686, 5);
Map.addLayer(maximumTemperature, maximumTemperatureVis, 'Maximum Temperature');
