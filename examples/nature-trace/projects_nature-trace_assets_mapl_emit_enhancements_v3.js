var dataset = ee.ImageCollection('projects/nature-trace/assets/mapl_emit_enhancements_v3');

// Mask enhancements (B0) using plume probability (B1)
var enhancementsMasked = dataset.map(function(img) {
  var enh = img.select('B0');
  var prob = img.select('B1');
  return enh.updateMask(prob.gt(0.6));
});

var visParams = {
  min: 0,
  max: 300,
  palette: ['#000004', '#1b0c41', '#4a0c6b', '#781c6d', '#a52c60', '#cf4446', '#ed6925', '#fb9b06', '#f7d13d', '#fcffa4']
};

Map.setCenter(-100.0, 44.5, 8);
Map.addLayer(enhancementsMasked, visParams, 'MAPL-EMIT Enhancements (B0 masked by B1 > 0.6)');
