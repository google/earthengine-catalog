var geomedian_ls5 = ee.ImageCollection('projects/geoscience-aus-cat/assets/geomedians_LS7');

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
          
var composite = geomedian_ls5.filterBounds(geometry)
                             .filterDate('2008-01-01', '2008-01-01')
                             .mosaic();
                             
var visualization = {
  bands: ['B03', 'B02', 'B01'],
  min: 0,
  max: 0.3
};

Map.centerObject(geometry);
Map.addLayer(image, visualization, '2008 True Color Composite');

var imageParams = {
  dimensions: [pixels, pixels],
  region: geometry,
  crs: 'EPSG:3857',
  format: 'png',
};

print(ui.Thumbnail({image: image.visualize(visualization), params: imageParams}));