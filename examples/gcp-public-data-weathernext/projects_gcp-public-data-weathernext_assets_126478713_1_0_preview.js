var dataset =
    ee.ImageCollection(
          'projects/gcp-public-data-weathernext/assets/126478713_1_0')
        .filter(ee.Filter.date('2020-10-01T06:00:00Z', '2020-10-01T06:01:00Z'))
        .filter(ee.Filter.eq('ensemble_member', '8'))
        .filter(ee.Filter.eq('forecast_hour', 12));
var temperature = dataset.select('2m_temperature').first();

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

Map.addLayer(imageVisualized, null, '2m Temperature');

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageVisualized, params: imageParams}));