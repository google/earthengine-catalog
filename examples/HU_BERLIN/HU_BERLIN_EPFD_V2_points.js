var dataset = ee.FeatureCollection('HU_BERLIN/EPFD/V2/points');

Map.setCenter(13.64, 50.11, 4);

var styleParams = {
  fillColor: '0F7209',
  color: '000000',
  width: 1.0,
};

dataset = dataset.style(styleParams);

Map.addLayer(dataset, {}, 'European Primary Forest Points');
