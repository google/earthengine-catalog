var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.drifter_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-05-01'));

var temps = dataset.select('TEMP');


var minTemp = temps.aggregate_min('TEMP');
var maxTemp = temps.aggregate_max('TEMP');

var tempVis = {
  min: 18,
  max: 25,
  palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
  forceRgbOutput: true
};

// Create an empty image and paint the features, coloring by 'TEMP'.
var image = ee.Image().float().paint({
  featureCollection: temps,
  color: 'TEMP',
  width: 7 
});


image = image.updateMask(image.neq(0));
// ***************************************************************

var lon = -100.5;
var lat = 30.2;

var geometry = ee.Geometry.Polygon(
    [[[-130, 40],
      [-130, -20],
      [-55, -10],
      [-55, 55]]],
    null, false);

var pixels = 256;

var areaOfInterest = geometry;

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'gray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image.visualize(tempVis)]).mosaic();

Map.setCenter(lon, lat, 3);
Map.addLayer(imageWithBackground, {}, 'Drifter Temperatures (with background)');

print('Thumbnail of temperature data with background:');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));