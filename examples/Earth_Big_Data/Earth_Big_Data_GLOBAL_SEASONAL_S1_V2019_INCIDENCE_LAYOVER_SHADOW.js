var dataset = ee.ImageCollection(
    'Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/INCIDENCE_LAYOVER_SHADOW');
var visParams = {
  bands: ['inc'],
  min: 30,
  max: 70,
};
Map.setCenter(-45.2, 64.177, 5);
Map.addLayer(dataset, visParams, 'Incidence Angle');
