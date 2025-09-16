var lon = -27;
var lat = 5;
var delta = 65;
var delta2 = 85;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var dataset = ee.ImageCollection('NASA/SMAP/SPL4SMGP/008').first();

var smSurface = dataset.select('sm_surface');
var smSurfaceVis = {
  min: 0.0,
  max: 0.9,
  palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
};

var imageToDisplay = smSurface.visualize(smSurfaceVis).clip(areaOfInterest);

// Background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var blendedLayer = waterLandBackground.blend(imageToDisplay);

var pixels = 256;
var thumbParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({
  image: blendedLayer,
  params: thumbParams,
}));