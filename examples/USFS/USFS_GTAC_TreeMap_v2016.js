var dataset = ee.ImageCollection('USFS/GTAC/TreeMap/v2016');

var tm2016 = dataset.filterDate('2016', '2017').first();

Map.addLayer(tm2016.select('ALSTK'), {}, 'All-Live-Tree Stocking (percent)');
Map.addLayer(tm2016.select('FLDTYPCD'), {}, 'Field Forest Type Code');

Map.setCenter(-95.712891, 38, 5);