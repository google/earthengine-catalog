var ccdc = ee.ImageCollection("projects/CCDC/v4");
var break0 = ccdc.select('tBreak').mosaic().arrayGet(0);

// Point to center
var lon = -123.296;
var lat = 43.8246;

Map.setOptions('SATELLITE');
Map.setCenter(lon, lat, 13);
Map.addLayer(break0.selfMask(), {min: 1984, max: 2024, palette: 'red,green,blue'}, 'break0');
