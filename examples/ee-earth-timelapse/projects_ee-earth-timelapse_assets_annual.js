// Timelapse

// Import the collection.
var timelapse = ee.ImageCollection('projects/ee-earth-timelapse/assets/annual')

// Point to center
var lon = -123.2939;
var lat = 46.449;

// Center the map.
Map.setCenter(lon, lat, 10);

// Filter the collection to the 2022 mosaic.
var timelapse2022 =
    timelapse.filter(ee.Filter.calendarRange(2022, 2022, 'year')).first();

// No visualization parameters needed.
Map.addLayer(timelapse2022);

// Thumbnail video params.
var pixels = 512;
var delta = 0.2;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  framesPerSecond: 5
};

print(ui.Thumbnail(timelapse, parameters));