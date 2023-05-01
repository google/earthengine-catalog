var fvLayer = ui.Map.FeatureViewLayer(
  'BLM/AIM/v1/TerrADat/TerrestrialAIM_FeatureView');

var visParams = {
  isVisible: false,
  pointSize: 7,
  rules: [
    {
      filter: ee.Filter.expression('WoodyHgt_Avg > 1'),
      isVisible: true,
      color: {
        property: 'WoodyHgt_Avg',
        mode: 'linear',
        palette: ['00441b', '00682a', '37a055', '5db96b',
                  'aedea7', 'e7f6e2', 'f7fcf5'],
        min: 0,
        max: 100
      }
    }
  ]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Average woody plant height');

Map.setCenter(-110, 40, 6);
Map.add(fvLayer);
