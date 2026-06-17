var dataset =
    ee.ImageCollection('Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/BACKSCATTER');
var visParams = {
  bands: ['fall_hh_AMP'],
  min: 0,
  max: 1.25,
};
Map.setCenter(-45.2, 64.177, 5);
Map.addLayer(dataset, visParams, 'Fall HH AMP');
