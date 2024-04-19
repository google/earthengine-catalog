var dataset = ee.Image('NASA/GRACE/MASS_GRIDS_V04/LAND/20170501_20170522');
var lwe_thickness = dataset.select('lwe_thickness_csr');
var palette = ['001137', '01abab', 'e7eb05', '620500'];
var equivalentWaterThicknessCsrVis = {
  palette: palette,
  min: -0.7845402964290882,
  max: 0.5693220260300134
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    lwe_thickness, equivalentWaterThicknessCsrVis,
    'Equivalent Water Thickness CSR');
