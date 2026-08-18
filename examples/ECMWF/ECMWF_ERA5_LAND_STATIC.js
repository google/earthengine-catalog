var dataset = ee.Image('ECMWF/ERA5_LAND/STATIC');

var soilType = dataset.select('soil_type').selfMask();

var visualization = {
  min: 1.0,
  max: 7.0,
  palette: [
    'e8d9a8', // 1 Coarse – pale sand
    'd2b48c', // 2 Medium – light tan
    'b8935f', // 3 Medium fine – warm brown
    '8b5a2b', // 4 Fine – medium brown
    '6b4423', // 5 Very fine – deep clay brown
    '3e2c1c', // 6 Organic – dark peat
    '26140b'  // 7 Tropical organic – near-black humus
  ]
};

Map.setCenter(22.2, 21.2, 2);

Map.addLayer(soilType, visualization, 'Soil type');
