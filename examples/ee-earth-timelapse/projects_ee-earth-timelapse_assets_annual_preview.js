// Timelapse

// Import the collection.
var timelapse = ee.ImageCollection('projects/ee-earth-timelapse/assets/annual');

// Filter the collection to the 2022 mosaic.
var timelapse2022 =
    timelapse.filter(ee.Filter.calendarRange(2022, 2022, 'year')).first();

// Preview image.
var lon = 139.4081;
var lat = -7.169;
var delta = 0.2;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

print(ui.Thumbnail({image: timelapse2022, params: parameters}));