var dataset = ee.ImageCollection('NASA/VIIRS/002/VNP09H1')
                  .filter(ee.Filter.date('2014-05-01', '2014-05-31'));

var lon = 7;
var lat = 55;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

// Degrees in SR-ORG:6974
var delta = 12.5;
// Width and height of the thumbnail image.
var pixels = 256;

var rgb = dataset.select(['SurfReflect_I1', 'SurfReflect_I2', 'SurfReflect_I3']).mosaic().visualize({min:0, max:1});

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'SR-ORG:6974',
  format: 'png',
};

Map.addLayer(rgb, {}, 'RGB');

print(ui.Thumbnail({image: rgb, params: visParams}));
