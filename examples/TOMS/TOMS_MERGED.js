var dataset = ee.ImageCollection('TOMS/MERGED')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-10'));
var columnOzone = dataset.select('ozone');
var columnOzoneVis = {
  min: 100,
  max: 500,
  palette: ['1621a2', 'cyan', 'green', 'yellow', 'orange', 'red'],
};
Map.setCenter(6.75, 46.53, 2);
Map.addLayer(columnOzone, columnOzoneVis, 'Column Ozone');
