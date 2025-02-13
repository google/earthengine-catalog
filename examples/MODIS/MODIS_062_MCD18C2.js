var dataset = ee.ImageCollection('MODIS/062/MCD18C2')
                  .filter(ee.Filter.date('2001-01-01', '2001-02-01'));
var gmt_1200_par = dataset.select('GMT_1200_PAR');
var gmt_1200_par_vis = {
  min: -236,
  max: 316,
  palette: ['0f17ff', 'b11406', 'f1ff23'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    gmt_1200_par, gmt_1200_par_vis,
    'Total PAR at GMT 12:00');