var dataset = ee.Image("COPERNICUS/Landcover/100m/Proba-V-C3/Global/2019")
.select('discrete_classification');

Map.setCenter(-88.6, 26.4, 1);

Map.addLayer(dataset, {}, "Land Cover");
