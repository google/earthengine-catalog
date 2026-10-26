var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ209H1')
                  .filter(ee.Filter.date('2026-09-30', '2026-10-08'));

var lon = -162.64;
var lat = -0.26;

Map.setCenter(lon, lat, 4);
Map.setOptions('SATELLITE');

var delta = 7.0;
var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);
// Width and height of the thumbnail image.
var pixels = 256;

var falseColor =
    dataset.select(['SurfReflect_I3', 'SurfReflect_I2', 'SurfReflect_I1'])
        .mosaic()
        .visualize({min: 0.0, max: 0.3, gamma: 1.4});

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(falseColor, {}, 'False Color (I3, I2, I1)');

print(ui.Thumbnail({image: falseColor, params: visParams}));
