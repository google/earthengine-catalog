var dataset = ee.ImageCollection('JRC/GHSL/P2016/SMOD_POP_GLOBE_V1')
                  .filter(ee.Filter.date('2015-01-01', '2015-12-31'));
var degreeOfUrbanization = dataset.select('smod_code');
var visParams = {
  min: 0.0,
  max: 3.0,
  palette: ['000000', '448564', '70daa4', 'ffffff'],
};
Map.setCenter(114.96, 31.13, 4);
Map.addLayer(degreeOfUrbanization, visParams, 'Degree of Urbanization');
