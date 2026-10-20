var dataset = ee.FeatureCollection('IBGE/REGIOES/V2025');

Map.setCenter(-51.9253, -14.235, 4);

var styleParams = {
  fillColor: '1b9e7722',
  color: '1b9e77',
  width: 1.5,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'IBGE Brazil Macro Regions 2025');
