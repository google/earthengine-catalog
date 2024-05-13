var image = ee.Image('NASA/HLS/HLSL30/v002/T21JUL_20130427T135010');
var rgb = image.select(['B4', 'B3', 'B2'])

// Width and height of the thumbnail image.
var pixels = 256;

var x = -58.4951;
var y = -26.8823;
var step = 0.1;
// Region of south America.
var areaOfInterest = ee.Geometry.Rectangle(
  [x, y, x+step, y+step], null, false);

var visParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:32621',
    format: 'png',
};

var image = rgb.visualize({min: 0.01, max:0.18});

Map.setCenter(-58.4343, -26.8423, 12);
Map.addLayer(image, {}, 'RGB bands');

print(ui.Thumbnail({image: image, params: visParams}));
