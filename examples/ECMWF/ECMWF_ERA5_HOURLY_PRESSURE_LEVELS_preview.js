var image = ee.ImageCollection('ECMWF/ERA5/HOURLY_PRESSURE_LEVELS')
                .select('u_component_of_wind_1000hPa')
                .first();

var lat = 39.51;
var lon = -100.77;
var aoi = ee.Geometry.BBox(lon - 15, lat - 15, lon + 15, lat + 15);
var pixels = 256;

var visualized = image.visualize({
  min: -15.0,
  max: 15.0,
  palette: ['blue', 'cyan', 'white', 'yellow', 'red']
});

var imageParams = {
  dimensions: [pixels, pixels],
  region: aoi,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: visualized, params: imageParams}));
