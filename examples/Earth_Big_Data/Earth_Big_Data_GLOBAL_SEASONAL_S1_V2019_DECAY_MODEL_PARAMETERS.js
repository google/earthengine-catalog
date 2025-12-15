var dataset = ee.ImageCollection(
    'Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/DECAY_MODEL_PARAMETERS');
var visParams = {
  bands: ['fall_hh_rho'],
  min: 0,
  max: 0.25,
};
Map.setCenter(-45.2, 64.177, 5);
Map.addLayer(dataset, visParams, 'Fall HH rho');
