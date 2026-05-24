var year = 2023;

var fvLayer = ui.Map.FeatureViewLayer(
  'projects/mangrovedatahub2/assets/CGMD-Extent30_FeatureView'
);

fvLayer.setVisParams({
  color: '228B22',
  fillColor: '228B2240',
  width: 1,
  filter: ee.Filter.eq('year', year)
});

fvLayer.setName('CGMD mangrove extent ' + year);

Map.setCenter(133.3826, -2.3649, 8);
Map.add(fvLayer);