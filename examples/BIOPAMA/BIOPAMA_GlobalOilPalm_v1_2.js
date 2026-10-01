var dataset = ee.ImageCollection('BIOPAMA/GlobalOilPalm/v1_2');

// Band 1: Oil palm plantation type classification (10 m resolution)
// 0: Other land covers that are not oil palm
// 1: Industrial closed-canopy oil palm plantations
// 2: Smallholder closed-canopy oil palm plantations
var classification = dataset.select('classification').mosaic().selfMask();
var classificationVis = {
  min: 0.0,
  max: 2.0,
  palette: ['696969', 'ff0000', 'ef00ff'],
};

// Band 2: Year of plantation establishment (1990-2021, 30 m resolution)
var plantingYear = dataset.select('planting_year').mosaic().selfMask();
var yearVis = {
  min: 1990.0,
  max: 2021.0,
  palette: ['ffffb2', 'fecc5c', 'fd8d3c', 'f03b20', 'bd0026'],
};

Map.setCenter(101.7, 3.1, 10);
Map.addLayer(classification, classificationVis, 'Oil Palm Classification');
Map.addLayer(plantingYear, yearVis, 'Planting Year (1990-2021)', false);
