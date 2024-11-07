var geomedian_ls8ls9 = ee.ImageCollection('projects/geoscience-aus-cat/assets/ga_ls8cls9c_gm_cyear_3');

var geometry = 
    /* color: #98ff00 */
    /* displayProperties: [
      {
        "type": "rectangle"
      }
    ] */
    ee.Geometry.Polygon(
      [[[113.6706967727757, -21.328008847100683],
        [113.6706967727757, -23.863481220471765],
        [116.7248959915257, -23.863481220471765],
        [116.7248959915257, -21.328008847100683]]], null, false);

// Width and height of the thumbnail image.
var pixels = 256;
      
var composite = geomedian_ls8ls9.filterBounds(geometry)
                             .filterDate('2018-01-01', '2019-01-01')
                             .mosaic();
                             
var visualization = {
  bands: ['nbart_red', 'nbart_green', 'nbart_blue'],
  min: 0,
  max: 3000
};

Map.centerObject(geometry, 10);
Map.addLayer(composite, visualization, '2018 True Color Composite');

var imageParams = {
  dimensions: [pixels, pixels],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: composite.visualize(visualization), params: imageParams}));
