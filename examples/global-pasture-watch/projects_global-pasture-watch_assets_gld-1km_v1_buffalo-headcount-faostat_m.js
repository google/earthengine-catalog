Map.setCenter(-55.50, -12.20, 4);

var buffaloVis = {
  min: 0,
  max: 160,
  palette: [
    'ffffcc',
    'c2e699',
    '78c679',
    '31a354',
    '006837'
  ]
};

var buffalo = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/buffalo-headcount-faostat_m"
);

var buffalo2024 = buffalo.filterDate('2024-01-01', '2025-01-01').first();

Map.addLayer(buffalo2024, buffaloVis, 'Cattle headcount (2024)');
