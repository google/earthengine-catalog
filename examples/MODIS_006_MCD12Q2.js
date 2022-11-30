var dataset = ee.ImageCollection('MODIS/006/MCD12Q2')
                  .filter(ee.Filter.date('2001-01-01', '2002-01-01'));
var vegetationPeak = dataset.select('Peak_1');
var vegetationPeakVis = {
  min: 11400,
  max: 11868,
  palette: ['0f17ff', 'b11406', 'f1ff23'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    vegetationPeak, vegetationPeakVis,
    'Vegetation Peak 2001');
