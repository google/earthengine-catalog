var dataset = ee.ImageCollection('NASA/GSFC/MERRA/slv/2')
                  .filter(ee.Filter.date('2022-02-01', '2022-02-02'));
var surface_pressure = dataset.select('PS');
var surface_pressure_vis = {
  min: 81100,
  max: 117000,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(-95.62, 39.91, 2);
Map.addLayer(surface_pressure, surface_pressure_vis);
