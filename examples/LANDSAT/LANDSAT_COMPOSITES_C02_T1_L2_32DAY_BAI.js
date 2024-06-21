var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_32DAY_BAI')
                  .filterDate('2023-01-01', '2023-03-01');
var burnedArea = dataset.select('BAI');

var burnedAreaVis = {
  min: 0.0,
  max: 100.0,
};
Map.setCenter(21.6, -18, 8);
Map.addLayer(burnedArea, burnedAreaVis, 'Burned Area');