// Query multiple African mammals
var query = "SELECT name, geometry FROM `earth-engine-public-data.inaturalist_open_range_map.multispecies_latest` " +
           "WHERE name IN ('Panthera leo', 'Loxodonta africana', 'Giraffa camelopardalis', 'Acinonyx jubatus')";
// Load collection
var mammals = ee.FeatureCollection.runBigQuery(query);

var delta = 25;
// Width and height of the thumbnail image.
var pixels = 256;

var lon = 21.69;
var lat = -5.77;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

// Assign numeric IDs
var mammalsWithId = mammals.map(function(f) {
 var name = f.get('name');
 var id = ee.Algorithms.If(ee.String(name).equals('Panthera leo'), 1,
           ee.Algorithms.If(ee.String(name).equals('Loxodonta africana'), 2,
           ee.Algorithms.If(ee.String(name).equals('Giraffa camelopardalis'), 3,
           ee.Algorithms.If(ee.String(name).equals('Acinonyx jubatus'), 4, 0))));
 return f.set('id', id);
});

// Reduce the FeatureCollection to an image.
var mammalsImage = mammalsWithId.reduceToImage({
 properties: ['id'],
 reducer: ee.Reducer.first()
});

var mammalsVisParams = {
  min: 1,
  max: 4,
  palette: ['#E4004B', '#ED775A', '#FAD691', '#C9CDCF'],
  opacity: 0.8
};
var mammalsImageVisualized = mammalsImage.visualize(mammalsVisParams);

// Create a background image
var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});

// Mosaic the background and the feature collection image.
var imageWithBackground = ee.ImageCollection([background, mammalsImageVisualized]).mosaic();


// Define the parameters for the thumbnail.
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Print the thumbnail to the console.
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
