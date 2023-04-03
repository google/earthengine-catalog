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
        palette: ['00441B', '00682A', '37A055', '5DB96B',
                  'AEDEA7', 'E7F6E2', 'F7FCF5'],
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
