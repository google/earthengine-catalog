var fvLayer = ui.Map.FeatureViewLayer('IBGE/REGIOES/V2025_FeatureView');

var visParams = {
  color: '1b9e77',
  fillColor: 'b5ffb4',
  opacity: 0.8,
  width: 1.5,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('IBGE Brazil Macro Regions 2025');

Map.setCenter(-51.9253, -14.235, 4);
Map.add(fvLayer);
