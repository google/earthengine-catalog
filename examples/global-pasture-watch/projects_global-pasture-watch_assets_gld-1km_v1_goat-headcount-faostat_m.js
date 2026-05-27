Map.setCenter(-55.50, -12.20, 4);

var goatVis = {
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

var goat = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/goat-headcount-faostat_m"
);

var goat2024 = goat.filterDate('2024-01-01', '2025-01-01').first();

Map.addLayer(goat2024, goatVis, 'Cattle headcount (2024)');
