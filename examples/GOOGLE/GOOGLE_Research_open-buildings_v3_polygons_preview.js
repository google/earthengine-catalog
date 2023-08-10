var t = ee.FeatureCollection('GOOGLE/Research/open-buildings/v3/polygons');

var lat_lng = [6.492, 3.389]  // Lagos, Nigeria

Map.setCenter(lat_lng[1], lat_lng[0], 17);
Map.setOptions('SATELLITE');

var delta = 0.005;
var pixels = 256;

var areaOfInterest = ee.Geometry.Rectangle(
    [
      lat_lng[1] - delta, lat_lng[0] - delta, lat_lng[1] + delta,
      lat_lng[0] + delta
    ],
    null, false);
var t_065_070_im = t.filter('confidence >= 0.65 && confidence < 0.7')
                       .filterBounds(areaOfInterest)
                       .style({color: 'FF0000'});
var t_070_075_im = t.filter('confidence >= 0.7 && confidence < 0.75')
                       .filterBounds(areaOfInterest)
                       .style({color: 'FFFF00'});
var t_gte_075_im =
    t.filter('confidence >= 0.75').filterBounds(areaOfInterest).style({
      color: '00FF00'
    });

var imageParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:3857',
  format: 'png',
};
var background = ee.Image.rgb(0, 0, 0);
var raster_image = ee.ImageCollection([
                       /* needed to construct mosaic properly*/ t_065_070_im,
                       background, t_065_070_im, t_070_075_im, t_gte_075_im
                     ]).mosaic();

print(ui.Thumbnail({image: raster_image, params: imageParams}));
