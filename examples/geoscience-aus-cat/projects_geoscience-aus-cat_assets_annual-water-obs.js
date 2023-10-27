var water_obs = ee.ImageCollection('projects/geoscience-aus-cat/assets/annual-water-obs');

var point = ee.Geometry.Point([113.651455, -26.024137]);

var image = water_obs.filterBounds(point)
                     .filterDate('2010-01-01', '2011-01-01')
                     .first();
                     
var visualization_frequency = {
  bands: ['B03'],
  min: 0.0,
  max: 1.0,
  palette: ['ffffff', 'ffbbbb', '0000ff']
};

Map.centerObject(image, 12);
Map.addLayer(image, visualization_frequency, 'Water Frequency ratio');