var dataset = ee.ImageCollection('MODIS/061/MCD64A1')
                  .filter(ee.Filter.date('2017-01-01', '2018-05-01'));
var burnedArea = dataset.select('BurnDate');
var burnedAreaVis = {
  min: 30.0,
  max: 341.0,
  palette: ['4e0400', '951003', 'c61503', 'ff1901'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(burnedArea, burnedAreaVis, 'Burned Area');
