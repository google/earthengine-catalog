// Get data generated from model hour 0 for January 1st, 2019.
var dataset = ee.ImageCollection('ECMWF/CAMS/NRT')
                  .filterDate('2019-01-01', '2019-01-02')
                  .filter('model_initialization_hour == 0');

// Select first and last forecast hours.
var hour00 = dataset.filter('model_forecast_hour == 0').first();
var hour21 = dataset.filter('model_forecast_hour == 21').first();

// Visualization parameters for specified aerosol band.
var visParams = {
  bands: ['total_aerosol_optical_depth_at_550nm_surface'],
  min: 0.0,
  max: 3.6,
  palette: [
    '5e4fa2', '3288bd', '66c2a5', 'abe0a4', 'e6f598', 'ffffbf',
    'fee08b', 'fdae61', 'f46d43', 'd53e4f', '9e0142'
  ]
};

// Display forecasts on the map.
Map.setCenter(70, 45, 3);
Map.addLayer(hour00, visParams, 'Total Aerosal Optical Depth - H00', true, 0.8);
Map.addLayer(hour21, visParams, 'Total Aerosal Optical Depth - H21', true, 0.8);
