var dataset = ee.ImageCollection('NASA/GSFC/MERRA/lnd/2')
                  .filter(ee.Filter.date('2022-02-01', '2022-02-02'));
var baseflow_flux = dataset.select('BASEFLOW');
var bfVis = {
  min: -0.00000913,
  max:  0.00001076,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(-95, 39, 2);
Map.addLayer(baseflow_flux, bfVis, 'Baseflow flux');
