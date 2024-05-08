var imageCollection = ee.ImageCollection(
    'projects/forestdatapartnership/assets/community_palm/20240312');

// View 2020 palm inferences
var palm2020 =
    imageCollection.filterDate(ee.Date('2020-01-01'), ee.Date('2020-12-31'));

Map.addLayer(palm2020, {
  min: 0.0,
  max: 1.0,
  palette: ['#eff3ff', '#bdd7e7', '#6baed6', '#3182bd', '#08519c']
});

Map.setCenter(110, 0);
Map.setZoom(4);