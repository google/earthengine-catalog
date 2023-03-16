var dataset = ee.ImageCollection('MODIS/006/MOD44B');

var visualization = {
  bands: ['Percent_Tree_Cover'],
  min: 0.0,
  max: 100.0,
  palette: ['bbe029', '0a9501', '074b03']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, 'Percent Tree Cover');
