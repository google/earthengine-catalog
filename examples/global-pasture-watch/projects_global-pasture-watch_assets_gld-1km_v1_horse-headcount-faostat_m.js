Map.setCenter(-55.50, -12.20, 4);

var vis = {
  min: 0, 
  max: 10, 
  palette: [
    "d7d7d7",
    "ffffd4",
    "fed98e",
    "fe9929",
    "d95f0e",
    "993404"
  ]
};

var horse = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/horse-headcount-faostat_m"
);

var horse2000 = horse.filterDate('2000-01-01', '2001-01-01').first();
var horse2022 = horse.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(horse2000, vis, 'Horse headcount (2000)');
Map.addLayer(horse2022, vis, 'Horse headcount (2022)');

