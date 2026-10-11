var lon = 63.06;
var lat = 16.17;
var geometry = ee.Geometry.BBox(lon - 80, lat - 45, lon + 80, lat + 45);

var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gte(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});

var dataset = ee.ImageCollection('IDAHO_EPSCOR/TERRACLIMATE_V1_1')
                  .filterBounds(geometry)
                  .filter(ee.Filter.date('2017-07-01', '2017-08-01'))
                  .first();

var maximumTemperature = dataset.select('tmmx');
var maximumTemperatureVis = {
  min: -300.0,
  max: 300.0,
  palette: [
    '1a3678', '2955bc', '5699ff', '8dbae9', 'acd1ff', 'caebff', 'e5f9ff',
    'fdffb4', 'ffe6a2', 'ffc969', 'ffa12d', 'ff7c1f', 'ca531a', 'ff0000',
    'ab0000'
  ],
};

var image = maximumTemperature.visualize(maximumTemperatureVis);

var imageParams = {
  dimensions: [256, 256],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};

var imageWithBg = waterLandBackground.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));
