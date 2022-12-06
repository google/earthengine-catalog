var dataset = ee.ImageCollection('NASA/GSFC/MERRA/flx/2')
                  .filter(ee.Filter.date('2022-02-01', '2022-02-02'));
var surface_bouyancy_scale = dataset.select('BSTAR');
var sbsVis = {
  min: -0.00998,
  max: 0.01174,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(-95, 39, 2);
Map.addLayer(surface_bouyancy_scale, sbsVis, 'Surface bouyancy scale');