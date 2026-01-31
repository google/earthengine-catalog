// Query transportation connectors in New York City area for preview.
var query = "SELECT geometry FROM `bigquery-public-data.overture_maps.connector` " +
           "WHERE ST_INTERSECTS(geometry, ST_GEOGFROMTEXT('POLYGON((" +
           "-74.02 40.7, -73.97 40.7, -73.97 40.75, -74.02 40.75, -74.02 40.7))'))";

// Load collection.
var connectors = ee.FeatureCollection.runBigQuery(query);

var delta = 0.05;
var pixels = 256;

var lon = -74.006;
var lat = 40.7128;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Reduce the FeatureCollection to an image.
var connectorsImage = connectors.reduceToImage({
  properties: [],
  reducer: ee.Reducer.count()
});

var connectorsVisParams = {
  min: 0,
  max: 10,
  palette: ['ffffff', '1565c0'],
  opacity: 0.8
};
var connectorsImageVisualized = connectorsImage.visualize(connectorsVisParams);

// Create a background image.
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, connectorsImageVisualized]).mosaic();

// Define the parameters for the thumbnail.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));