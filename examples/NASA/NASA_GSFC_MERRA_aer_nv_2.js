var dataset = ee.ImageCollection('NASA/GSFC/MERRA/aer_nv/2')
                  .filter(ee.Filter.date('1985-02-01', '1985-02-02'));
dataset = dataset.first()
var pressure_thickness = dataset.select('DELP_72');
var bccVis = {
  min: 1188.8580904647688,
  max: 1761.7886613672472,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(-95.62, 39.91, 2);
Map.addLayer(pressure_thickness, bccVis);
