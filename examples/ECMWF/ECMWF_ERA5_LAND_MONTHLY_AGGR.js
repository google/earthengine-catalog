var dataset = ee.ImageCollection('ECMWF/ERA5_LAND/MONTHLY_AGGR').first();

var visualization = {
  bands: ['temperature_2m'],
  min: 250.0,
  max: 320.0,
  palette: [
    '000080', '0000d9', '4000ff', '8000ff', '0080ff', '00ffff',
    '00ff80', '80ff00', 'daff00', 'ffff00', 'fff500', 'ffda00',
    'ffb000', 'ffa400', 'ff4f00', 'ff2500', 'ff0a00', 'ff00ff',
  ]
};

Map.setCenter(-170.13, 45.62, 2);
Map.addLayer(dataset, visualization, 'Air temperature [K] at 2m height');
