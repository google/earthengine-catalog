var dataset = ee.ImageCollection('TNC/HM/v3/90m_s').first();
var image = dataset.select('All_threats_combined').visualize({
  min: 0.0,
  max: 1.0,
  palette: ['0c0c0c', '071aff', 'ff0000', 'ffbd03', 'fbff05', 'fffdfd']
});

var lon = -105.0;
var lat = 40.0;

var center = ee.Geometry.Point([lon, lat]);
var areaOfInterest = center.buffer(20000).bounds();

var pixels = 256;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

Map.setCenter(lon, lat, 10);
Map.addLayer(image, {}, 'TNC Global Human Modification v3');

print(ui.Thumbnail({image: image, params: imageParams}));
