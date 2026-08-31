var dataset =
    ee.ImageCollection(
          'projects/gcp-public-data-weathernext/assets/weathernext_3_0_0_0p05deg')
        .filter(ee.Filter.date('2026-05-01T06:00:00Z', '2026-05-01T06:01:00Z'))
        .filter(ee.Filter.eq('forecast_hour', 6));
var temperature = dataset.select('station_head_temperature_2m_mean').first();

var lon = -80;
var lat = 10;

Map.setCenter(lon, lat, 2);

// Degrees in EPSG:4326
var lon_delta = 25;
var lat_delta = 25;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null,
    false);

var imageVis = {
  min: 220,
  max: 350,
  palette: [
    'darkblue', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red', 'darkred'
  ]
};

var imageVisualized = temperature.visualize(imageVis);

Map.addLayer(imageVisualized, null, 'Station Head 2m Temperature Mean');

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageVisualized, params: imageParams}));