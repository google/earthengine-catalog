var geometry = 
    ee.Geometry.Polygon(
        [[[43.785932744964256, 53.517861592241594],
          [43.785932744964256, 36.97239028370388],
          [69.47196790121426, 36.97239028370388],
          [69.47196790121426, 53.517861592241594]]], null, false);


var dataset =
    ee.FeatureCollection('WRI/Aqueduct_Water_Risk/V4/baseline_annual');

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

var reds = ee.List([
  '67000D', '9E0D14', 'E32F27', 'F6553D', 'FCA082', 'FEE2D5'
]);

function normalize(value, min, max) {
  return value.subtract(min).divide(ee.Number(max).subtract(min));
}
function setColor(feature, property, min, max, palette) {
  var value = normalize(feature.getNumber(property), min, max)
                  .multiply(palette.size())
                  .min(palette.size().subtract(1))
                  .max(0);
  return feature.set({style: {color: palette.get(value.int())}});
}

var bws_cat_style = function(f) {
  return setColor(f, 'bws_cat', -1, 4, reds);
};
// Baseline water stress
var polygons = dataset.filter('bws_cat > -2').map(bws_cat_style);

var pixels = 256;
var areaOfInterest = geometry;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var styledPolygons = polygons.style({styleProperty: 'style', pointSize: 3});

Map.setCenter(14, 23, 4);
Map.addLayer(styledPolygons);

var imageWithBg = waterLandBackground.blend(styledPolygons);



print(ui.Thumbnail({image: imageWithBg, params: imageParams}))