var dataset = ee.ImageCollection('NASA/GRACE/MASS_GRIDS/LAND')
                  .filter(ee.Filter.date('2016-08-01', '2016-08-30'));
var equivalentWaterThicknessCsr = dataset.select('lwe_thickness_csr');
var equivalentWaterThicknessCsrVis = {
  min: -25.0,
  max: 25.0,
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    equivalentWaterThicknessCsr, equivalentWaterThicknessCsrVis,
    'Equivalent Water Thickness CSR');
