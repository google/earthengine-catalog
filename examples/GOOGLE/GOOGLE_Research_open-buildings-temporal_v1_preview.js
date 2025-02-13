var col = ee.ImageCollection('GOOGLE/Research/open-buildings-temporal/v1');

// New Cairo, Egypt
var aoi = ee.Geometry.Polygon(
    [[
      [31.46339396971981, 30.053365255520813],
      [31.46339396971981, 29.997556587683427],
      [31.53257350463192, 29.997556587683427],
      [31.53257350463192, 30.053365255520813]
    ]],
    null, false);

// Get mosaic for one year.
var mosaic = col.filter(ee.Filter.date('2023-01-01', '2024-01-01'))
                 .mosaic()
                 .select('building_presence');

var PIXELS = 1024;
var PRESENCE_PALETTE = [
  '#000000', '#440154', '#433982', '#30678D', '#218F8B', '#36B677', '#8ED542',
  '#FDE725'
];
var imageParams = {
  dimensions: [PIXELS, PIXELS],
  region: aoi,
  crs: 'EPSG:4326',
  format: 'png',
  min: 0.2
};
mosaic = mosaic.visualize({palette: PRESENCE_PALETTE});

print(ui.Thumbnail({image: mosaic, params: imageParams}));