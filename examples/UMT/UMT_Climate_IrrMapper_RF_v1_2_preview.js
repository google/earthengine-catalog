var dataset = ee.Image('projects/ee-dgketchum/assets/IrrMapper/version1_2/ID_2021');

var lon = -112.381;
var lat = 44.0;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:4326
var delta = 0.3;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var image = dataset.visualize({palette:['blue'], min: 0, max: 1});

Map.addLayer(dataset, {palette:['blue'], opacity: 1.0}, 'IrrMapper Vers 1.2', true);

print(ui.Thumbnail({image: image, params: visParams}));