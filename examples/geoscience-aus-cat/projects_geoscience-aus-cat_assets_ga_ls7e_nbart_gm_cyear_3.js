var geomedian_ls7 = ee.ImageCollection('projects/geoscience-aus-cat/assets/ga_ls7e_nbart_gm_cyear_3');

var geometry = 
    /* color: #98ff00 */
    /* displayProperties: [
      {
        "type": "rectangle"
      }
    ] */
    ee.Geometry.Polygon(
      [[[121.15880998755823, -15.010654451073695],
        [121.15880998755823, -18.377531570740548],
        [125.81701311255823, -18.377531570740548],
        [125.81701311255823, -15.010654451073695]]], null, false);
          
var composite = geomedian_ls7.filterBounds(geometry)
                             .filterDate('2008-01-01', '2009-01-01')
                             .mosaic();
                             
var visualization = {
  bands: ['red', 'green', 'blue'],
  min: 0,
  max: 3000
};

Map.centerObject(geometry, 10);
Map.addLayer(composite, visualization, '2008 True Color Composite');