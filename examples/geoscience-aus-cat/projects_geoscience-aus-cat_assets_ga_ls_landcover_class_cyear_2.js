var landcover = ee.ImageCollection('projects/geoscience-aus-cat/assets/ga_ls_landcover_class_cyear_2');

var visualization = {
  bands: ['level4_R', 'level4_G', 'level4_B']
};

var lon = 122.41280;
var lat = -18.06402;

Map.setCenter(lon, lat, 10);

// Degrees in EPSG:3857.
var delta = 0.25;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var image = landcover.filterDate('1995-01-01', '1996-01-01')
                     .filterBounds(areaOfInterest);
                  
Map.addLayer(image, visualization, 'Land Cover');