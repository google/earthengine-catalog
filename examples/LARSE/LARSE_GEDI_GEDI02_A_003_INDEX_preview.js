var lon = -60.0;
var lat = -5.0;
var delta = 20.0;
var lonDelta = delta / Math.cos(lat * (Math.PI / 180));

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - lonDelta, lat - delta, lon + lonDelta, lat + delta], null, false);

var dataset =
    ee.FeatureCollection('LARSE/GEDI/GEDI02_A_003_INDEX')
        .filter(
            'time_start > "2024-08-10T00:00:00Z" && ' +
            'time_end < "2024-08-12T00:00:00Z"')
        .filterBounds(areaOfInterest);
var styled =
    dataset.style({color: '004d00', fillColor: '2ca02c66', width: 1.5});

var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var waterLandBackground =
    waterLand.visualize({palette: ['cadetblue', 'lightgray']});
var imageWithBackground = waterLandBackground.blend(styled);

var pixels = 256;
var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));

Map.setCenter(lon, lat, 4);
Map.addLayer(imageWithBackground, {}, 'Preview');
