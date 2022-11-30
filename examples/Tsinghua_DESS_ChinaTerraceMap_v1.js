var image = ee.Image('Tsinghua/DESS/ChinaTerraceMap/v1');

var image = image.updateMask(image);
Map.addLayer(
    image, {min:0, max:1, palette: ['a3ff74']}, 'Terraces');

Map.setCenter(106.6, 30.4, 10);
Map.setOptions("SATELLITE");
