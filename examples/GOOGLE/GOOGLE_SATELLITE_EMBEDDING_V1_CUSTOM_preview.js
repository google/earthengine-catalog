var dataset = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/CORCORAN_CITY_2026_AGRICULTURAL_CHANGE');

var roi = ee.Geometry.Rectangle([-119.649, 36.001, -119.451, 36.199], null, false);
var sampleImage = dataset
    .filterDate('2026-03-15', '2026-05-15')
    .filterBounds(roi)
    .mosaic();

var background = ee.Image.constant(0.85).visualize({min: 0, max: 1});
var foreground = sampleImage.visualize({
  min: -0.3,
  max: 0.3,
  bands: ['A01', 'A16', 'A09'],
});

print(ui.Thumbnail({
  image: background.blend(foreground),
  params: {
    dimensions: [256, 256],
    region: roi,
    crs: 'EPSG:4326',
    format: 'png',
  },
}));
