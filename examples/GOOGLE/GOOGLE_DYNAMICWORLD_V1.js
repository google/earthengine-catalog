// Construct a collection of corresponding Dynamic World and Sentinel-2 for
// inspection. Filter by region and date.
var START = ee.Date('2021-04-02');
var END = START.advance(1, 'day');

var colFilter = ee.Filter.and(
    ee.Filter.bounds(ee.Geometry.Point(20.6729, 52.4305)),
    ee.Filter.date(START, END));

var dwCol = ee.ImageCollection('GOOGLE/DYNAMICWORLD/V1').filter(colFilter);
var s2Col = ee.ImageCollection('COPERNICUS/S2_HARMONIZED');

// Link DW and S2 source images.
var linkedCol = dwCol.linkCollection(s2Col, s2Col.first().bandNames());

// Get example DW image with linked S2 image.
var linkedImg = ee.Image(linkedCol.first());

// Create a visualization that blends DW class label with probability.
// Define list pairs of DW LULC label and color.
var CLASS_NAMES = [
    'water', 'trees', 'grass', 'flooded_vegetation', 'crops',
    'shrub_and_scrub', 'built', 'bare', 'snow_and_ice'];

var VIS_PALETTE = [
    '419bdf', '397d49', '88b053', '7a87c6', 'e49635', 'dfc35a', 'c4281b',
    'a59b8f', 'b39fe1'];

// Create an RGB image of the label (most likely class) on [0, 1].
var dwRgb = linkedImg
    .select('label')
    .visualize({min: 0, max: 8, palette: VIS_PALETTE})
    .divide(255);

// Get the most likely class probability.
var top1Prob = linkedImg.select(CLASS_NAMES).reduce(ee.Reducer.max());

// Create a hillshade of the most likely class probability on [0, 1];
var top1ProbHillshade =
    ee.Terrain.hillshade(top1Prob.multiply(100))
    .divide(255);

// Combine the RGB image with the hillshade.
var dwRgbHillshade = dwRgb.multiply(top1ProbHillshade);

// Display the Dynamic World visualization with the source Sentinel-2 image.
Map.setCenter(20.6729, 52.4305, 12);
Map.addLayer(
    linkedImg, {min: 0, max: 3000, bands: ['B4', 'B3', 'B2']}, 'Sentinel-2 L1C');
Map.addLayer(
    dwRgbHillshade, {min: 0, max: 0.65}, 'Dynamic World V1 - label hillshade');