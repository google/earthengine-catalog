// PARDIG-NRT 15-minute global precipitation rate for a single timestamp.
var dataset =
    ee.ImageCollection(
          'projects/gcp-public-data-weathernext/assets/PARDIG_1_NRT')
        .filterDate('2021-05-17T12:15:00Z');

// Convert m/hr to mm/hr and mask low precipitation.
var precipitation = dataset.first()
    .select('precipitation')
    .multiply(1000);
precipitation = precipitation.updateMask(precipitation.gt(0.5));

var lon = 78;
var lat = 20;

Map.setCenter(lon, lat, 4);

// Degrees in EPSG:4326
var lon_delta = 16;
var lat_delta = 16;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lon_delta, lat - lat_delta, lon + lon_delta, lat + lat_delta], null,
    false);

var imageVis = {
  min: 1,
  max: 15,
  palette: [
    '000096', '0064ff', '00b4ff', '33db80', '9beb4a',
    'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
  ]
};

var imageVisualized = precipitation.visualize(imageVis);

// Opaque background so non-raining areas are not transparent in the
// thumbnail: gray ocean, white land with country outlines.
var oceanBackground = ee.Image.constant(0).visualize({palette: ['d3d3d3']});
var countries = ee.FeatureCollection('USDOS/LSIB_SIMPLE/2017').style({
  fillColor: 'FFFFFF',
  color: '000000',
  width: 1,
});
var combinedVisual =
    oceanBackground.blend(countries.visualize()).blend(imageVisualized);

Map.addLayer(combinedVisual, {}, 'Precipitation (mm/hr)');

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: combinedVisual, params: imageParams}));
