var dataset = ee.ImageCollection('NCEP_RE/surface_temp')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var surfaceAirTemperature = dataset.select('air');
var surfaceAirTemperatureVis = {
  min: 230.0,
  max: 308.0,
  palette: [
    '800080', '0000ab', '0000ff', '008000', '19ff2b', 'a8f7ff', 'ffff00',
    'd6d600', 'ffa500', 'ff6b01', 'ff0000'
  ],
};
Map.setCenter(71.72, 52.48, 3.0);
Map.addLayer(
    surfaceAirTemperature, surfaceAirTemperatureVis, 'Surface Air Temperature');
