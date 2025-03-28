// Get temperature forecasts created on 2025/03/26T12:00:00Z.
var forecasts = ee.ImageCollection('ECMWF/NRT_FORECAST/IFS/OPER')
                    .filter(ee.Filter.eq('creation_time', 1742990400000))
                    .select('temperature_2m_sfc')
                    .sort('forecast_hours');

// Chart the average forecasted temperature for all of Japan over the next 15
// days.
var japan = ee.FeatureCollection('WM/geoLab/geoBoundaries/600/ADM0')
                .filter(ee.Filter.eq('shapeName', 'Japan'))
                .first()
                .geometry();
print(ui.Chart.image.series({
  'imageCollection': forecasts,
  'region': japan,
  'xProperty': 'forecast_hours',
}));

// Also display the temperature forecast at hour 0.
Map.centerObject(japan);
Map.addLayer(
    forecasts.first().clip(japan), {
      min: -20,
      max: 40,
      palette: ['blue', 'green', 'yellow', 'orange', 'red'],
    },
    'Temperature at forecast hour 0 (deg C)');
