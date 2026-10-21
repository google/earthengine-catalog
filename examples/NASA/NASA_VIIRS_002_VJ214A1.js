var dataset = ee.ImageCollection('NASA/VIIRS/002/VJ214A1')
                  .filter(ee.Filter.date('2023-05-01', '2023-12-30'));
var visualization = {
  bands: ['MaxFRP'],
  min: 0.0,
  max: 1.0,
  palette: ['#00FF00', '#00FFFF', '#00FF00', '#FFFFE0', '#FFFFA0', '#FFFF00'],
};
var lon = 38.06;
var lat = -14.22;
Map.setCenter(lon, lat, 6);
Map.addLayer(dataset, visualization, 'MaxFRP');
