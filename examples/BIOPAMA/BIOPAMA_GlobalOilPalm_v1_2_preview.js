var dataset = ee.ImageCollection('BIOPAMA/GlobalOilPalm/v1_2');
var classification = dataset.select('classification').mosaic();
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

var lon = 101.31;
var lat = 1.1;

Map.setCenter(lon, lat, 11);
Map.addLayer(composite, {}, 'Oil Palm Planting Year by Class (1989-2022)');

var delta = 0.12;
var rect = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var thumbnail = ui.Thumbnail({
  image: composite,
  params: {
    dimensions: '256',
    region: rect,
    format: 'png',
  },
  style: {height: '256px', width: '256px'},
});

print(thumbnail);
