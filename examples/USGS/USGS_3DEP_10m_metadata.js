var fc = ee.FeatureCollection('USGS/3DEP/10m_metadata');

var empty = ee.Image().byte();
var outlines = empty.paint({
  featureCollection: fc,
  color: 'zmean',
});
var palette = ["0000ff", "00ffff", "ffff00", "ff0000", "ffffff"];
Map.addLayer(outlines, {palette: palette, max: 2000});
