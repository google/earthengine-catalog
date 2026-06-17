var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL')
                  .filterDate('2023-01-01', '2024-01-01');
var rgb = dataset.select(['red', 'green', 'blue']);
var rgbVis = {
  min: 0.0,
  max: 0.3,
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(rgb, rgbVis, 'RGB');
