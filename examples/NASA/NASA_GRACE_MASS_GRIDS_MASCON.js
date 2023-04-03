var dataset = ee.ImageCollection('NASA/GRACE/MASS_GRIDS/MASCON')
                  .filter(ee.Filter.date('2016-08-01', '2016-08-30'));
var equivalentWaterThickness = dataset.select('lwe_thickness');
var equivalentWaterThicknessVis = {
  min: -25.0,
  max: 25.0,
};
Map.setCenter(6.746, 46.529, 2);
Map.addLayer(
    equivalentWaterThickness, equivalentWaterThicknessVis,
    'Equivalent Water Thickness');
