var dataset = ee.ImageCollection('ASTER/AST_L1T_003')
                  .filter(ee.Filter.date('2018-01-01', '2018-08-15'));
var falseColor = dataset.select(['B3N', 'B02', 'B01']);
var falseColorVis = {
  min: 0.0,
  max: 255.0,
};
Map.setCenter(-122.0272, 39.6734, 11);
Map.addLayer(falseColor.median(), falseColorVis, 'False Color');
