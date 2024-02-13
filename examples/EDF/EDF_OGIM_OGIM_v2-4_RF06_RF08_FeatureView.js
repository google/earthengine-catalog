var fvLayer = ui.Map.FeatureViewLayer('EDF/OGIM/OGIM_v2-4_RF06_RF08_FeatureView');

var visParams = {
  pointSize: 3,
  color: {
    property: 'CATEGORY',
    categories: [
      ['GATHERING AND PROCESSING', 'red'],
      ['NATURAL GAS COMPRESSOR STATION', 'green'],
      ['NATURAL GAS FLARING DETECTIONS', 'blue'],
      ['OIL AND NATURAL GAS WELLS', 'purple'],
    ],
    defaultValue: 'white'
  }
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Oil and gas infrastructure database');

// Center on one of the two available areas of interests.
Map.setCenter(-109.6, 40, 9);
// Map.setCenter(-103.71, 31.96, 9);
Map.setOptions("SATELLITE");
Map.add(fvLayer);