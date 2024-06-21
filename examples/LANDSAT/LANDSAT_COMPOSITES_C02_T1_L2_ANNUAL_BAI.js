var dataset = ee.ImageCollection('LANDSAT/COMPOSITES/C02/T1_L2_ANNUAL_BAI')
                  .filterDate('2023-01-01', '2023-12-31');
var burnedArea = dataset.select('BAI');

var burnedAreaVis = {
  min: 0.0,
  max: 100.0,
};
Map.setCenter(21.6, -18, 8);
Map.addLayer(burnedArea, burnedAreaVis, 'Burned Area');