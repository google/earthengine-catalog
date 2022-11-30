var dataset = ee.ImageCollection('MODIS/006/MOD17A3HGF');

var visualization = {
  bands: ['Npp'],
  min: 0.0,
  max: 19000.0,
  palette: ['bbe029', '0a9501', '074b03']
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, 'NPP');
