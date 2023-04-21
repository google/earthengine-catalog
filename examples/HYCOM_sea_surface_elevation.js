var dataset = ee.ImageCollection('HYCOM/sea_surface_elevation')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var surfaceElevation = dataset.select('surface_elevation');
var surfaceElevationVis = {
  min: -2000.0,
  max: 2000.0,
  palette: ['blue', 'cyan', 'yellow', 'red'],
};
Map.setCenter(-28.1, 28.3, 1);
Map.addLayer(surfaceElevation, surfaceElevationVis, 'Surface Elevation');
