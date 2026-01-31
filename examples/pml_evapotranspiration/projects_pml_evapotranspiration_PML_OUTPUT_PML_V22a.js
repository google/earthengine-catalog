var dataset = ee.ImageCollection('projects/pml_evapotranspiration/PML/OUTPUT/PML_V22a');

// Scale the first image to physical units (0.01 scale factor)
var firstImage = dataset.first().multiply(0.01);

var visualization = {
  bands: ['GPP'],
  min: 0.0,
  max: 9.0,
  palette: [
    'a50026', 'd73027', 'f46d43', 'fdae61', 'fee08b', 'ffffbf',
    'd9ef8b', 'a6d96a', '66bd63', '1a9850', '006837',
  ]
};

Map.setCenter(0.0, 15.0, 2);

Map.addLayer(
    firstImage, visualization, 'PML_V2.2a Gross Primary Product (GPP)');