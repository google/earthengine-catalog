var dataset = ee.ImageCollection('HYCOM/GLBu0_08/sea_water_velocity')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-15'));
var waterVelocityVis = {
  min: -1000.0,
  max: 4000.0,
  bands: ['velocity_u_0', 'velocity_v_0', 'velocity_v_0'],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(dataset, waterVelocityVis, 'Water Velocity');
