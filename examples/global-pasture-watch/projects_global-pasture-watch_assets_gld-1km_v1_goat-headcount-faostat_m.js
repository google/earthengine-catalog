Map.setCenter(0, 0, 4);

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

var goat = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/goat-headcount-faostat_m"
);

var goat2000 = goat.filterDate('2000-01-01', '2001-01-01').first();
var goat2022 = goat.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(goat2000, vis, 'Goat headcount (2000)');
Map.addLayer(goat2022, vis, 'Goat headcount (2022)');
