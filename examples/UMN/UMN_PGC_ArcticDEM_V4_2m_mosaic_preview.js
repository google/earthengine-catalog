var dataset = ee.Image('UMN/PGC/ArcticDEM/V4/2m_mosaic');
var elevation = dataset.select('elevation');
var elevationVis = {
  min: -50.0,
  max: 1000.0,
  palette: ['0d13d8', '60e1ff', 'ffffff'],
};

var lon = -63.402;
var lat = 66.368;
var delta = 1.1;

var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

var backGround = ee.Image.constant(0).visualize({palette:['808080'],min:0,max:0})

var image1 = elevation.visualize(elevationVis);

var imageWithBackground = ee.ImageCollection([backGround,image1]).mosaic();
Map.addLayer(elevation, elevationVis, 'ElevationArea');

Map.setCenter(lon, lat, 6);
print(ui.Thumbnail({image: imageWithBackground, params: visParams}));