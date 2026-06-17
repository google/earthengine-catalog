var image2020 = ee.Image('JRC/GFC2020/V3');

var visualization = {
  bands: ['Map'],
  palette: ['4D9221']};

Map.setCenter(0.0, 0.0, 2);

Map.addLayer(image2020, visualization, 'EC JRC Global forest cover 2020 – V3');
