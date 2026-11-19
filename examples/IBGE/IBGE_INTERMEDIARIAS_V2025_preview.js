var dataset = ee.FeatureCollection('IBGE/INTERMEDIARIAS/V2025');

var lon = -51.9253;
var lat = -14.235;

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var background = waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var empty = ee.Image().byte();
var outline = empty.paint({
  featureCollection: dataset,
  color: 1,
  width: 1.0
});

var visualized = outline.visualize({palette: ['1b9e77']});
var imageWithBackground = background.blend(visualized);

var pixels = 256;
var lat_delta = 20;
var lon_delta = 25;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
