// Import the oil palm plantation probability model collection.
var dataset = ee.ImageCollection(
    'projects/forestdatapartnership/assets/community_palm/20240312');

// Point to center
var lon = 111.65;
var lat = -2.55;

// Filter the collection to the 2020 mosaic.
var palm2020 = dataset.filterDate(ee.Date('2020-01-01'), ee.Date('2020-12-31'))
                   .filterBounds(ee.Geometry.Point(lon, lat))
                   .first();

var palette = ['#eff3ff', '#bdd7e7', '#6baed6', '#3182bd', '#08519c'];
var vis = {min: 0, max: 1.0, palette: palette};


// Display land cover on the map.
Map.setCenter(lon, lat, 13);

Map.addLayer(palm2020, vis);

// Preview image.

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

var image = palm2020.visualize({palette: palette});

print(ui.Thumbnail({image: image, params: parameters}));
