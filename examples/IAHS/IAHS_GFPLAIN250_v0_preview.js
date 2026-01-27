var image = ee.Image('IAHS/GFPLAIN250/v0');

var floodVis = {
  min: 0,
  max: 1,
  palette: ['red', 'blue']
};

var lon = 31.25;
var lat = 30.05;
var delta = 3;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};

// 2. Prepare the background
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

// 3. IMPORTANT: Visualize the GFPLAIN image so it becomes 3-band RGB
var imageRGB = image.visualize(floodVis);

// 4. Now the mosaic will work because both are 3-band RGB
var imageWithBackground = ee.ImageCollection([waterLandBackground, imageRGB]).mosaic();

Map.setCenter(lon, lat, 7);
Map.addLayer(imageWithBackground, {}, 'Combined View');

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));