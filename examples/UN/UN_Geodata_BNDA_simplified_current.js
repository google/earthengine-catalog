var dataset = ee.FeatureCollection('UN/Geodata/BNDA_simplified/current');

var styleParams = {
  fillColor: 'b5ffb4',
  color: '00909F',
  width: 1.0,
};

dataset = dataset.style(styleParams);
Map.centerObject(dataset);
Map.addLayer(dataset, {}, 'BNDA simplified');
