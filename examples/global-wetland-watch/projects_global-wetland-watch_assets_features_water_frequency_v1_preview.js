var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/water/frequency/v1');
var swf = dataset.filter(ee.Filter.eq('product', 'multiannual')).mosaic().select('swf')
    .setDefaultProjection(dataset.first().projection());

// San Francisco Bay salt ponds, USA. Thumbnail region [west, south, east, north].
var region = [-122.08, 37.4324, -121.96, 37.5276];
var lon = -122.02;
var lat = 37.48;
Map.setCenter(lon, lat, 12);

// Average the native pixels into each thumbnail pixel (EPSG:3857 meters per pixel).
var scale = (region[2] - region[0]) * Math.PI / 180 * 6378137 / 256;
var averaged = swf.unmask(0)
    .reduceResolution({reducer: ee.Reducer.mean(), maxPixels: 65536})
    .reproject({crs: 'EPSG:3857', scale: scale});

var visParams = {
  min: 0,
  max: 100,
  palette: ['ffffff', 'e8e5fa', 'd0ccf5', 'bab3f1', '989be7', '6181d0', '3669ad', '275186'],
};
var image = averaged.updateMask(averaged.gt(5)).visualize(visParams);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Surface water frequency (2017-2025)');

var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle(region, null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
