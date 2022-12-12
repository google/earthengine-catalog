var dataset = ee.ImageCollection('MODIS/006/MCD43C3')
                  .filter(ee.Filter.date('2018-01-01', '2018-05-01'));
var blackSkyAlbedo = dataset.select('Albedo_BSA_Band1');
var blackSkyAlbedoVis = {
  min: 0.0,
  max: 400.0,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(blackSkyAlbedo, blackSkyAlbedoVis, 'Black-Sky Albedo');
