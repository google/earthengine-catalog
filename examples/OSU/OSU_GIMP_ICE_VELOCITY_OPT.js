var dataset = ee.ImageCollection('OSU/GIMP/ICE_VELOCITY_OPT')
                  .filter(ee.Filter.date('2016-01-01', '2016-09-15'));
var iceVelocityVis = {
  min: [-1000],
  max: [1000],
  palette: ['red', 'black', 'blue'],
  bands: ['velocity_x']
};
Map.setCenter(-66.82, 76.151, 7);
Map.addLayer(dataset, iceVelocityVis, 'Ice Velocity');
