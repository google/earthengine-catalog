// This script loads a large BigQuery table and performs per-feature operations,
// which can make it take longer to load than typical Earth Engine scripts.
var dataset = ee.FeatureCollection.loadBigQueryTable("earth-engine-public-data.insitu_nrt_currents.radar_radial_latest")
                  .filter(ee.Filter.date('2025-04-01', '2025-04-02'));

dataset = dataset.map(function(f) {
  var val = ee.Number(f.get('RDVA')).float();
  return f.buffer(3000) // 3km radius circles
          .set('RDVA', val);
});


var image = dataset.reduceToImage({
  properties: ['RDVA'],
  reducer: ee.Reducer.first()
});

var visParams = {
  min: -0.5,
  max: 0.5,
  palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
};
image = image.updateMask(image.neq(0));
// ***************************************************************

var lon = -9.46;
var lat = 42.76;

var geometry = ee.Geometry.Polygon(
    [[
      [-12.0, 45.0], // Top Left (Deep Ocean)
      [-12.0, 41.5], // Bottom Left (Off coast of Portugal)
      [-6.0, 41.5],  // Bottom Right (Portugal/Spain Border land)
      [-6.0, 45.0]   // Top Right (Bay of Biscay)
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

var imageWithBackground =
    ee.ImageCollection([waterLandBackground, image.visualize(visParams)]).mosaic();

Map.setCenter(lon, lat, 8);
Map.addLayer(imageWithBackground, {}, 'Radar Radial RDVA (with background)');

print('Thumbnail of RDVA data with background:');
print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
