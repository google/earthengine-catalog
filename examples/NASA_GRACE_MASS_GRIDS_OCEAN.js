var dataset = ee.ImageCollection('NASA/GRACE/MASS_GRIDS/OCEAN')
                  .filter(ee.Filter.date('2016-08-01', '2016-08-30'));
var equivalentWaterThicknessCsr = dataset.select('lwe_thickness_csr');
var equivalentWaterThicknessCsrVis = {
  min: -10.0,
  max: 10.0,
};
Map.setCenter(6.746, 46.529, 1);
Map.addLayer(
    equivalentWaterThicknessCsr, equivalentWaterThicknessCsrVis,
    'Equivalent Water Thickness CSR');
