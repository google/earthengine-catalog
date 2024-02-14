var dataset = ee.ImageCollection('JRC/GFC2020/V1').mosaic();

var visualization = {
  bands: ['Map'],
  palette: ['4D9221']};

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(dataset, visualization, 'EC JRC Global forest cover 2020 – V1');
