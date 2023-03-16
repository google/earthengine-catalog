var dataset = ee.ImageCollection('CSIRO/SLGA')
                  .filter(ee.Filter.eq('attribute_code', 'DES'));
var soilDepth = dataset.select('DES_000_200_EV');
var soilDepthVis = {
  min: 0.1,
  max: 1.84,
  palette: ['8d6738', '252525'],
};
Map.setCenter(132.495, -21.984, 5);
Map.addLayer(soilDepth, soilDepthVis, 'Soil Depth');