var baseChange =
    [{featureType: 'all', stylers: [{saturation: -100}, {lightness: 45}]}];
Map.setOptions('baseChange', {'baseChange': baseChange});
var image1975 = ee.Image('JRC/GHSL/P2023A/GHS_POP/1975');
var image1990 = ee.Image('JRC/GHSL/P2023A/GHS_POP/1990');
var image2020 = ee.Image('JRC/GHSL/P2023A/GHS_POP/2020');
var populationCountVis = {
  min: 0.0,
  max: 100.0,
  palette:
      ['000004', '320A5A', '781B6C', 'BB3654', 'EC6824', 'FBB41A', 'FCFFA4']
};
Map.setCenter(8, 48, 7);
image1975 = image1975.updateMask(image1975.gt(0));
image1990 = image1990.updateMask(image1990.gt(0));
image2020 = image2020.updateMask(image2020.gt(0));
Map.addLayer(image1975, populationCountVis, 'Population count, 1975');
Map.addLayer(image1990, populationCountVis, 'Population count, 1990');
Map.addLayer(image2020, populationCountVis, 'Population count, 2020');
