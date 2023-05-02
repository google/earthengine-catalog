// Visualization for WRI/GPPD/power_plants

var table = ee.FeatureCollection('WRI/GPPD/power_plants');

// Get a color from a fuel
var fuelColor = ee.Dictionary({
  'Coal': '000000',
  'Oil': '593704',
  'Gas': 'bc80bd',
  'Hydro': '0565A6',
  'Nuclear': 'e31a1c',
  'Solar': 'ff7f00',
  'Waste': '6a3d9a',
  'Wind': '5ca2d1',
  'Geothermal': 'fdbf6f',
  'Biomass': '229a00'
});

// List of fuels to add to the map
var fuels = [
    'Coal', 'Oil', 'Gas', 'Hydro', 'Nuclear',
    'Solar', 'Waste', 'Wind', 'Geothermal', 'Biomass'];

/**
 * Computes size from capacity and color from fuel type.
 *
 * @param {!ee.Geometry.Point} pt A point
 * @return {!ee.Geometry.Point} Input point with added style dictionary.
 */
function addStyle(pt) {
  var size = ee.Number(pt.get('capacitymw')).sqrt().divide(10).add(2);
  var color = fuelColor.get(pt.get('fuel1'));
  return pt.set(
      'styleProperty', ee.Dictionary({'pointSize': size, 'color': color}));
}

// Make a FeatureCollection out of the power plant data table.
var pp = ee.FeatureCollection(table).map(addStyle);
print(pp.first());

/**
 * Adds power plants of a certain fuel type to the map.
 *
 * @param {string} fuel A fuel type
 */
function addLayer(fuel) {
  print(fuel);
  Map.addLayer(
      pp.filter(ee.Filter.eq('fuel1', fuel))
          .style({styleProperty: 'styleProperty', neighborhood: 50}),
      {}, fuel, true, 0.65);
}

// Apply `addLayer` to each record in `fuels`.
fuelColor.keys().evaluate(function(fuelsList) {
  fuelsList.map(addLayer);
});
