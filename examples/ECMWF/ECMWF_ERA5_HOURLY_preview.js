var image = ee.ImageCollection('ECMWF/ERA5/HOURLY')
                .select('temperature_2m')
                .first();

var lat = 39.51;
var lon = -100.77;
var aoi = ee.Geometry.BBox(lon - 15, lat - 15, lon + 15, lat + 15);
var pixels = 256;

// Only show the surface temperature over land.
var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});
image = image.mask(waterLandMask).visualize({
  min: 250.0,
  max: 320.0,
  palette: [
    '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
    '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
    'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
  ]
});

var imageParams = {
  dimensions: [pixels, pixels],
  region: aoi,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
