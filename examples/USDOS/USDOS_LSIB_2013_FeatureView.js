var fvLayer = ui.Map.FeatureViewLayer('USDOS/LSIB/2013_FeatureView');

var visParams = {
  color: {
    property: 'iso_num',
    mode: 'linear',
    palette: ['f5ff64', 'b5ffb4', 'beeaff', 'ffc0e8', '8e8dff', 'adadad'],
    min: 0.0,
    max: 894.0
  },
  opacity: 0.8
};

fvLayer.setVisParams(visParams);
fvLayer.setName('USDOS/LSIB/2013');

Map.setCenter(16.35, 48.83, 4);
Map.add(fvLayer);
