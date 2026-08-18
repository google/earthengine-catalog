var LAST_YEAR = 2025;
var versionEE = "v1_13";
var versionCloud = 'v1.13'

var lon = -62;
var lat = -18;

// Degrees in EPSG:4326
var delta = 40;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var vis_bands = ee.Image('projects/glad/GFC/'+LAST_YEAR+'/global_forest_change_'+LAST_YEAR+'_'+versionEE+'_previs')
  .unitScale(0, 255).unmask(0).updateMask(1);
// Break out the six thematic bands.
var mask = vis_bands.select('mask_uint8');
var loss = vis_bands.select('loss_uint8');
var tree = vis_bands.select('tree_uint8');
var year = vis_bands.select('year_uint8');
var new_loss = vis_bands.select('new_uint8');

var adjusted_loss = loss.min(tree).pow(0.7);
var adjusted_new_loss = new_loss.min(tree).pow(0.4);

// Grey oceans that can be added to visualizations for context.
var grey_mask = ee.Image(1).subtract(mask).multiply(0.25);

// Compute the classic loss year visualizations. The loss and loss-year
// bands define a red-to-yellow gradient; we extract the hue and saturation,
// and apply the adjusted loss as the value, producing both opaque and
// alpha-masked versions.
var loss_year_huesat = ee.Image([loss, loss.subtract(year), 0]).rgbToHsv().select(0, 1);
var loss_year = loss_year_huesat.addBands(adjusted_loss).hsvToRgb();

// Highlight new loss by replacing it with cyan.
var loss_year_old = loss_year.multiply(ee.Image(1).subtract(adjusted_new_loss));
var loss_year_new = loss_year_old.add(ee.Image([0,1,1]).multiply(adjusted_new_loss));


var prev = loss_year_new.add(grey_mask).multiply(255).uint8();

Map.addLayer(prev);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: prev, params: visParams}));

