// Example script to load and visualize ERA5 climate reanalysis parameters in
// Google Earth Engine

// Daily mean 2m air temperature
var era5_2mt = ee.ImageCollection('ECMWF/ERA5/DAILY')
                   .select('mean_2m_air_temperature')
                   .filter(ee.Filter.date('2019-07-01', '2019-07-31'));
print(era5_2mt);

// Daily total precipitation sums
var era5_tp = ee.ImageCollection('ECMWF/ERA5/DAILY')
                  .select('total_precipitation')
                  .filter(ee.Filter.date('2019-07-01', '2019-07-31'));

// Daily mean 2m dewpoint temperature
var era5_2d = ee.ImageCollection('ECMWF/ERA5/DAILY')
                  .select('dewpoint_2m_temperature')
                  .filter(ee.Filter.date('2019-07-01', '2019-07-31'));

// Daily mean sea-level pressure
var era5_mslp = ee.ImageCollection('ECMWF/ERA5/DAILY')
                    .select('mean_sea_level_pressure')
                    .filter(ee.Filter.date('2019-07-01', '2019-07-31'));

// Daily mean surface pressure
var era5_sp = ee.ImageCollection('ECMWF/ERA5/DAILY')
                  .select('surface_pressure')
                  .filter(ee.Filter.date('2019-07-01', '2019-07-31'));

// Daily mean 10m u-component of wind
var era5_u_wind_10m = ee.ImageCollection('ECMWF/ERA5/DAILY')
                          .select('u_component_of_wind_10m')
                          .filter(ee.Filter.date('2019-07-01', '2019-07-31'));

// Convert pressure levels from Pa to hPa - Example for surface pressure
var era5_sp = era5_sp.map(function(image) {
  return image.divide(100).set(
      'system:time_start', image.get('system:time_start'));
});

// Visualization palette for total precipitation
var visTp = {
  min: 0,
  max: 0.1,
  palette: ['#FFFFFF', '#00FFFF', '#0080FF', '#DA00FF', '#FFA400', '#FF0000']
};

// Visualization palette for temperature (mean, min and max) and 2m dewpoint
// temperature
var vis2mt = {
  min: 250,
  max: 320,
  palette: [
    '#000080', '#0000D9', '#4000FF', '#8000FF', '#0080FF', '#00FFFF', '#00FF80',
    '#80FF00', '#DAFF00', '#FFFF00', '#FFF500', '#FFDA00', '#FFB000', '#FFA400',
    '#FF4F00', '#FF2500', '#FF0A00', '#FF00FF'
  ]
};

// Visualization palette for u- and v-component of 10m wind
var visWind = {
  min: 0,
  max: 30,
  palette: [
    '#FFFFFF', '#FFFF71', '#DEFF00', '#9EFF00', '#77B038', '#007E55', '#005F51',
    '#004B51', '#013A7B', '#023AAD'
  ]
};

// Visualization palette for pressure (surface pressure, mean sea level
// pressure) - adjust min and max values for mslp to min:990 and max:1050
var visPressure = {
  min: 500,
  max: 1150,
  palette: [
    '#01FFFF', '#058BFF', '#0600FF', '#DF00FF', '#FF00FF', '#FF8C00', '#FF8C00'
  ]
};


// Add layer to map
Map.addLayer(
    era5_tp.filter(ee.Filter.date('2019-07-15')), visTp,
    'Daily total precipitation sums');
Map.addLayer(
    era5_2d.filter(ee.Filter.date('2019-07-15')), vis2mt,
    'Daily mean 2m dewpoint temperature');
Map.addLayer(
    era5_2mt.filter(ee.Filter.date('2019-07-15')), vis2mt,
    'Daily mean 2m air temperature');
Map.addLayer(
    era5_u_wind_10m.filter(ee.Filter.date('2019-07-15')), visWind,
    'Daily mean 10m u-component of wind');
Map.addLayer(
    era5_sp.filter(ee.Filter.date('2019-07-15')), visPressure,
    'Daily mean surface pressure');

Map.setCenter(21.2, 22.2, 2);
