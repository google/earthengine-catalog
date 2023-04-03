var dataset = ee.ImageCollection('MODIS/006/MCD12Q1');
var igbpLandCover = dataset.select('LC_Type1');
var igbpLandCoverVis = {
  min: 1.0,
  max: 17.0,
  palette: [
    '05450a', '086a10', '54a708', '78d203', '009900', 'c6b044', 'dcd159',
    'dade48', 'fbff13', 'b6ff05', '27ff87', 'c24f44', 'a5a5a5', 'ff6d4c',
    '69fff8', 'f9ffa4', '1c0dff'
  ],
};
Map.setCenter(6.746, 46.529, 6);
Map.addLayer(igbpLandCover, igbpLandCoverVis, 'IGBP Land Cover');