var dataset = ee.ImageCollection('JAXA/ALOS/AVNIR-2/ORI')
                  .filter(ee.Filter.date('2011-01-01', '2011-04-01'));
var avnir2OriRgb = dataset.select(['B3', 'B2', 'B1']);
var avnir2OriRgbVis = {
  min: 0.0,
  max: 255.0,
};
Map.setCenter(138.7302, 35.3641, 12);
Map.addLayer(avnir2OriRgb, avnir2OriRgbVis, 'AVNIR-2 ORI RGB');
