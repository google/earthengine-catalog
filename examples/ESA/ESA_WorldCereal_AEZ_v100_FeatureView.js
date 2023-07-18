var aezLayer = ui.Map.FeatureViewLayer('ESA/WorldCereal/AEZ/v100_FeatureView');
var visParams = {
  opacity: 0.5,
  lineWidth: 5,
  polygonFillColor: 'red'
};

aezLayer.setVisParams(visParams);
aezLayer.setName('Agro-Ecological Zones');

Map.setCenter(15.5, 35.5, 3);
Map.add(aezLayer);
