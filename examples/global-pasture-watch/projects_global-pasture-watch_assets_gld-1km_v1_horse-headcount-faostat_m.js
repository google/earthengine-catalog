Map.setCenter(-55.50, -12.20, 4);

var horseVis = {
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

var horse = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/horse-headcount-faostat_m"
);

var horse2024 = horse.filterDate('2024-01-01', '2025-01-01').first();

Map.addLayer(horse2024, horseVis, 'Cattle headcount (2024)');
