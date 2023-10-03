var landcover = ee.ImageCollection('projects/geoscience-aus-cat/assets/ga_landcover');

var level3palette = [
    '#ffffff', // No Data
    '#acbc2d', // Cultivated terrestrial vegetation
    '#0e7912', // Natural terrestrial vegetation
    '#1ebf79', // Natural acquatic vegetation
    '#da5c69', // Artificial surface
    '#f3ab69', // Natural bare surface
    '#4d9fdc'  // Water
  ];

var visualization = {
  bands: ['remapped'],
  min: 0,
  max: 6,
  palette: level3palette
};

var lon = 122.41280;
var lat = -18.06402;

Map.setCenter(lon, lat, 10);

// Degrees in EPSG:3857.
var delta = 0.25;

var areaOfInterest = ee.Geometry.Rectangle(
  [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var image = landcover.filterDate('1995-01-01', '1996-01-01')
                     .filterBounds(areaOfInterest)
                     .select('B04')
                     .map(function(img){
                       return img.remap(
                        [0, 111, 112, 124, 215, 216, 220],
                        [0, 1, 2, 3, 4, 5, 6]
                       );
                     });
                  
Map.addLayer(image, visualization, 'Land Cover');