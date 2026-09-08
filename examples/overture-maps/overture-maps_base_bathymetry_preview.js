// Query bathymetry in Florida + Bahamas shallow waters for preview.
var query = "SELECT geometry FROM `bigquery-public-data.overture_maps.bathymetry` " +
           "WHERE ST_INTERSECTS(geometry, ST_GEOGFROMTEXT('POLYGON((" +
           "-82 22, -76 22, -76 27, -82 27, -82 22))'))";

// Load collection.
var bathymetry = ee.FeatureCollection.runBigQuery(query);

var delta = 2.5;
var pixels = 256;

var lon = -79;
var lat = 25;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Reduce the FeatureCollection to an image.
var bathymetryImage = bathymetry.reduceToImage({
  properties: [],
  reducer: ee.Reducer.count()
});

var bathymetryVisParams = {
  min: 0,
  max: 5,
  palette: ['e0f7fa', '80deea', '26c6da', '0288d1', '01579b', '002171'],
  opacity: 0.9
};
var bathymetryImageVisualized = bathymetryImage.visualize(bathymetryVisParams);

// Create a background image.
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, bathymetryImageVisualized]).mosaic();

// Define the parameters for the thumbnail.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));