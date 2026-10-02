var dswx_s1_collection = ee.ImageCollection('OPERA/DSWX/L3_V1/S1')
                 .filterDate('2025-03-01', '2025-10-01');

// Mask out values >= 250 before calculating the max so that
// HAND and layover/shadow masks are not included.
var masked_collection = dswx_s1_collection.map(function(image) {
  var wtr = image.select('WTR_Water_classification');
  return wtr.updateMask(wtr.lt(250));
});

var dswx_s1 = masked_collection
  .reduce(ee.Reducer.max())
  .rename('WTR_Water_classification');

var wtr_class_values = [
  0,    // Not water
  1,    // Open water
  3,    // Inundated vegetation
  250,  // Height Above Nearest Drainage (HAND) masked
  251   // Layover/shadow masked
];

var wtr_palette = [
  'ffffff',  // Not water
  '0000ff',  // Open water
  '66c2a5',  // Inundated vegetation
  'd3d3d3',  // Height Above Nearest Drainage (HAND) masked
  'a9a9a9',  // Layover/shadow masked
];

// Select the water classification band and remap to make have palette vis.
var wtr_band = dswx_s1.select('WTR_Water_classification');
var to = [0, 1, 2, 3, 4];
var image = wtr_band.remap(wtr_class_values, to)
                .visualize({min: 0, max: 4, palette: wtr_palette});
var lon = 12.982;
var lat = 55.824;
var delta = 0.1;
// The thumbnail looks better in EPSG:4326 with 2x longitude scale.
var bbox = ee.Geometry.BBox(
  lon - 2*delta,
  lat - delta,
  lon + 2*delta,
  lat + delta);
var pixels = 256;
var thumbnailParams = {
  dimensions: [pixels, pixels],
  region: bbox,
  crs: 'EPSG:4326',
  format: 'png',
};
print(ui.Thumbnail({image: image, params: thumbnailParams}));
