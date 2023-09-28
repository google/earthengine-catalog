var dataset = ee.ImageCollection('MODIS/006/MOD44B');

var visualization = {
  bands: ['Percent_Tree_Cover'],
  min: 0,
  max: 100,
  palette: ['bbe029', '0a9501', '074b03']
};

Map.setCenter(6.746, 46.529, 3);

Map.addLayer(dataset, visualization, 'Percent Tree Cover');
