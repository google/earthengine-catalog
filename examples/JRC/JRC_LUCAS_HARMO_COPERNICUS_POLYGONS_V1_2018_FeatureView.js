var fvLayer = ui.Map.FeatureViewLayer('JRC/LUCAS_HARMO/COPERNICUS_POLYGONS/V1/2018_FeatureView');

var visParams = {
  pointSize: 20,
  color: 'red',
  pointFillColor: {
    property: 'inspire_plcc4',
    mode: 'linear',
    palette: ['ffffcc','c2e699','78c679','238443'],
    min: 0,
    max: 200
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Percentage of herbaceous plants');

Map.setCenter(18.8367, 51.9052, 8);
Map.add(fvLayer);