var image = ee.Image("LARSE/GEDI/GRIDDEDVEG_002/V1/1KM/gediv002_sens-a0_vf_20230101_20230316");
var p95 = image.select('p95');
var lon = -46.46;
var lat = -11;
Map.setCenter(lon, lat, 5);

var palette = ['darkred','red','orange','green','darkgreen'];

Map.addLayer(p95, {palette: palette, min:1, max:60}, 'p95');