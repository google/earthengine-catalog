var dataset = ee.FeatureCollection('JRC/LUCAS/THLOC/V1/2022');
var areaOfInterest = ee.Geometry.Rectangle([
  -9.17, // minLon
  38.64, // minLat
  -8.82,  // maxLon
  38.91  // maxLat
]);

Map.centerObject(areaOfInterest, 10);

// Style the points with red color.
var styledPoints = dataset.style({
  color: 'FF0000',
  pointSize: 3,
});

Map.addLayer(styledPoints, {}, 'LUCAS 2022 Points');

// Add a blue outline of the area of interest to the map for clarity.
Map.addLayer(areaOfInterest, {color: '0000FF'}, 'Area of Interest');


// THUMBNAIL GENERATION
// Create a light background with terrain hillshade
var dem = ee.Image('CGIAR/SRTM90_V4');
var hillshade = ee.Terrain.hillshade(dem);

var whiteBG = ee.Image.constant([255, 255, 255])
                .rename(['red', 'green', 'blue'])
                .visualize({min: 0, max: 255});

// Convert hillshade to RGB for blending
var hillshadeRGB = hillshade.visualize({min: 150, max: 255, palette: ['#F5F5F5', '#BDBDBD']});

// Combine the background with the styled LUCAS points.
var compositeImage = ee.ImageCollection([whiteBG, hillshadeRGB, styledPoints]).mosaic();

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

var thumbnail = ui.Thumbnail({
  image: compositeImage,
  params: imageParams
});

print('Thumbnail of LUCAS 2022 Points near Lisbon, Portugal:', thumbnail);
