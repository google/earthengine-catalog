var dataset = ee.Image('BNETD/land_cover/v1/2020').select('classification');

Map.setCenter(-5.4400, 7.5500, 7);

Map.addLayer(dataset, {}, "Cote d'Ivoire Land Cover Map 2020");
