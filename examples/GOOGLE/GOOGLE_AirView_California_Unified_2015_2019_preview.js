
var fc = ee.FeatureCollection('GOOGLE/AirView/California_Unified_2015_2019');

Map.setCenter(-122.827746, 38.4001353, 20);
Map.setOptions('SATELLITE');

// Width and height of the thumbnail image.
var pixels = 256;
var areaOfInterest =
    ee.Geometry.Rectangle([-122.8282449, 38.4004033, -122.8274523, 38.3998946], null, false);

var normal = fc.filter('NO2 >= 0 && NO2 < 1')
                       .filterBounds(areaOfInterest)
                       .style({color: 'green'});
var mild = fc.filter('NO2 >= 1 && NO2 < 2')
                       .filterBounds(areaOfInterest)
                       .style({color: 'yellow'});
var strong =
    fc.filter('NO2 >= 2').filterBounds(areaOfInterest).style({
      color: 'red'
    });

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};
var background = ee.Image.rgb(0, 0, 0);
var raster_image = ee.ImageCollection([
                       normal,
                       background, normal, mild, strong
                     ]).mosaic();
Map.addLayer(raster_image)
print(ui.Thumbnail({image: raster_image, params: imageParams}));
