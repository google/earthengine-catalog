var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/water/frequency/v1');

// Sites of interest [lon, lat, zoom]. Change the line below to visit another site,
// e.g. SITES.yukonDelta.
var SITES = {
  pantanal: [-57.2, -18.2, 9],         // Pantanal, Brazil
  lakeTefe: [-64.75, -3.45, 11],       // Lake Tefe, Amazon (2023 drought)
  yukonDelta: [-163.0, 61.0, 10],      // Yukon-Kuskokwim Delta, Alaska
  yukonFlats: [-146.0, 66.5, 10],      // Yukon Flats, Alaska
  marChiquita: [-62.6, -30.7, 9],      // Mar Chiquita, Argentina
};
var site = SITES.pantanal;

var multiannual = dataset.filter(ee.Filter.eq('product', 'multiannual')).mosaic();

// Annual images near the site only, to keep the per-pixel range cheap.
var area = ee.Geometry.Point([site[0], site[1]]).buffer(100000);
var annual = dataset.filterBounds(area).filter(ee.Filter.eq('product', 'annual')).select('swf');

// Range of annual water frequency between years (high = variable water).
var range = annual.max().subtract(annual.min());

var swfVis = {
  bands: ['swf'],
  min: 0,
  max: 100,
  palette: ['ffffff', 'b3cde3', '6497b1', '005b96', '03396c'],
};

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(annual.filter(ee.Filter.eq('startYear', 2024)).mosaic().selfMask(), swfVis,
             'Surface water frequency (2024)', false);
Map.addLayer(range.selfMask(), {min: 0, max: 100, palette: ['2b0b3f', 'b5367a', 'fbb61a', 'fcfdbf']},
             'Range between years (percentage points)', false);
Map.addLayer(multiannual.selfMask(), swfVis, 'Surface water frequency (2017-2025)');
