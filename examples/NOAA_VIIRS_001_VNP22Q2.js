var dataset = ee.ImageCollection('NOAA/VIIRS/001/VNP22Q2')
                  .filter(ee.Filter.date('2017-01-01', '2017-12-31'));
var rgb = dataset.select([
  'EVI2_Growing_Season_Area',
  'PGQ_Growing_Season',
  'Greenness_Agreement_Growing_Season']);
var rgbVis = {
  min: [0, 0, 0],
  max: [75, 150, 200],
};
Map.setCenter(17.93, 7.71, 4);
Map.addLayer(rgb, rgbVis, 'False color');
