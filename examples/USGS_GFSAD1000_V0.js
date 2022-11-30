var dataset = ee.Image('USGS/GFSAD1000_V0');
var cropDominance = dataset.select('landcover');
var cropDominanceVis = {
  min: 0.0,
  max: 9.0,
  palette: [
    'black', 'white', 'green', 'yellow', 'brown', 'orange', '02be11', '015e08',
    '02a50f', 'purple'
  ],
};
Map.setCenter(-17.22, 13.72, 2);
Map.addLayer(cropDominance, cropDominanceVis, 'Crop Dominance');
