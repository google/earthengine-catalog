var dataset = ee.Image('ISRIC/SoilGrids250m/v20/Q0_95').select('wv0010_0-5cm');

Map.setCenter(-105.25, 52.5, 3);

Map.addLayer(
    dataset, {
      min: -61,
      max: 636,
      palette: [
        '#440154', '#482878', '#3E4A89', '#31688E', '#26828E', '#1F9E89',
        '#35B779', '#6DCD59', '#B4DE2C', '#FDE725'
      ]
    },
    'SoilGrids250m 10kPa Q0.95');