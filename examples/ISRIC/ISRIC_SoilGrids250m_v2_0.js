var dataset = ee.Image('ISRIC/SoilGrids250m/v2_0/wv0010').select('val_0_5cm_Q0_95');

Map.setCenter(-105.25, 52.5, 3);

Map.addLayer(
    dataset, {
      min: -0.061,
      max: 0.636,
      palette: [
        '#440154', '#482878', '#3E4A89', '#31688E', '#26828E', '#1F9E89',
        '#35B779', '#6DCD59', '#B4DE2C', '#FDE725'
      ]
    },
    'SoilGrids250m 10kPa Q0.95 0-5cm');