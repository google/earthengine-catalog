// Query division boundaries in New York City area for preview.
var query = "SELECT geometry FROM `bigquery-public-data.overture_maps.division_boundary` " +
           "WHERE ST_INTERSECTS(geometry, ST_GEOGFROMTEXT('POLYGON((" +
           "-74.3 40.4, -73.7 40.4, -73.7 40.95, -74.3 40.95, -74.3 40.4))'))";

// Load collection.
var divisionBoundaries = ee.FeatureCollection.runBigQuery(query);

var delta = 0.05;
var pixels = 256;

var lon = -74.006;
var lat = 40.7128;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Reduce the FeatureCollection to an image.
var divisionBoundariesImage = divisionBoundaries.reduceToImage({
  properties: [],
  reducer: ee.Reducer.count()
});

var divisionBoundariesVisParams = {
  min: 0,
  max: 10,
  palette: ['ffffff', '512da8'],
  opacity: 0.8
};
var divisionBoundariesImageVisualized = divisionBoundariesImage.visualize(divisionBoundariesVisParams);

// Create a background image.
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, divisionBoundariesImageVisualized]).mosaic();

// Define the parameters for the thumbnail.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));