// Visualize FireCCI51 for one year
var dataset = ee.ImageCollection('ESA/CCI/FireCCI/5_1')
                  .filterDate('2020-01-01', '2020-12-31');
var burnedArea = dataset.select('BurnDate');

// Use a circular palette to assign colors to date of first detection
var baVis = {
  min: 1,
  max: 366,
  palette: [
    'ff0000', 'fd4100', 'fb8200', 'f9c400', 'f2ff00', 'b6ff05',
    '7aff0a', '3eff0f', '02ff15', '00ff55', '00ff99', '00ffdd',
    '00ddff', '0098ff', '0052ff', '0210ff', '3a0dfb', '7209f6',
    'a905f1', 'e102ed', 'ff00cc', 'ff0089', 'ff0047', 'ff0004'
  ]
};
var maxBA = burnedArea.max();

Map.setCenter(0, 18, 2.1);
Map.addLayer(maxBA, baVis, 'Burned Area');
