var image = ee.Image('ECMWF/ERA5_LAND/STATIC').select('soil_type');

var lat = 39.51;
var lon = -100.77;
var aoi = ee.Geometry.BBox(lon - 15, lat - 15, lon + 15, lat + 15);
var pixels = 256;

var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});
var visualized = image.mask(image.gt(0)).visualize({
  min: 1.0,
  max: 7.0,
  palette: [
    'e8d9a8', // 1 Coarse – pale sand
    'd2b48c', // 2 Medium – light tan
    'b8935f', // 3 Medium fine – warm brown
    '8b5a2b', // 4 Fine – medium brown
    '6b4423', // 5 Very fine – deep clay brown
    '3e2c1c', // 6 Organic – dark peat
    '26140b'  // 7 Tropical organic – near-black humus
  ]
});

var imageParams = {
  dimensions: [pixels, pixels],
  region: aoi,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(visualized);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
