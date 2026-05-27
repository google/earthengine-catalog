Map.setCenter(-55.50, -12.20, 4);

var cattleVis = {
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

var cattle = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/cattle-headcount-faostat_m"
);

var cattle2024 = cattle.filterDate('2024-01-01', '2025-01-01').first();

Map.addLayer(cattle2024, cattleVis, 'Cattle headcount (2024)');
