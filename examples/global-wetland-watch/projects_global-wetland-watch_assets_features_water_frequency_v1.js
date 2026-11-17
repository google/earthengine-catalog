var dataset = ee.ImageCollection('projects/global-wetland-watch/assets/features/water/frequency/v1');

// ---- Choose a site ----------------------------------------------------
// Replace 'sfBay' with 'pantanal', 'lakeTefe', 'yukonDelta', 'yukonFlats' or 'marChiquita'
// (sites are listed in SITES below).
var SITE = 'sfBay';

// ---- Choose a year ----------------------------------------------------
// Year of the annual layer: any year from 2017 to 2025.
var YEAR = 2024;

// Sites [lon, lat, zoom]; add your own to explore elsewhere.
var SITES = {
  sfBay: [-122.02, 37.48, 12],         // Salt ponds, South San Francisco Bay, USA
  pantanal: [-57.2, -18.2, 9],         // Pantanal, Brazil
  lakeTefe: [-64.75, -3.45, 11],       // Lake Tefe, Amazon (2023 drought)
  yukonDelta: [-163.0, 61.0, 10],      // Yukon-Kuskokwim Delta, Alaska
  yukonFlats: [-146.0, 66.5, 10],      // Yukon Flats, Alaska
  marChiquita: [-62.6, -30.7, 9],      // Mar Chiquita, Argentina
};
var site = SITES[SITE];

var multiannual = dataset.filter(ee.Filter.eq('product', 'multiannual')).mosaic();
var annual = dataset.filter(ee.Filter.eq('product', 'annual'))
    .filter(ee.Filter.eq('startYear', YEAR)).mosaic();

var swfVis = {
  bands: ['swf'],
  min: 0,
  max: 100,
  palette: ['ffffff', 'e8e5fa', 'd0ccf5', 'bab3f1', '989be7', '6181d0', '3669ad', '275186'],
};

Map.setCenter(site[0], site[1], site[2]);
Map.addLayer(annual.selfMask(), swfVis, 'Surface water frequency (' + YEAR + ')', false);
Map.addLayer(multiannual.selfMask(), swfVis, 'Surface water frequency (2017-2025)');
