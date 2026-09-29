var ldacs = ee.Image('projects/landandcarbon/assets/wri_ldacs/current/ldacs');

var ldacs_viz = {
  min:1, 
  max: 4,
  palette: ['9A3B01','AB8C00','0000FF','DB2777']
};

Map.addLayer(ldacs, ldacs_viz, 'LDACS')

var lon = -46.14046 
var lat = -8.98439 

Map.setCenter(lon, lat, 10);

// Degrees in EPSG:4326
var delta = .075;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);
  
var parameters = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326', 
  format: 'png'
};

var backGround = ee.Image(1).visualize({palette: ['black']})
    
var imageWithBg = backGround.blend(ldacs.visualize(ldacs_viz));

print(ui.Thumbnail({image: imageWithBg, params: parameters}));