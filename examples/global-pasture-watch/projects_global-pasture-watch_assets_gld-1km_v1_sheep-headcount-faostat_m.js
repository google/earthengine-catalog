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

var sheep = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/sheep-headcount-faostat_m"
);

var sheep2000 = sheep.filterDate('2000-01-01', '2001-01-01').first();
var sheep2022 = sheep.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(sheep2000, vis, 'Sheep headcount (2000)');
Map.addLayer(sheep2022, vis, 'Sheep headcount (2022)');
