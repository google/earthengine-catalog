var dataset = ee.ImageCollection('BIOPAMA/GlobalOilPalm/v1_2');

// Band 1: Oil palm plantation type classification (10 m resolution)
// 0: Other land covers that are not oil palm
// 1: Industrial closed-canopy oil palm plantations
// 2: Smallholder closed-canopy oil palm plantations
var classification = dataset.select('classification').mosaic();
var classificationVis = {
  min: 0.0,
  max: 2.0,
  palette: ['18181b', 'd97706', '06b6d4'],
};

// Create a mask to add transparency to non-oil palm plantation class pixels.
var mask = classification.neq(0);
mask = mask.where(mask.eq(0), 0.6);

// Band 2: Year of plantation establishment (1989-2022, 30 m resolution)
var plantingYear = dataset.select('planting_year').mosaic();

// Visualize planting year separately for industrial (warm amber/gold) and
// smallholder (cool navy/cyan) plantations over a dark background.
var industrialYearVis = {
  min: 1989.0,
  max: 2022.0,
  palette: ['451a03', '92400e', 'd97706', 'f59e0b', 'fef08a'],
};
var smallholderYearVis = {
  min: 1989.0,
  max: 2022.0,
  palette: ['082f49', '0369a1', '06b6d4', '38bdf8', 'cffafe'],
};

var background = ee.Image.rgb(24, 24, 27).visualize({min: 0, max: 255});
var industrialYear = plantingYear
    .updateMask(classification.eq(1))
    .visualize(industrialYearVis);
var smallholderYear = plantingYear
    .updateMask(classification.eq(2))
    .visualize(smallholderYearVis);

var composite = ee.ImageCollection([
  background,
  industrialYear,
  smallholderYear,
]).mosaic();

Map.setCenter(101.31, 1.1, 11);
Map.addLayer(composite, {}, 'Oil Palm Planting Year by Class (1989-2022)');
Map.addLayer(
    industrialYear, {}, 'Industrial Planting Year (1989-2022)', false);
Map.addLayer(
    smallholderYear, {}, 'Smallholder Planting Year (1989-2022)', false);
Map.addLayer(
    classification.updateMask(mask), classificationVis,
    'Oil Palm Classification', false);
