var dataset =
    ee.ImageCollection('Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/COHERENCE');
var visParams = {
  bands: ['fall_hh_COH06'],
  min: 0,
  max: 0.75,
};
Map.setCenter(-45.2, 64.177, 5);
Map.addLayer(dataset, visParams, 'Fall HH COH06');
