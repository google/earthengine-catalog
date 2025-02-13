var dataset = ee.ImageCollection('MODIS/061/MOD44B')
                .filter(ee.Filter.date('2000-01-01', '2001-01-01'));
var percent_tree_cover = dataset.select('Percent_Tree_Cover').mean();
var percent_tree_cover_vis = {
  min: 0,
  max: 100,
  palette: ['bbe029', '0a9501', '074b03'],
};

var lon = -58.23;
var lat = -16.65;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);
Map.addLayer(percent_tree_cover, percent_tree_cover_vis, 'Percent_Tree_Cover');

// Degrees in EPSG:3857.
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var image = percent_tree_cover.visualize(percent_tree_cover_vis);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
