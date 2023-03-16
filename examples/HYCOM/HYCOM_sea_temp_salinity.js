// Import the time series of global images, filter 15 days in August, 2018.
var dataset = ee.ImageCollection('HYCOM/sea_temp_salinity')
    .filter(ee.Filter.date('2018-08-01', '2018-08-15'));

// Select water temperature at 0 meters and scale to degrees C.
var seaWaterTemperature = dataset.select('water_temp_0')
    .map(function scaleAndOffset(image) {
      return ee.Image(image).multiply(0.001).add(20);
    });

// Define visualization parameters.
var visParams = {
  min: -2.0,  // Degrees C
  max: 34.0,
  palette: ['000000', '005aff', '43c8c8', 'fff700', 'ff0000'],
};

// Display mean 15-day temperature on the map.
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(seaWaterTemperature.mean(), visParams, 'Sea Water Temperature');
