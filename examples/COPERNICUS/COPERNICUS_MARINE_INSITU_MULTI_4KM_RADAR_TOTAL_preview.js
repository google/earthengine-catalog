// This script loads a large BigQuery table and performs per-feature operations,
// which can make it take longer to load than typical Earth Engine scripts.
var dataset =
    ee.FeatureCollection
        .loadBigQueryTable(
            'earth-engine-public-data.insitu_nrt_currents.radar_total_latest')
        .filter(ee.Filter.date('2025-04-01', '2025-04-02'));

dataset = dataset.map(function(f) {
  var val = ee.Number(f.get('EWCT')).float();
  return f
      .buffer(3000)  // 3km radius circles
      .set('EWCT', val);
});


var image =
    dataset.reduceToImage({properties: ['EWCT'], reducer: ee.Reducer.first()});

var visParams = {
  min: -0.5,
  max: 0.5,
  palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
};

image = image.updateMask(image.neq(0));

var lon = 25.5;
var lat = 71.5;

var geometry = ee.Geometry.Polygon(
    [[
      [15.0, 74.0],  // Top Left (North Sea)
      [15.0, 68.0],  // Bottom Left (Near Lofoten/Tromsø)
      [32.0, 68.0],  // Bottom Right (Russian Border / Finland)
      [32.0, 74.0]   // Top Right (Barents Sea)
    ]],
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

var imageWithBackground = ee.ImageCollection([
                              waterLandBackground, image.visualize(visParams)
                            ]).mosaic();

Map.setCenter(lon, lat, 6);
Map.addLayer(imageWithBackground, {}, 'Radar Total EWCT (with background)');

print('Thumbnail of EWCT data with background:');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
