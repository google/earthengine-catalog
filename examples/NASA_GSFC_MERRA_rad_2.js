var dataset = ee.ImageCollection('NASA/GSFC/MERRA/rad/2')
                  .filter(ee.Filter.date('2022-02-01', '2022-02-02')).first();
var surface_albedo = dataset.select('ALBEDO');
var saVis = {
  min: -0.428147,
  max: 0.833350,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(-95, 39, 2);
Map.addLayer(surface_albedo, saVis, 'Surface albedo');