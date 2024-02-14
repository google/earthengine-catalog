var coll = ee.ImageCollection('NASA/LANCE/NOAA20_VIIRS/C2')
             .filter(ee.Filter.date('2023-10-08', '2024-12-31'));

var image = ee.Image(coll.mosaic());
var TI4 = image.select('Bright_ti4')

var Vis = {
  min: 200.0,
  max: 500.0,
  palette: ['yellow', 'orange', 'red', 'white', 'darkred'],
};

// Width and height of the thumbnail image.
var pixels = 256;

// Region of Canada.
var areaOfInterest =
    ee.Geometry.Rectangle([-115.1164, 59.7324, -112.3258, 59.0047], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var image = TI4.visualize(Vis);

Map.setCenter(-115.1164, 59.7324, 8);
Map.addLayer(image, {}, 'Noaa nrt firms');

print(ui.Thumbnail({image: image, params: visParams}));