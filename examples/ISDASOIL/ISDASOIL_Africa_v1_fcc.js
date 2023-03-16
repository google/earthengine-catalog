var raw = ee.Image("ISDASOIL/Africa/v1/fcc").select(0);

var converted = ee.Image(raw.mod(3000).copyProperties(raw));

Map.setCenter(25, -3, 2);

Map.addLayer(converted, {}, "Fertility Capability Classification");
