var dataset = ee.FeatureCollection.loadBigQueryTable('earth-engine-public-data.tallo.tallo_v1')
                  .filter(ee.Filter.notNull(['height_m']));

var heights = dataset.select('height_m');

var heightVis = {
  min: 5,
  max: 35,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
  forceRgbOutput: true
};

// Create an empty image and paint the features, coloring by 'height_m'.
var image = ee.Image().float().paint({
  featureCollection: heights,
  color: 'height_m',
  width: 5
});

image = image.updateMask(image.neq(0));
// ***************************************************************

var lon = -100.5;
var lat = 30.2;

var geometry = ee.Geometry.Polygon(
    [[[-130, 40],
      [-130, -20],
      [-55, -10],
      [-55, 55]]],
    null, false);

var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image.visualize(heightVis)]).mosaic();

Map.setCenter(lon, lat, 4);
Map.addLayer(imageWithBackground, {}, 'Tallo Tree Heights (with background)');

print('Thumbnail of height data with background:');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
