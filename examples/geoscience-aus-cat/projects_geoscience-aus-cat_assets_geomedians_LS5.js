var geomedian_ls5 = ee.ImageCollection('projects/geoscience-aus-cat/assets/geomedians_LS5');

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
                             .filterDate('1995-01-01', '1996-01-01')
                             .mosaic();
                             
var visualization = {
  bands: ['red', 'green', 'blue'],
  min: 0,
  max: 3000
};

Map.centerObject(geometry);
Map.addLayer(composite, visualization, '1995 True Color Composite');