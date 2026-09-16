var dataset =
    ee.ImageCollection(
          'projects/gcp-public-data-weathernext/assets/weathernext_3_0_0_0p1deg')
        .filter(ee.Filter.date('2026-05-01T06:00:00Z', '2026-05-01T06:01:00Z'))
        .filter(ee.Filter.eq('forecast_hour', 6));
var temperature = dataset.select('temperature_2m_mean');

var visParams = {
  min: 220,
  max: 350,
  palette: [
    'darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red', 'darkred'
  ]
};

Map.addLayer(temperature, visParams, '2m Temperature Mean');
