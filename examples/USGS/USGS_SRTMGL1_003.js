var dataset = ee.Image('USGS/SRTMGL1_003');
var elevation = dataset.select('elevation');
var slope = ee.Terrain.slope(elevation);
Map.setCenter(-112.8598, 36.2841, 10);
Map.addLayer(slope, {min: 0, max: 60}, 'slope');
