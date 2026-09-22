var fvLayer = ui.Map.FeatureViewLayer('IBGE/PAIS/V2025_FeatureView');

var visParams = {
  color: '004d40',
  fillColor: '00796b',
  opacity: 0.8,
  width: 2,
};

fvLayer.setVisParams(visParams);
fvLayer.setName('IBGE Brazil Country Boundary 2025');

Map.setCenter(-51.9253, -14.235, 4);
Map.add(fvLayer);
