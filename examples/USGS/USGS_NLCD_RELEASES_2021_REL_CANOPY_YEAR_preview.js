// Import the Tree Canopy Cover image collection.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2021_REL/CANOPY/NLCD/TCC/YEAR');
var canopy = dataset.filter(ee.Filter.eq('system:year', '2021')).first();

var visParams = { 
   palette: [
    'ffffe0',  // light yellow - percent shrub
    '66cdaa',  // medium green - percent shrub
    ],
  min: 0,
  max: 254,
};

var lon = -130;
var lat = 48;

Map.setCenter(lon, lat, 10);

// Degrees in EPSG:3857.
var delta = 10;
// Width and height of the thumbnail image.
var pixels = 256;

// cadetblue
var background = ee.Image.rgb(95, 158, 160).visualize({min: 0, max: 255});

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:3857',
    format: 'png',
};

var image = canopy.visualize(visParams);
Map.addLayer(image)

var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
Map.addLayer(imageWithBackground, {}, 'year_2021 %');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));