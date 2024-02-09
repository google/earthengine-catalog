var dataset = ee.ImageCollection('MODIS/061/MCD18A1')
                  .filter(ee.Filter.date('2000-01-01', '2001-01-01'));
var gmt_1200_dsr = dataset.select('GMT_1200_DSR');
var gmt_1200_dsr_vis = {
  min: 0,
  max: 350,
  palette: ['0f17ff', 'b11406', 'f1ff23'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    gmt_1200_dsr, gmt_1200_dsr_vis,
    'Total dsr at GMT 12:00');