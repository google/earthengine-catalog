var dataset = ee.Image('ESA/GLOBCOVER_L4_200901_200912_V2_3');
var landcover = dataset.select('landcover');
Map.setCenter(-88.6, 26.4, 3);
Map.addLayer(landcover, {}, 'Landcover');
