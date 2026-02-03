var dswx_hls_collection = ee.ImageCollection('OPERA/DSWX/L3_V1/HLS')
                 .filterDate('2025-07-01', '2025-10-01');

// Mask out values >= 252 before calculating the mode we don't
// want to have clouds or snow/ice be included.
var masked_collection = dswx_hls_collection.map(function(image) {
  var wtr = image.select('WTR_Water_classification');
  return wtr.updateMask(wtr.lt(252));
});

var dswx_hls = masked_collection
  .reduce(ee.Reducer.mode())
  .rename('WTR_Water_classification');

var wtr_class_values = [
  0,    // Not water
  1,    // Open water
  2,    //Partial surface water
  252,  // Snow/ice
  253,  // Cloud/cloud shadow
  254   // Ocean masked
];

var wtr_palette = [
  'ffffff',  // Not water
  '0000ff',  // Open water
  '0088ff',  // Partial surface water
  'f2f2f2',  // Snow/ice
  'dfdfdf',  // Cloud/cloud shadow
  'da00ff',  // Ocean masked
];

// Select the water classification band and remap to make have palette vis.
var wtr_band = dswx_hls.select('WTR_Water_classification');
var to = [0, 1, 2, 3, 4, 5];
var wtr_remapped = wtr_band.remap(wtr_class_values, to);
var lat = 29.56;
var lon = -89.94;
var delta = 0.3;
var bbox = ee.Geometry.BBox(lon - delta, lat - delta, lon + delta, lat + delta);
var pixels = 256;
var thumbnailParams = {
  dimensions: [pixels, pixels],
  region: bbox,
  crs: 'EPSG:4326',
  format: 'png',
  min: 0,
  max: 5,
  palette: wtr_palette,
}
print(ui.Thumbnail({image: wtr_remapped, params: thumbnailParams}));
