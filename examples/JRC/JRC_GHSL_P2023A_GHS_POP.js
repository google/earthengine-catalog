var image = ee.Image("JRC/GHSL/P2023A/GHS_POP");
var populationCountVis = {
  min: 0.0,
  max: 20.0,
  palette: ['060606', '337663', '337663', 'ffffff']
};
Map.setCenter(78.22, 22.59, 3);
Map.addLayer(image, populationCountVis, 'Population Count');

