var dataset = ee.ImageCollection('NOAA/CDR/SST_PATHFINDER/V53')
                  .filter(ee.Filter.date('2014-05-01', '2014-05-14'));
var seaSurfaceTemperature = dataset.select('sea_surface_temperature');
var visParams = {
  min: 0.0,
  max: 2500.0,
  palette: [
    '030d81', '0519ff', '05e8ff', '11ff01', 'fbff01', 'ff9901', 'ff0000',
    'ad0000'
  ],
};
Map.setCenter(-121.99, -2.11, 2);
Map.addLayer(seaSurfaceTemperature, visParams, 'Sea Surface Temperature');
