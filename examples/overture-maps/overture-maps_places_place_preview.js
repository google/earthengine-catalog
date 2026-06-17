// Query places in New York City area for preview.
var query = "SELECT geometry FROM `bigquery-public-data.overture_maps.place` " +
           "WHERE ST_INTERSECTS(geometry, ST_GEOGFROMTEXT('POLYGON((" +
           "-74.02 40.7, -73.97 40.7, -73.97 40.78, -74.02 40.78, -74.02 40.7))'))";

// Load collection, buffer 10m for visualization and add a dummy column.
var places = ee.FeatureCollection.runBigQuery(query)
  .map(function(f) {return f.buffer(10).set("1", 1)});;

var lon = -74.02;
var lat = 40.7;
var delta = 0.05;
var areaOfInterest = ee.Geometry.BBox(lon, lat, lon + delta, lat + delta);

// Reduce the FeatureCollection to an image.
var placesImage = places.reduceToImage({
  properties: ["1"],
  reducer: ee.Reducer.count()
});
placesImage = placesImage.updateMask(placesImage.gt(0));

var placesVisParams = {
  min: 0,
  max: 20,
  palette: ['#9ADDFC', '#3B45B8', '#B609D9'],
  opacity: 0.9
};
var placesImageVisualized = placesImage.visualize(placesVisParams);

// Create a background image.
var background = ee.Image(1).visualize({"palette": ["#ddd"]});

// Create a water mask to show the land a bit better.
var water = ee.Image("JRC/GSW1_4/GlobalSurfaceWater")
  .select(0).visualize({"palette": ["#444"]});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, water, placesImageVisualized]).mosaic();

// Define the parameters for the thumbnail.
var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
