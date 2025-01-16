var dataset = ee.ImageCollection('USDA/WRC/v0').mosaic()
var cfl = dataset.select('CFL');
var vis = {min: 0, max: 30, palette: ['white', 'red']}
Map.addLayer(cfl, vis, 'Conditional Flame Length');
Map.setCenter(-101, 39, 4)
