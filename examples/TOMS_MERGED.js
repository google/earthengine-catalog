var dataset = ee.ImageCollection('TOMS/MERGED')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-10'));
var columnOzone = dataset.select('ozone');
var columnOzoneVis = {
  min: 100.0,
  max: 500.0,
  palette: ['1621A2', 'cyan', 'green', 'yellow', 'orange', 'red'],
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(columnOzone, columnOzoneVis, 'Column Ozone');
