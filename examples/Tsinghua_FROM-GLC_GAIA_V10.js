var image = ee.Image('Tsinghua/FROM-GLC/GAIA/v10');
Map.addLayer(image, {min: 0, max: 34});
Map.setCenter(116.9921, 39.7971, 8);
