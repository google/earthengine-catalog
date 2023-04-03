var dataset = ee.ImageCollection('NOAA/CDR/AVHRR/LAI_FAPAR/V5')
                  .filter(ee.Filter.date('2018-02-01', '2018-03-01'));
var leafAreaIndex = dataset.select('LAI');
var leafAreaIndexVis = {
  min: 0.0,
  max: 4000.0,
  palette: ['3b0200', '977705', 'ca9f06', 'ffca09', '006a03', '003b02'],
};
Map.setCenter(20, 24.5, 2);
Map.addLayer(leafAreaIndex, leafAreaIndexVis, 'Leaf Area Index');
