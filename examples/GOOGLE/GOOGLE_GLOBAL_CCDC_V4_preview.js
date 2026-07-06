var ccdc = ee.ImageCollection('projects/CCDC/v4');
var break0 = ccdc.select('tBreak').mosaic().arrayGet(0);

// Point to center
var lon = -123.296;
var lat = 43.8246;
Map.setCenter(lon, lat, 13);

// Degrees in EPSG:3857
var delta = 0.043;
// Width and Height of the Thumbail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png'
};

var thumbComposite = break0.selfMask().visualize(
    {min: 1984, max: 2024, palette: 'red,green,blue'});
print(ui.Thumbnail({image: thumbComposite, params: parameters}));
