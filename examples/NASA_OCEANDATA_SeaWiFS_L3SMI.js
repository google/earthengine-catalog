var dataset = ee.ImageCollection('NASA/OCEANDATA/SeaWiFS/L3SMI')
                  .filter(ee.Filter.date('2009-07-01', '2009-08-30'));
var remoteSensingReflectance =
    dataset.select(['Rrs_670', 'Rrs_555', 'Rrs_443']);
var remoteSensingReflectanceVis = {
  min: 0.0,
  max: 0.03,
};
Map.setCenter(-52.12, -46.13, 1);
Map.addLayer(
    remoteSensingReflectance, remoteSensingReflectanceVis,
    'Remote Sensing Reflectance');
