var dataset = ee.FeatureCollection('IBGE/IMEDIATAS/V2025');

Map.setCenter(-51.9253, -14.235, 4);

var styleParams = {
  fillColor: '1b9e7722',
  color: '1b9e77',
  width: 1.0,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'IBGE Brazil Immediate Regions 2025');
