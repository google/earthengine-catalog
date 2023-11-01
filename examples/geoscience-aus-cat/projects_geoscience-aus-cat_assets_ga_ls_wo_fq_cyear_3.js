var water_obs = ee.ImageCollection('projects/geoscience-aus-cat/assets/ga_ls_wo_fq_cyear_3');

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({ min: 0, max: 255 });

var visualization_frequency = {
  bands: ['frequency'],
  min: 0.0,
  max: 1.0,
  palette: ['ffffff', 'ffbbbb', '0000ff']
};

var point = ee.Geometry.Point([113.651455, -26.024137]);

var image = water_obs.filterBounds(point)
                     .filterDate('2010-01-01', '2011-01-01')
                     .first()
                     .visualize(visualization_frequency);
                     
Map.centerObject(image, 12);
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Water Frequency ratio');
