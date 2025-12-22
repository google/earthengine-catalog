// Query places in New York City area for preview.
var query = "SELECT geometry FROM `bigquery-public-data.overture_maps.place` " +
           "WHERE ST_INTERSECTS(geometry, ST_GEOGFROMTEXT('POLYGON((" +
           "-74.02 40.7, -73.97 40.7, -73.97 40.78, -74.02 40.78, -74.02 40.7))'))";

// Load collection.
var places = ee.FeatureCollection.runBigQuery(query);

var delta = 0.05;
var pixels = 256;

var lon = -74.006;
var lat = 40.7128;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Reduce the FeatureCollection to an image.
var placesImage = places.reduceToImage({
  properties: [],
  reducer: ee.Reducer.count()
});

var placesVisParams = {
  min: 0,
  max: 10,
  palette: ['ffffff', '4285f4'],
  opacity: 0.8
};
var placesImageVisualized = placesImage.visualize(placesVisParams);

// Create a background image.
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, placesImageVisualized]).mosaic();

// Define the parameters for the thumbnail.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
