var dataset = ee.ImageCollection('LARSE/GEDI/GEDI04_D_002');

var visualization = {
  bands: ['agbd'],
  min: 1.0,
  max: 60.0,
  palette: [
    'darkred',
    'red',
    'orange',
    'green',
    'darkgreen',
  ]
};

Map.setCenter(-60.0, -5.0, 6);
Map.addLayer(dataset, visualization, 'Aboveground Biomass Density');
