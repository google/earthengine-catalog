var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ213A1')
                  .filter(ee.Filter.date('2026-10-21', '2026-11-06'));

var lon = -98.0;
var lat = 17.6;

Map.setCenter(lon, lat, 6);
Map.setOptions('SATELLITE');

var delta = 2.3;
var phi = lat * (Math.PI / 180);
var delta2 = delta / Math.cos(phi);
// Width and height of the thumbnail image.
var pixels = 256;

var ndviVis = {
  min: 0.0,
  max: 0.9,
  palette: [
    'FFFFFF', 'CE7E45', 'DF923D', 'F1B555', 'FCD163', '99B718', '74A901',
    '66A000', '529400', '3E8601', '207401', '056201', '004C00', '023B01',
    '012E01', '011D01', '011301',
  ],
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});

var ndviImage = dataset.select('NDVI').mosaic().visualize(ndviVis);
var imageWithBg = waterLandBackground.blend(ndviImage);

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta2, lat - delta, lon + delta2, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.addLayer(imageWithBg, {}, 'NDVI');

print(ui.Thumbnail({image: imageWithBg, params: visParams}));
