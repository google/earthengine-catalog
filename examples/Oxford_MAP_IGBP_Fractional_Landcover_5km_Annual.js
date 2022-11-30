var dataset =
    ee.ImageCollection('Oxford/MAP/IGBP_Fractional_Landcover_5km_Annual')
        .filter(ee.Filter.date('2012-01-01', '2012-12-31'));
var landcover = dataset.select('Overall_Class');
var landcoverVis = {
  min: 1.0,
  max: 19.0,
  palette: [
    '032f7e', '02740b', '02740b', '8cf502', '8cf502', 'a4da01', 'ffbd05',
    'ffbd05', '7a5a02', 'f0ff0f', '869b36', '6091b4', '999999', 'ff4e4e',
    'ff4e4e', 'ffffff', 'feffc0', '020202', '020202'
  ],
};
Map.setCenter(-88.6, 26.4, 1);
Map.addLayer(landcover, landcoverVis, 'Landcover');
