var dataset = ee.Image('CSP/ERGo/1_0/Global/SRTM_landforms');
var landforms = dataset.select('constant');
var landformsVis = {
  min: 11.0,
  max: 42.0,
  palette: [
    '141414', '383838', '808080', 'ebeb8f', 'f7d311', 'aa0000', 'd89382',
    'ddc9c9', 'dccdce', '1c6330', '68aa63', 'b5c98e', 'e1f0e5', 'a975ba',
    '6f198c'
  ],
};
Map.setCenter(-105.58, 40.5498, 11);
Map.addLayer(landforms, landformsVis, 'Landforms');
