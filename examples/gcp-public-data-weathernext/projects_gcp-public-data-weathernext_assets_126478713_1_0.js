var dataset =
    ee.ImageCollection(
          'projects/gcp-public-data-weathernext/assets/126478713_1_0')
        .filter(ee.Filter.date('2020-10-01T06:00:00Z', '2020-10-01T06:01:00Z'))
        .filter(ee.Filter.eq('ensemble_member', '8'))
        .filter(ee.Filter.eq('forecast_hour', 12));
var temperature = dataset.select('2m_temperature');

var visParams = {
  min: 220,
  max: 350,
  palette: [
    'darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red', 'darkred'
  ]
};

Map.addLayer(temperature, visParams, '2m Temperature');
