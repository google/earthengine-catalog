Map.setCenter(-55.50, -12.20, 4);

var sheepVis = {
  min: 0,
  max: 500,
  palette: [
    'ffffcc',
    'c2e699',
    '78c679',
    '31a354',
    '006837'
  ]
};

var sheep = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/sheep-headcount-faostat_m"
);

var sheep2024 = sheep.filterDate('2024-01-01', '2025-01-01').first();

Map.addLayer(sheep2024, sheepVis, 'Cattle headcount (2024)');
