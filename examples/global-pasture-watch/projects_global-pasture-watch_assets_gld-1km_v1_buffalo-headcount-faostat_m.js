Map.setCenter(75, 25, 4);

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

var buffalo = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/buffalo-headcount-faostat_m"
);

var buffalo2000 = buffalo.filterDate('2000-01-01', '2001-01-01').first();
var buffalo2022 = buffalo.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(buffalo2000, vis, 'Buffalo headcount (2000)');
Map.addLayer(buffalo2022, vis, 'Buffalo headcount (2022)');
