var dataset = ee.FeatureCollection('IBGE/UF/V2025');

Map.setCenter(-51.9253, -14.235, 4);

var styleParams = {
  fillColor: '2ca02c22',
  color: '2ca02c',
  width: 1.5,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'IBGE Brazil State Boundaries 2025');
