var image = ee.ImageCollection('JRC/D5/EUCROPMAP/V1').filterDate(
    '2018-01-01', '2019-01-01').first();
Map.addLayer(image, {}, 'EUCROPMAP 2018');
Map.setCenter(10, 48, 4);
