var dataset = ee.ImageCollection('VITO/PROBAV/S1_TOC_100M');

var visualization = {
  bands: ['RED', 'NIR', 'BLUE'],
  min: 20.0,
  max: 2000.0,
};

Map.setCenter(17.93, 7.71, 2);

Map.addLayer(dataset, visualization, 'False Color');
