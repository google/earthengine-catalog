// Query addresses in New York City area for preview.
var query = "SELECT geometry FROM `bigquery-public-data.overture_maps.address` " +
           "WHERE ST_INTERSECTS(geometry, ST_GEOGFROMTEXT('POLYGON((" +
           "-74.1 40.6, -73.9 40.6, -73.9 40.8, -74.1 40.8, -74.1 40.6))'))";

// Load collection.
var addresses = ee.FeatureCollection.runBigQuery(query);

var delta = 0.05;
var pixels = 256;

var lon = -74.006;
var lat = 40.7128;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Reduce the FeatureCollection to an image.
var addressesImage = addresses.reduceToImage({
  properties: [],
  reducer: ee.Reducer.count()
});

var addressesVisParams = {
  min: 0,
  max: 10,
  palette: ['ffffff', '00897b'],
  opacity: 0.8
};
var addressesImageVisualized = addressesImage.visualize(addressesVisParams);

// Create a background image.
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, addressesImageVisualized]).mosaic();

// Define the parameters for the thumbnail.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));