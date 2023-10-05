var water_obs = ee.ImageCollection('projects/geoscience-aus-cat/assets/annual-water-obs');

var visualization_frequency = {
  bands: ['B03'],
  min: 0.0,
  max: 1.0,
  palette: ['ffffff', 'ffbbbb', '0000ff']
};

var lon = 114.03130;
var lat = -25.927246;

Map.setCenter(lon, lat, 10);

// Degrees in EPSG:3857.
var delta = 0.25;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var image = water_obs.filterDate('2010-01-01', '2011-01-01')
                  .filterBounds(areaOfInterest).first()
                  .visualize(visualization_frequency);
                  
Map.addLayer(image, visualization_frequency, 'Water Frequency ratio');

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: image, params: imageParams}));
