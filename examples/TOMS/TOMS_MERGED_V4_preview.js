var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gte(0.0);
var background = waterLandMask.visualize({palette: ['gray', 'black']});

var dataset = ee.ImageCollection('TOMS/MERGED_V4')
                  .filter(ee.Filter.date('2018-08-01', '2018-08-10'));
var columnOzone = dataset.select('ozone').mean();
var columnOzoneVis = {
  min: 100,
  max: 500,
  palette: ['1621a2', 'cyan', 'green', 'yellow', 'orange', 'red'],
};

Map.setCenter(0, 0, 1);
Map.addLayer(background, {}, 'Background (Land/Water)');
Map.addLayer(columnOzone, columnOzoneVis, 'Column Ozone', true, 0.7);

var image = columnOzone.visualize(
    {min: 100, max: 500, palette: columnOzoneVis.palette, opacity: 0.7});
var imageWithBackground = background.blend(image);

var areaOfInterest = ee.Geometry.BBox(-180, -60, 180, 85);

var imageParams = {
  dimensions: [256, 256],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
