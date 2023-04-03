// Band aliases.
var BLUE = 'CMI_C01';
var RED = 'CMI_C02';
var VEGGIE = 'CMI_C03';
var GREEN = 'GREEN';
// 16 pairs of CMI and DQF followed by Bah 2018 synthetic green.
// Band numbers in the EE asset, 0-based.
var NUM_BANDS = 33;
// Skipping the interleaved DQF bands.
var BLUE_BAND_INDEX = (1 - 1) * 2;
var RED_BAND_INDEX = (2 - 1) * 2;
var VEGGIE_BAND_INDEX = (3 - 1) * 2;
var GREEN_BAND_INDEX = NUM_BANDS - 1;

// Visualization range for GOES RGB.
var GOES_MIN = 0.0;
var GOES_MAX = 0.7;  // Alternatively 1.0 or 1.3.
var GAMMA = 1.3;

var goesRgbViz = {
  bands: [RED, GREEN, BLUE],
  min: GOES_MIN,
  max: GOES_MAX,
  gamma: GAMMA
};

var applyScaleAndOffset = function(image) {
  image = ee.Image(image);
  var bands = new Array(NUM_BANDS);
  for (var i = 1; i < 17; i++) {
    var bandName = 'CMI_C' + (100 + i + '').slice(-2);
    var offset = ee.Number(image.get(bandName + '_offset'));
    var scale =  ee.Number(image.get(bandName + '_scale'));
    bands[(i-1) * 2] = image.select(bandName).multiply(scale).add(offset);

    var dqfName = 'DQF_C' + (100 + i + '').slice(-2);
    bands[(i-1) * 2 + 1] = image.select(dqfName);
  }

  // Bah, Gunshor, Schmit, Generation of GOES-16 True Color Imagery without a
  // Green Band, 2018. https://doi.org/10.1029/2018EA000379
  // Green = 0.45 * Red + 0.10 * NIR + 0.45 * Blue
  var green1 = bands[RED_BAND_INDEX].multiply(0.45);
  var green2 = bands[VEGGIE_BAND_INDEX].multiply(0.10);
  var green3 = bands[BLUE_BAND_INDEX].multiply(0.45);
  var green = green1.add(green2).add(green3);
  bands[GREEN_BAND_INDEX] = green.rename(GREEN);

  return ee.Image(ee.Image(bands).copyProperties(image, image.propertyNames()));
};

var collection = 'NOAA/GOES/16/MCMIPF/';
var imageName = '2020210184019900000';
var assetId = collection + imageName;
var image = applyScaleAndOffset(assetId);
Map.addLayer(image, goesRgbViz);
