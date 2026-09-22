var fvLayer = ui.Map.FeatureViewLayer('IBGE/UF/V2025_FeatureView');

var visParams = {
  color: '2ca02c',
  fillColor: 'b5ffb4',
  opacity: 0.8,
  width: 1.5,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('IBGE Brazil State Boundaries 2025');

Map.setCenter(-51.9253, -14.235, 4);
Map.add(fvLayer);
