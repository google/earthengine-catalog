var fvLayer = ui.Map.FeatureViewLayer('IBGE/IMEDIATAS/V2025_FeatureView');

var visParams = {
  color: '1b9e77',
  fillColor: 'b5ffb4',
  opacity: 0.8,
  width: 1.0,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('IBGE Brazil Immediate Regions 2025');

Map.setCenter(-51.9253, -14.235, 4);
Map.add(fvLayer);
