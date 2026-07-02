Map.setCenter(-55.50, -12.20, 4);

var vis = {
  min: 0, 
  max: 160, 
  palette: [
    "d7d7d7",
    "ffffd4",
    "fed98e",
    "fe9929",
    "d95f0e",
    "993404"
  ]
};

var cattle = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/cattle-headcount-faostat_m"
);

var cattle2000 = cattle.filterDate('2000-01-01', '2001-01-01').first();
var cattle2022 = cattle.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(cattle2000, vis, 'Cattle headcount (2000)');
Map.addLayer(cattle2022, vis, 'Cattle headcount (2022)');
