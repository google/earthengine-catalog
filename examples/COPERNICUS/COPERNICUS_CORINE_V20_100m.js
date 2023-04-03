var dataset = ee.Image('COPERNICUS/CORINE/V20/100m/2012');
var landCover = dataset.select('landcover');
Map.setCenter(16.436, 39.825, 6);
Map.addLayer(landCover, {}, 'Land Cover');
