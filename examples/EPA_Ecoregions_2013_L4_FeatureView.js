var fvLayer = ui.Map.FeatureViewLayer('EPA/Ecoregions/2013/L4_FeatureView');

var visParams = {
  color: {
    property: 'shape_area',
    mode: 'linear',
    palette: ['0a3b04', '1a9924', '15d812'],
    min: 0.0,
    max: 67800000000.0
  },
  opacity: 0.8,
  polygonStrokeOpacity: 0
};

fvLayer.setVisParams(visParams);
fvLayer.setName('EPA/Ecoregions/2013/L4');

Map.setCenter(-99.814, 40.166, 5);
Map.add(fvLayer);
