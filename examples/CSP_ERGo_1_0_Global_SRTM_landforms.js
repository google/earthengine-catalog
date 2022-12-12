var dataset = ee.Image('CSP/ERGo/1_0/Global/SRTM_landforms');
var landforms = dataset.select('constant');
var landformsVis = {
  min: 11.0,
  max: 42.0,
  palette: [
    '141414', '383838', '808080', 'EBEB8F', 'F7D311', 'AA0000', 'D89382',
    'DDC9C9', 'DCCDCE', '1C6330', '68AA63', 'B5C98E', 'E1F0E5', 'a975ba',
    '6f198c'
  ],
};
Map.setCenter(-105.58, 40.5498, 11);
Map.addLayer(landforms, landformsVis, 'Landforms');
