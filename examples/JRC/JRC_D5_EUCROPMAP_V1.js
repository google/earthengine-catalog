var image = ee.Image('JRC/D5/EUCROPMAP/V1/2018');
Map.addLayer(image, {}, 'EUCROPMAP 2018');
Map.setCenter(10, 48, 4);
