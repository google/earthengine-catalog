var dataset = ee.ImageCollection('NASA/ORNL/global_forest_classification_2020/V1');

var visualization = {
  bands: ['classification'],
  min: 1.0,
  max: 3.0,
  palette: ['00ff00', 'ff0000', '6666ff'],
};

Map.setCenter(-53, -5, 6);
Map.addLayer(dataset, visualization, 'Forest Type');
