var dataset = ee.ImageCollection('NASA/SMAP/SPL4SMGP/008').first();

var smSurface = dataset.select('sm_surface');
var smSurfaceVis = {
  min: 0.0,
  max: 0.9,
  palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
};
Map.setCenter(-6.746, 46.529, 2);
Map.addLayer(smSurface, smSurfaceVis, 'SM Surface');
