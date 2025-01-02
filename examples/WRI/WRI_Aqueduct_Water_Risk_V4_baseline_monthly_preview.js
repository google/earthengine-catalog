var geometry = 
    ee.Geometry.Polygon(
        [[[24.62577649496426, 38.79316550803842],
          [24.62577649496426, 18.08907948137941],
          [50.311811651214256, 18.08907948137941],
          [50.311811651214256, 38.79316550803842]]], null, false);

var dataset =
    ee.FeatureCollection('WRI/Aqueduct_Water_Risk/V4/baseline_monthly');

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
  return setColor(f, 'bws_01_cat', -1, 4, reds);
};
// Baseline water stress
var polygons = dataset.filter('bws_01_cat > -2').map(bws_cat_style);

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