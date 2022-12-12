// Demonstrates displaying GOES-18 Mesoscale images.

// Band names.
var BLUE = 'CMI_C01';
var RED = 'CMI_C02';
var VEGGIE = 'CMI_C03';
var GREEN = 'GREEN';

/**
 * Properly scales an MCMIPM image.
 *
 * @param {ee.Image} image An unaltered MCMIPM image.
 * @return {ee.Image}
 */
var applyScaleAndOffset = function(image) {
  var names = image.select('CMI_C..').bandNames();

  // Scale the radiance bands using the image's metadata.
  var scales = names.map(function(name) {
    return image.getNumber(ee.String(name).cat('_scale'));
  });
  var offsets = names.map(function(name) {
    return image.getNumber(ee.String(name).cat('_offset'));
  });
  var scaled = image.select('CMI_C..')
                   .multiply(ee.Image.constant(scales))
                   .add(ee.Image.constant(offsets));

  return image.addBands({srcImg: scaled, overwrite: true});
};

/**
 * Computes and adds a green radiance band to a MCMIPM image.
 *
 * The image must already have been properly scaled via applyScaleAndOffset.
 *
 * For more information on computing the green band, see:
 *   https://doi.org/10.1029/2018EA000379
 *
 * @param {ee.Image} image An image to add a green radiance band to. It
 *     must be the result of the applyScaleAndOffset function.
 * @return {ee.Image}
 */
var addGreenBand = function(image) {
  function toBandExpression(bandName) { return 'b(\'' + bandName + '\')'; }

  var B_BLUE = toBandExpression(BLUE);
  var B_RED = toBandExpression(RED);
  var B_VEGGIE = toBandExpression(VEGGIE);

  // Green = 0.45 * Red + 0.10 * NIR + 0.45 * Blue
  var GREEN_EXPR = GREEN + ' = 0.45 * ' + B_RED + ' + 0.10 * ' + B_VEGGIE +
      ' + 0.45 * ' + B_BLUE;

  var green = image.expression(GREEN_EXPR).select(GREEN);
  return image.addBands(green);
};


var COLLECTION = 'NOAA/GOES/18/MCMIPM';

// Select a subset of the collection, correct the values, and add a green band.
var START = ee.Date('2022-08-03T19:59:00');
var END = START.advance(10, 'minutes');
var collection = ee.ImageCollection(COLLECTION)
  .filterDate(START, END)
  .map(applyScaleAndOffset)
  .map(addGreenBand);

// Separates the two domains.
var domain1_col = collection.filter('domain == 1');
var domain2_col = collection.filter('domain == 2');

// Note that there are 20 assets, 10 in each domain.
var size = ee.String('sizes: collection = ').cat(collection.size());
var size1 = ee.String('domain1 = ').cat(domain1_col.size());
var size2 = ee.String('domain2 = ').cat(domain2_col.size());
print(size.cat('  →  ').cat(size1).cat(' and ').cat(size2));

// Visualization parameters.
var goesRgbViz = { bands: [RED, GREEN, BLUE], min: 0.0, max: 0.38, gamma: 1.3 };

// Displays a sample image from domain 1 and 2.
Map.addLayer(domain1_col.first(), goesRgbViz, 'Domain 1');
Map.addLayer(domain2_col.first(), goesRgbViz, 'Domain 2');

Map.setCenter(-133, 50, 3);
