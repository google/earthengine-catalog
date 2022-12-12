var dataset = ee.ImageCollection("COPERNICUS/Landcover/100m/Proba-V/Global");

var visualization = {
  bands: ['discrete_classification']
};

Map.setCenter(-88.6, 26.4, 1);

Map.addLayer(dataset, visualization, "Land Cover");
