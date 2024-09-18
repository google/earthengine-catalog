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

// Get all snapshot timestamps.
var ts = col.filterBounds(aoi)
             .aggregate_array('system:time_start')
             .distinct()
             .sort()
             .getInfo();

// Get mosaic for the latest year.
var mosaic = col.filter(ee.Filter.eq('system:time_start', ts[ts.length - 1]))
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
  palette: PRESENCE_PALETTE,
  format: 'png',
  min: 0.2
};
print(ui.Thumbnail({image: mosaic, params: imageParams}));