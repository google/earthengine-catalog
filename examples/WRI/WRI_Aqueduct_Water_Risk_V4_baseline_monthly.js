var dataset =
    ee.FeatureCollection('WRI/Aqueduct_Water_Risk/V4/baseline_monthly');

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

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
Map.addLayer(waterLandBackground);

// Baseline water stress
var polygons = dataset.filter('bws_01_cat > -2').map(bws_cat_style);

Map.setCenter(10, 20, 4);

Map.addLayer(polygons.style({styleProperty: 'style', pointSize: 3}));