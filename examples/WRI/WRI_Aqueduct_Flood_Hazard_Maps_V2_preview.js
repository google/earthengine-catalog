var dataset = ee.ImageCollection('WRI/Aqueduct_Flood_Hazard_Maps/V2');
var temp = dataset.select('inundation_depth').mean();
var tempVis = {
  min: 0,
  max: 1,
  palette: ['ffffff','0000ff'],
};

var lon = -68.36;
var lat = -6.73;


var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 4);
Map.addLayer(temp, tempVis, 'inundation_depth');

// Degrees in EPSG:3857.
var delta = 15;
// Width and height of the thumbnail image.
var pixels = 256;

var image = temp.visualize(tempVis);
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
