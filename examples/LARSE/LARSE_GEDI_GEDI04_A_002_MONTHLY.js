var qualityMask = function(im) {
  return im.updateMask(im.select('l4_quality_flag').eq(1))
      .updateMask(im.select('degrade_flag').eq(0));
};
var dataset = ee.ImageCollection('LARSE/GEDI/GEDI04_A_002_MONTHLY')
                  .map(qualityMask)
                  .select('solar_elevation');

var gediVis = {
  min: 1,
  max: 60,
  palette: 'red, green, blue',
};
Map.setCenter(5.0198, 51.7564, 12);
Map.addLayer(dataset, gediVis, 'Solar Elevation');
