var geomedian_ls7 = ee.ImageCollection('projects/geoscience-aus-cat/assets/geomedians_LS7');

var geometry = 
    /* color: #98ff00 */
    /* displayProperties: [
      {
        "type": "rectangle"
      }
    ] */
    ee.Geometry.Polygon(
        [[[112.48755322062398, -10.110164065391384],
          [112.48755322062398, -39.68235603413486],
          [154.147709470624, -39.68235603413486],
          [154.147709470624, -10.110164065391384]]], null, false);

// Width and height of the thumbnail image.
var pixels = 256;
          
var composite = geomedian_ls7.filterBounds(geometry)
                             .filterDate('2008-01-01', '2009-01-01')
                             .mosaic();
                             
var visualization = {
  bands: ['red', 'green', 'blue'],
  min: 0,
  max: 3000
};

Map.centerObject(geometry);
Map.addLayer(composite, visualization, '2008 True Color Composite');

var imageParams = {
  dimensions: [pixels, pixels],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: composite.visualize(visualization), params: imageParams}));