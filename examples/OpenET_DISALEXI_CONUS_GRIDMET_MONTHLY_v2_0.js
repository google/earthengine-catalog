var dataset = ee.ImageCollection('OpenET/DISALEXI/CONUS/GRIDMET/MONTHLY/v2_0')
  .filterDate('2020-01-01', '2021-01-01')

var et = dataset.select(['et']).sum()

var visualization = {
  min: 0.0,
  max: 1400.0,
  palette: [
    '9E6212', 'AC7D1D', 'BA9829', 'C8B434', 'D6CF40', 'BED44B', '9FCB51', '80C256', '61B95C', '42B062',
    '45B677', '49BC8D', '4DC2A2', '51C8B8', '55CECE', '4DB4BA', '459AA7', '3D8094', '356681', '2D4C6E',
  ]
};

Map.setCenter(-100.0, 38.0, 5);

Map.addLayer(et, visualization, 'OpenET DisALEXI Monthly ET');
