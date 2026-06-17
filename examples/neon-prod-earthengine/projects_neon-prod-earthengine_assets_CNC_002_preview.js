var cnc = ee.ImageCollection(
  'projects/neon-prod-earthengine/assets/CNC/002');

var scbiSite = cnc.filter(ee.Filter.eq('system:index', '2017_SCBI_2')).select('Nitrogen_Percent').first();

var lon = -78.125;
var lat = 38.846;

Map.setCenter(lon, lat, 12);

// Degrees in EPSG:3857.
var delta = 0.009;
// Width and Height of the thumbnail image.
var pixels = 800;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest, crs: 'EPSG:3857', format: 'png'};

var vis = {min: 1.7, max: 2.5, palette: ['440154', '3b528b', '21908c', '5dc963', 'fde725']};

var image = scbiSite.visualize(vis);
var imageClip = scbiSite.visualize(vis).clip(areaOfInterest);

Map.addLayer(image, null, 'SCBI 2017 Canopy Percent Nitrogen (%)');

Map.addLayer(areaOfInterest, {color: 'red', opacity: 0.1}, 'Area of Interest');

print(ui.Thumbnail({image: imageClip, params: visParams}));