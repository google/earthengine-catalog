var dataset = ee.Image('CPOM/CryoSat2/ANTARCTICA_DEM');

var visualization = {
  bands: ['elevation'],
  min: 0.0,
  max: 4000.0,
  palette: ['001fff', '00ffff', 'fbff00', 'ff0000']
};

Map.setCenter(17.0, -76.0, 3);

Map.addLayer(dataset, visualization, 'Elevation');
