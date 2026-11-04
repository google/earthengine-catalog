var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ209GA')
                  .filter(ee.Filter.date('2026-10-11', '2026-10-12'));

var lon = -120.5;
var lat = 37.5;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

var delta = 3.5;
var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);
// Width and height of the thumbnail image.
var pixels = 256;

var rgb = dataset.select(['M5', 'M4', 'M3'])
              .mosaic()
              .visualize({min: 0.0, max: 0.3});

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(rgb, {}, 'RGB');

print(ui.Thumbnail({image: rgb, params: visParams}));
