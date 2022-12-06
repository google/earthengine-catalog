var dataset = ee.ImageCollection('NASA/GSFC/MERRA/aer/2')
                  .filter(ee.Filter.date('2022-02-01', '2022-02-02'));
var black_carbon_column_u_wind_mass_flux = dataset.select('BCFLUXU');
var bccVis = {
  min: -0.0000116,
  max: 0.0000165,
  palette: ['001137', '01abab', 'e7eb05', '620500']
};
Map.setCenter(-95.62, 39.91, 2);
Map.addLayer(black_carbon_column_u_wind_mass_flux, bccVis);
