Map.setCenter(0, 0, 3);

var palette = ["d7d7d7","ffffd4","fed98e","fe9929","d95f0e","993404"]
var vis160 = {min: 0, max: 160, palette: palette};
var vis10 = {min: 0, max: 10, palette: palette};

var gld = ee.ImageCollection(
  "projects/global-pasture-watch/assets/gld-1km/v1/livestock-headcount-faostat_m"
)

var gld_2000 = gld.filterDate('2000-01-01', '2001-01-01').first();
var gld_2022 = gld.filterDate('2022-01-01', '2023-01-01').first();

Map.addLayer(gld_2000.select('buffalo'), vis160, 'Buffalo headcount (2000)', false);
Map.addLayer(gld_2022.select('buffalo'), vis160, 'Buffalo headcount (2022)');

Map.addLayer(gld_2000.select('horse'), vis10, 'Horse headcount (2000)', false);
Map.addLayer(gld_2022.select('horse'), vis10, 'Horse headcount (2022)');

Map.addLayer(gld_2000.select('goat'), vis160, 'Goat headcount (2000)', false);
Map.addLayer(gld_2022.select('goat'), vis160, 'Goat headcount (2022)');

Map.addLayer(gld_2000.select('sheep'), vis160, 'Sheep headcount (2000)', false);
Map.addLayer(gld_2022.select('sheep'), vis160, 'Sheep headcount (2022)');

Map.addLayer(gld_2000.select('cattle'), vis160, 'Cattle headcount (2000)', false);
Map.addLayer(gld_2022.select('cattle'), vis160, 'Cattle headcount (2022)');