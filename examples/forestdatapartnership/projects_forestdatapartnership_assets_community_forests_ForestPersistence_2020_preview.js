var forestPersistence = ee.Image(
  'projects/forestdatapartnership/assets/community_forests/ForestPersistence_2020');

// Point to center
var lon = -123.296;
var lat = 43.8246;

// Display land cover on the map.
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

var thumbComposite = ee.ImageCollection([
  forestPersistence.visualize({palette: 'black,white'}),
  forestPersistence.gt(0.95).selfMask().visualize({palette: 'green'}), 
]).mosaic();
Map.addLayer(thumbComposite);

print(ui.Thumbnail({image: thumbComposite, params: parameters}));