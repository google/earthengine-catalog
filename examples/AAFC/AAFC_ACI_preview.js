var dataset =
    ee.ImageCollection('AAFC/ACI').sort('system:time_start', false).first();
var landcover = dataset.select('landcover');
var image = landcover.visualize();

var geometry = ee.Geometry.Polygon(
    [[
      [-104.63311029215753, 53.02962325741053],
      [-104.63311029215753, 52.704654006011715],
      [-104.05358148356378, 52.704654006011715],
      [-104.05358148356378, 53.02962325741053]
    ]],
    null, false);

var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var lon = -103.8881;
var lat = 53.0372;
Map.setCenter(lon, lat, 10);
Map.addLayer(image)

print(ui.Thumbnail({image: image, params: imageParams}));
