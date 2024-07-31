var range = ee.Date('2019-09-03').getRange('day');
var dataset = ee.ImageCollection('NASA/GPM_L3/IMERG_V07')
    .filter(ee.Filter.date(range));

var precipitation = dataset.select('precipitation').max();
var mask = precipitation.gt(0.5);
var precipitation = precipitation.updateMask(mask);

var palette = [
  '000096','0064ff', '00b4ff', '33db80', '9beb4a',
  'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
];

var lon = 26.73;
var lat = 4.26;
Map.setCenter(lon, lat, 2);
var delta = 50;

// Define the area of interest.
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var precipitationVis = {min: 0.0, max: 1.5, palette: palette};
var image1 = precipitation.visualize(precipitationVis);

var aez = ee.FeatureCollection('ESA/WorldCereal/AEZ/v100');
var aezImage = ee.Image().byte();
var aezOutlines = aezImage.paint({
  featureCollection: aez,
  color: '000000',
  width: 3
});

var landWaterBackground = aezOutlines.visualize({palette: ['black', 'lightgray']});
Map.addLayer(landWaterBackground);

// Combine the precipitation visualization with the AEZ outlines.
var combinedVisual = image1.blend(landWaterBackground);

Map.addLayer(combinedVisual, {}, 'Precipitation with AEZ Boundaries');

// Define parameters for the thumbnail image.
var pixels = 256;
var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// Display the thumbnail.
print(ui.Thumbnail({image: combinedVisual, params: visParams}));
