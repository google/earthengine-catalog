// Construct a collection of corresponding Dynamic World and Sentinel-2 for
// inspection. Filter the DW and S2 collections by region and date.
var COL_FILTER = ee.Filter.and(
    ee.Filter.bounds(ee.Geometry.Point(20.6729, 52.4305)),
    ee.Filter.date('2021-04-02', '2021-04-03'));

var dwCol = ee.ImageCollection('GOOGLE/DYNAMICWORLD/V1').filter(COL_FILTER);
var s2Col = ee.ImageCollection('COPERNICUS/S2').filter(COL_FILTER);

// Join corresponding DW and S2 images (by system:index).
var DwS2Col = ee.Join.saveFirst('s2_img').apply(dwCol, s2Col,
    ee.Filter.equals({leftField: 'system:index', rightField: 'system:index'}));

// Extract an example DW image and its source S2 image.
var dwImage = ee.Image(DwS2Col.first());
var s2Image = ee.Image(dwImage.get('s2_img'));

// Create a visualization that blends DW class label with probability.
// Define list pairs of DW LULC label and color.
var CLASS_NAMES = [
    'water', 'trees', 'grass', 'flooded_vegetation', 'crops',
    'shrub_and_scrub', 'built', 'bare', 'snow_and_ice'];

var VIS_PALETTE = [
    '419BDF', '397D49', '88B053', '7A87C6',
    'E49635', 'DFC35A', 'C4281B', 'A59B8F',
    'B39FE1'];

// Create an RGB image of the label (most likely class) on [0, 1].
var dwRgb = dwImage
    .select('label')
    .visualize({min: 0, max: 8, palette: VIS_PALETTE})
    .divide(255);

// Get the most likely class probability.
var top1Prob = dwImage.select(CLASS_NAMES).reduce(ee.Reducer.max());

// Create a hillshade of the most likely class probability on [0, 1];
var top1ProbHillshade =
    ee.Terrain.hillshade(top1Prob.multiply(100))
    .divide(255);

// Combine the RGB image with the hillshade.
var dwRgbHillshade = dwRgb.multiply(top1ProbHillshade);

// Display the Dynamic World visualization with the source Sentinel-2 image.
Map.setCenter(20.6729, 52.4305, 12);
Map.addLayer(
    s2Image,
    {min: 0, max: 3000, bands: ['B4', 'B3', 'B2']},
    'Sentinel-2 L1C');
Map.addLayer(
    dwRgbHillshade,
    {min: 0, max: 0.65},
    'Dynamic World');
