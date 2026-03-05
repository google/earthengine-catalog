var image = ee.ImageCollection('UCSB-CHC/CHIRPS/V3/PENTAD')
                  .filter(ee.Filter.date('2023-01-01', '2023-01-06')).first();
var precipitation = image.select('precipitation');

var lon = 17.93;
var lat = 0;
var delta = 46;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  min: 10.0,
  max: 170.0,
  palette: ['#001137', '#0aab1e', '#e7eb05', '#2c7fb8', '#253494'],
};

var final_image = precipitation.visualize(visParams);

// Create a water/land background image using ETOPO1 data.
var waterLand = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gt(0.0);
var backgroundPalette = ['cadetblue', 'lightgray'];
var waterLandBackground = waterLand.visualize({palette: backgroundPalette});

var final_image_with_background =
    ee.ImageCollection([waterLandBackground, final_image]).mosaic();

Map.setCenter(17.93, 0, 2);
Map.addLayer(final_image, {}, 'CHIRPS V3 Pentad Precipitation');

// Create a 256x256 thumbnail for the South America region.
print(ui.Thumbnail({
    image: final_image_with_background,
    params: {
        dimensions: [256, 256],
        region: areaOfInterest,
        format: 'png'
    }
}));