var fvLayer = ui.Map.FeatureViewLayer('USGS/3DEP/10m_metadata_FeatureView');

var visParams = {
  opacity: 1,
  color: {
    property: 'zmean',
    mode: 'linear',
    palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
    min: 0,
    max: 2000
  },
  rules: [
   {
     filter: ee.Filter.eq('demname', 'pa_steasth10_8'),
     opacity: 0.1
   }
  ]
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Mean elevation');

Map.setCenter(-100.612, 43.687, 8);
Map.add(fvLayer);
