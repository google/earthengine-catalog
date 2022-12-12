var raw = ee.Image("ISDASOIL/Africa/v1/texture_class");
Map.addLayer(
    raw.select(0), {}, "Texture class, 0-20 cm");
Map.addLayer(
    raw.select(1), {}, "Texture class, 20-50 cm");

Map.setCenter(25, -3, 2);
