var coll = ee.ImageCollection('JAXA/ALOS/PALSAR-2/Level2_1/StripMap_202401');
var before = coll.filterDate('2022-09-26', '2023-12-31');
var after = coll.filterDate('2024-01-01', '2024-01-03');

var image = ee.Image(after.mosaic().subtract(before.mosaic()));
var HH = image.select('b1')

var Vis = {
  min: 0.0,
  max: 500.0,
};

// Width and height of the thumbnail image.
var pixels = 256;

// Region of Japan.
var areaOfInterest =
    ee.Geometry.Rectangle([136.6268, 37.3951, 137.2571, 36.6451], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var image = image.visualize(Vis);

Map.setCenter(137.2228, 37.1204, 10);
Map.addLayer(image, {}, 'HH polarization');

print(ui.Thumbnail({image: image, params: visParams}));
