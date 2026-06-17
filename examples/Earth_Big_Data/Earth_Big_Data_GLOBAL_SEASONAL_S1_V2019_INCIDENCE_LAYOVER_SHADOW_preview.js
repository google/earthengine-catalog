var geometry = ee.Geometry.BBox(-74, 59, -10, 80);
var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gte(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});

var dataset =
    ee.ImageCollection(
          'Earth_Big_Data/GLOBAL_SEASONAL_S1/V2019/INCIDENCE_LAYOVER_SHADOW')
        .select('inc')
        .filterBounds(geometry)
        .mean()
        .mask(waterLandMask);

var visParams = {
  bands: ['inc'],
  min: 30,
  max: 70,
};
var image = dataset.visualize(visParams);
var imageParams = {
  dimensions: [256, 256],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
