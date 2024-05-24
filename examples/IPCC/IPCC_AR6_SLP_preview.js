var ipccImage = ee.Image('IPCC/AR6/SLP/ssp126_2030')
  .select('total_values_quantile_0_5');

var lon = -106.24;
var lat = 10.04;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['lightgray'];
var waterLandVis = {palette: backgroundPalette};
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

Map.setCenter(lon, lat, 2);

var delta = 80;
var pixels = 256;

var ipccImageVis = {
  min: 0,
  max: 150.0,
  palette: ['0000FF', '0099FF', '00FFFF', '00FF99', '00FF00', '99FF00', 'FFFF00', 'FF9900', 'FF0000'],
};

var ipccImageVisualized = ipccImage.visualize(ipccImageVis);
var imageWithBackground = ee.ImageCollection([waterLandBackground, ipccImageVisualized]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

Map.addLayer(imageWithBackground, null, 'IPCC SLP SSP1-2.6 2030');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
