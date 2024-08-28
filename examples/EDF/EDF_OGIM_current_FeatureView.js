var fvLayer = ui.Map.FeatureViewLayer('EDF/OGIM/current_FeatureView');

var visParams = {
  pointSize: 2,
  width: 0.5,
  color: {
    property: 'CATEGORY',
    categories: [
      ['GATHERING AND PROCESSING', 'red'],
      ['NATURAL GAS COMPRESSOR STATION', 'green'],
      ['NATURAL GAS FLARING DETECTIONS', 'blue'],
      ['OIL AND NATURAL GAS WELLS', 'purple'],
      ['OFFSHORE PLATFORMS', 'yellow']
    ],
    defaultValue: 'white'
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Oil and gas infrastructure database');

Map.setCenter(-96, 40, 4);
Map.setOptions("SATELLITE");
Map.add(fvLayer);