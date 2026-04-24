var table = ee.FeatureCollection('WCMC/WDPCA/202602/points');

var lon = -98.58;
var lat = 39.83;
Map.setCenter(lon, lat, 4);

// Degrees.
var delta = 30;
// Width and height of the thumbnail image.
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var style = table.filterBounds(areaOfInterest).style({
  color: '4285F4',
  pointSize: 3
});

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  format: 'png',
};

var dem = ee.Image('CGIAR/SRTM90_V4');
var hillshade = ee.Terrain.hillshade(dem);

var whiteBG = ee.Image.constant([255, 255, 255])
                .rename(['red', 'green', 'blue'])
                .visualize({min: 0, max: 255});

// Convert hillshade to RGB for blending
var hillshadeRGB = hillshade.visualize({min: 150, max: 255, palette: ['#F5F5F5', '#BDBDBD']});

// Combine the background with the styled points.
var compositeImage = ee.ImageCollection([whiteBG, hillshadeRGB, style]).mosaic();

var thumb = ui.Thumbnail({
  image: compositeImage,
  params: imageParams
});
print(thumb);

Map.addLayer(hillshadeRGB, {}, 'hillshade');
Map.addLayer(style, {}, 'WDPCA points');
