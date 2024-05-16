var dataset = ee.Image('NASA/GRACE/MASS_GRIDS_V04/OCEAN/20020403_20020430');
var equivalentWaterThicknessCsr = dataset.select('lwe_thickness_csr');
var equivalentWaterThicknessCsrVis = {
  min: -0.0799629208930322,
  max: 0.07938676715178997,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(6.746, 46.529, 1);
Map.addLayer(
    equivalentWaterThicknessCsr, equivalentWaterThicknessCsrVis,
    'Equivalent Water Thickness CSR');
