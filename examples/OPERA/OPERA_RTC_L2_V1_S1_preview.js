var geometry = ee.Geometry.BBox(-18, 49, 8, 60);
var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gte(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});

var rtc_s1 = ee.ImageCollection('OPERA/RTC/L2_V1/S1')
                 .filterDate('2025-10-25', '2025-11-01')
                 .filterBounds(geometry)
                 .mean()
                 .mask(waterLandMask);

var image = rtc_s1.select('VV').visualize({min: 0, max: 0.5});
var imageParams = {
  dimensions: [256, 256],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
