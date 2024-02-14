var image = ee.Image('JAXA/GPM_L3/GSMaP/v8/operational/20230912_2200');

var hourlyPrecip = image.select('hourlyPrecipRate')

var precipitationVis = {
  min: 0.0,
  max: 10.0,
  palette:
      ['011f4b', '87cefa', 'ffffff', '03ffff', '13ff03', 'efff00', 'ffff00', 'ffb103', 'ff2300'],
};

// Width and height of the thumbnail image.
var pixels = 256;

// Region of USA.
var areaOfInterest = ee.Geometry.Rectangle(
  [-92.7, 55.57, 4.59, -2.88], null, false);

var visParams = {
    dimensions: [pixels, pixels],
    region: areaOfInterest,
    crs: 'EPSG:3857',
    format: 'png',
};

var image = hourlyPrecip.visualize(precipitationVis);

Map.setCenter(-96.85, 28.43, 4);
Map.addLayer(image, {}, 'hourly precipitation rate');

print(ui.Thumbnail({image: image, params: visParams}));