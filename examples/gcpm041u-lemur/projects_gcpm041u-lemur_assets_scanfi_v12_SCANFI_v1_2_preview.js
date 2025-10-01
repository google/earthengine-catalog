var dataset = ee.Image("projects/gcpm041u-lemur/assets/scanfi_v12/SCANFI_v1_2");
var balsamFir = dataset.select('balsamFir').selfMask();
var vis = {
  min: 0,
  max: 75,
  palette: [
    'yellow', 'darkgreen'
  ]
};


var lat = 48;
var lon = -60;

Map.setCenter(lon, lat, 5);

// Degrees in EPSG:3857.
var deltax = 8;
var deltay = 5;
// Width and Height of the thumbnail image.
var pixels = 256;


var areaOfInterest = ee.Geometry.Rectangle(
  [lon - deltax, lat - deltay, lon + deltax, lat + deltay], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var image = balsamFir.visualize(vis);
var imageClip = balsamFir.visualize(vis).clip(areaOfInterest);

Map.addLayer(balsamFir, null, 'Balsam Fir Percentage');

Map.addLayer(areaOfInterest, {color: 'red', opacity: 0.1}, 'Area of Interest');

print(ui.Thumbnail({image: imageClip, params: visParams}));