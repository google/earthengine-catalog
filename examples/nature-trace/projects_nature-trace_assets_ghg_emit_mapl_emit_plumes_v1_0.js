var dataset = ee.ImageCollection(
    'projects/nature-trace/assets/ghg/emit/mapl_emit_plumes_v1_0');

// Apply a filter to only select the high confidence tagged plumes. Similar to
// this, we can also filter by the 'd_norm' score for spectral fit filtering or
// with 'cluster_size' to filter by the inference time augmentation plume
// detection cluster size.
dataset = dataset.filter(ee.Filter.eq('confidence', 'high'))

// Mask enhancements (band 0) using plume probability (band 1)
var plumesMasked = dataset.map(function(img) {
  var enh = img.select('methane_enhancement');
  var prob = img.select('plume_probability');
  // Mask enhancements by plume probability. If we choose a higher threshold,
  // we will have tighter plumes near the plume core, lower threshold will
  // result in larger plumes that are more spread out.
  return enh.updateMask(prob.gt(0.5));
});

var visParams = {
  min: 0,
  max: 300,
  palette: [
    '#000004', '#1b0c41', '#4a0c6b', '#781c6d', '#a52c60', '#cf4446', '#ed6925',
    '#fb9b06', '#f7d13d', '#fcffa4'
  ]
};

Map.setCenter(-101.9306, 32.2827, 12);
Map.addLayer(
    plumesMasked, visParams, 'MAPL-EMIT Plumes (B0 masked by B1 > 0.6)');
