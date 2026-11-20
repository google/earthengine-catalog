var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/intertidal_frequency/v1');
var frequency = dataset
    .filter(ee.Filter.eq('tide_state', 'all-tide'))
    .filter(ee.Filter.eq('period', '2023-2025'))
    .mosaic()
    .select('inundationFrequency');

// Dark grey low-tide composite as the background (stretch fixed for this site).
var lowTide = ee.ImageCollection('projects/global-wetland-watch/assets/coastal/tidal_composites/v1')
    .filter(ee.Filter.eq('period', '2023-2025'))
    .filter(ee.Filter.eq('tide_state', 'low'))
    .mosaic()
    .select(['B4', 'B3', 'B2'])
    .reduce(ee.Reducer.mean());
var base = lowTide.visualize({min: 904, max: 1319, palette: ['101418', '8a9096']});

// Inundation frequency on shoreline wetland types only (multiannual typology classes
// 1-5); frequencies below 35% fade out.
var types = ee.ImageCollection('projects/global-wetland-watch/assets/results/multiannual/v1')
    .filter(ee.Filter.eq('period', '2023-2025'))
    .mosaic()
    .select('mode_class');
var shoreline = types.gte(1).and(types.lte(5)).unmask(0);
var opacity = frequency.unitScale(0, 35).clamp(0, 1).multiply(shoreline);
var visParams = {
  min: 0,
  max: 100,
  palette: ['fff7ec', 'fee8c8', 'fdd49e', 'fdbb84', 'fc8d59', 'ef6548', 'd7301f', 'b30000',
            '7f0000'],
};
var image = base.blend(frequency.visualize(visParams).updateMask(opacity));

// Bahia Blanca, Argentina.
var lon = -62.2;
var lat = -38.95;
Map.setCenter(lon, lat, 11);

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, image]).mosaic();
Map.addLayer(imageWithBackground, {}, 'Inundation frequency, all tides (%)');

var parameters = {
  dimensions: [256, 256],
  region: ee.Geometry.Rectangle([-62.32, -39.0433, -62.08, -38.8566], null, false),
  crs: 'EPSG:3857',
  format: 'png'
};
print(ui.Thumbnail({image: imageWithBackground, params: parameters}));
