// Get temperature forecasts created on 2025/03/26T12:00:00Z and grab the
// single image for forecast hour 0.
var image = ee.ImageCollection('ECMWF/NRT_FORECAST/IFS/OPER')
                .filter(ee.Filter.eq('creation_time', 1742990400000))
                .select('temperature_2m_sfc')
                .sort('forecast_hours')
                .first();

var lat = 25.07;
var lon = 121.51;
var aoi = ee.Geometry.BBox(lon - 25, lat - 25, lon + 25, lat + 25);
var pixels = 256;

// Only show the surface temperature over land.
var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});
image = image.mask(waterLandMask).visualize({
  min: -20,
  max: 40,
  palette: ['blue', 'green', 'yellow', 'orange', 'red'],
});

var imageParams = {
  dimensions: [pixels, pixels],
  region: aoi,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
