function aodWithGoodQc(image) {
  var qcBand = image.select('QCAll');
  var mask = qcBand.eq(0);
  var aodBand = image.select('AOD550');
  var raster = aodBand.updateMask(mask);
  var raster_mean = raster.reduceNeighborhood({
    reducer: ee.Reducer.mean(),
    kernel: ee.Kernel.square({radius: 2, units: 'pixels'}),
    skipMasked: false
  });
  return raster.unmask(raster_mean);
}

var aodVis = {
  min: 0,
  max: 1,
  palette: ['800080', '0000ff', '00ffff', '008000', 'ffff00', 'ff0000']
};

var lon = -100;
var lat = 20;

Map.setCenter(lon, lat, 3);

var images = ee.ImageCollection('NOAA/VIIRS/AOD_EDR/V3')
  .filterDate('2023-05-16', '2023-05-17')
  .map(aodWithGoodQc);

var aodImage = images.mosaic().visualize(aodVis);

// Add water and land background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var imageWithBackground = ee.ImageCollection([waterLandBackground, aodImage]).mosaic();

Map.addLayer(imageWithBackground, {}, 'AOD550 with Background');

// Degrees in EPSG:3857.
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
