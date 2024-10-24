var dataset = ee.FeatureCollection('UN/Geodata/BNDA_simplified/current');


var styled = dataset.style({fillColor: 'b5ffb4',width:1.0})
Map.addLayer(styled)

var lon = -100.0;
var lat = 38.5;
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

Map.setCenter(lon, lat, 3);

// Degrees in EPSG:4326.
var lat_delta = 30;
var lon_delta = 50;
// Width and height of the thumbnail image.
var pixels = 256;

var image = styled;
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));