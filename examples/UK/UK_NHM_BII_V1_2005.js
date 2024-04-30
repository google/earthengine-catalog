var img = ee.Image('UK/NHM/BII/V1/2005')
var visualization = {
  bands: ['b1'],
  min: 0,
  max: 1,
  palette: ['bbe029', '0a9501', '074b03']
};
Map.addLayer(img, visualization, 'Biodiversity Intactness Index')