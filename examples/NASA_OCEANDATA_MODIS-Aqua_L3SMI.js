var dataset = ee.ImageCollection('NASA/OCEANDATA/MODIS-Aqua/L3SMI')
                  .filterDate('2016-01-01', '2016-01-31');
var remoteSensingReflectance =
    dataset.select(['Rrs_645', 'Rrs_555', 'Rrs_443']);
var remoteSensingReflectanceVis = {
  min: 0.0,
  max: 0.011,
};
Map.setCenter(-52.12, -46.13, 4);
Map.addLayer(
    remoteSensingReflectance, remoteSensingReflectanceVis,
    'Remote Sensing Reflectance');
