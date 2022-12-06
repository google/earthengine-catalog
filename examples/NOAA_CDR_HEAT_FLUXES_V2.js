var dataset = ee.ImageCollection('NOAA/CDR/HEAT_FLUXES/V2')
                  .filter(ee.Filter.date('2017-05-01', '2017-05-14'));
var heatFluxVis = {
  min: -50.0,
  max: 500.0,
  bands: [
    'surface_upward_sensible_heat_flux',
    'surface_upward_sensible_heat_flux',
    'surface_upward_latent_heat_flux',
  ]
};
Map.setCenter(28.61, -18.98, 2);
Map.addLayer(dataset, heatFluxVis, 'Heat Flux');
