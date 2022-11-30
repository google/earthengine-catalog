var dataset = ee.ImageCollection('LANDSAT/GLS2005');
var trueColor321 = dataset.select(['30', '20', '10']);
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(trueColor321, {}, 'True Color (321)');
