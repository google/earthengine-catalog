var dataset = ee.ImageCollection('NCEP_RE/surface_wv')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var totalColumnWaterVapor = dataset.select('pr_wtr');
var totalColumnWaterVaporVis = {
  min: 0.0,
  max: 60.0,
  palette: ['0000ff', '00ffff', '008000', 'ffff00', 'ff0000'],
};
Map.setCenter(-158.2, 2.81, 2);
Map.addLayer(
    totalColumnWaterVapor, totalColumnWaterVaporVis,
    'Total Column Water Vapor');
