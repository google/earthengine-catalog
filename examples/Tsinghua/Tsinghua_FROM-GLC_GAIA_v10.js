var dataset = ee.Image('Tsinghua/FROM-GLC/GAIA/v10');

var visualization = {
  bands: ['change_year_index'],
  min: 0.0,
  max: 34.0,
  palette: [
    '014352', '1a492c', '071ec4', 'b5ca36', '729eac', '8ea5de',
    '818991', '62a3c3', 'ccf4fe', '74f0b9', '32bc55', 'c72144',
    '56613b', 'c14683', 'c31c25', '5f6253', '11bf85', 'a61b26',
    '99fbc5', '188aaa', 'c2d7f1', 'b7d9d8', '856f96', '109c6b',
    '2de3f4', '9a777d', '151796', 'c033d8', '510037', '640c21',
    '31a191', '223ab0', 'b692ac', '2de3f4',
  ]
};

Map.setCenter(-37.62, 25.8, 2);

Map.addLayer(dataset, visualization, 'Change year index');
