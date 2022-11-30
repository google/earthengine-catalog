var dataset = ee.ImageCollection('Oxford/MAP/LST_Night_5km_Monthly')
                  .filter(ee.Filter.date('2015-01-01', '2015-12-31'));
var nighttimeLandSurfaceTemp = dataset.select('Mean');
var visParams = {
  min: -30.0,
  max: 30.0,
  palette: [
    '800080', '0000ab', '0000ff', '008000', '19ff2b', 'a8f7ff', 'ffff00',
    'd6d600', 'ffa500', 'ff6b01', 'ff0000'
  ],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(
    nighttimeLandSurfaceTemp, visParams, 'Nighttime Land Surface Temperature');
