var dataset = ee.ImageCollection('LANDSAT/LT05/C02/T2_L2')
    .filterDate('2000-06-01', '2000-07-01');

// Applies scaling factors.
function applyScaleFactors(image) {
  var opticalBands = image.select('SR_B.').multiply(0.0000275).add(-0.2);
  var thermalBand = image.select('ST_B6').multiply(0.00341802).add(149.0);
  return image.addBands(opticalBands, null, true)
              .addBands(thermalBand, null, true);
}

dataset = dataset.map(applyScaleFactors);

var visualization = {
  bands: ['SR_B3', 'SR_B2', 'SR_B1'],
  min: 0.0,
  max: 0.3,
};

Map.setCenter(-83, 24, 8);

Map.addLayer(dataset, visualization, 'True Color (321)');
