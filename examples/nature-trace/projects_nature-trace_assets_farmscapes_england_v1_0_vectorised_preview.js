var fc = ee.FeatureCollection('projects/nature-trace/assets/farmscapes/england_v1_0_vectorised');

var strippedFc = fc.filter(ee.Filter.neq('feature_name', 'hedge gap'));

var styles = {
  'hedgerow': {color: 'FF00FF', fillColor: '40FF00FF'},
  'copse': {color: '00FF7F', fillColor: '4000FF7F'},
  'linear_woodland': {color: '2E8B57', fillColor: '402E8B57'},
  'stone wall': {color: 'D3D3D3', fillColor: '40D3D3D3'},
  'woodland': {color: '005e5e', fillColor: '40005e5e'},
};

var styleDict = ee.Dictionary(styles);

var styledFc = strippedFc.map(function(f) {
  var featureStyle = ee.Dictionary(styleDict.get(f.get('feature_name')));
  return f.set('style', featureStyle);
});

var vectorImage = styledFc.style({
  styleProperty: 'style',
  width: 2
});

var backGround = ee.Image(1).visualize({palette: ['lightgray']});

var waterLand = ee.Image('NOAA/NGDC/ETOPO1')
  .select('bedrock')
  .gt(0.0)
  .clip(ee.Geometry.BBox(-180, -55, 180, 75));
  
var waterLandBackground = waterLand.visualize({palette: ['white', 'lightgray']});

var imageWithBg = backGround
  .blend(waterLandBackground)
  .blend(vectorImage); 

var lon = -1.43;
var lat = 52.973;
var lon_delta = 0.02;
var lat_delta = 0.02;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null, false
);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBg, params: imageParams}));