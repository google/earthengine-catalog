var dataset = ee.ImageCollection('ECMWF/ERA5/HOURLY_PRESSURE_LEVELS')
                .filter(ee.Filter.date('2026-06-03', '2026-06-04'));

var visualization = {
  bands: ['u_component_of_wind_1000hPa'],
  min: -15.0,
  max: 15.0,
  palette: ['blue', 'cyan', 'white', 'yellow', 'red']
};

Map.setCenter(22.2, 21.2, 3);

Map.addLayer(dataset, visualization, 'U component of wind at 1000hPa [m/s]');
