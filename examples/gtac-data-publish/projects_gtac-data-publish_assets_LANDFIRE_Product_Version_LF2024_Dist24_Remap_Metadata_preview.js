var metadata = ee.FeatureCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024_Dist24_Remap_Metadata')
    .filter(ee.Filter.neq('VALUE', -9999))
    .sort('VALUE');
var image = ee.ImageCollection('projects/gtac-data-publish/assets/LANDFIRE/Product_Version/LF2024')
    .filterDate('2023-10-01', '2024-10-01')
    .filter(ee.Filter.eq('study_area', 'CONUS'))
    .first();

var disturbanceType = image.select('Dist_raw').remap(
    metadata.aggregate_array('VALUE'),
    metadata.aggregate_array('Dist_type_L1'),
    255);
var visualization = disturbanceType
    .updateMask(disturbanceType.neq(0).and(disturbanceType.neq(255)))
    .visualize({
      min: 1,
      max: 10,
      palette: [
        'd6604d', 'f4a582', 'b88712', 'd1e5f0', '6eaac8',
        '6a3d9a', '9c27b0', '003300', 'ffff00', '6f6f6f'
      ]
    });

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var imageWithBackground = ee.ImageCollection([background, visualization]).mosaic();
var region = ee.Geometry.Rectangle([-125.0, 31.0, -102.0, 49.0], null, false);

print(ui.Thumbnail({
  image: imageWithBackground,
  params: {
    dimensions: [256, 256],
    region: region,
    crs: 'EPSG:3857',
    format: 'png'
  }
}));
