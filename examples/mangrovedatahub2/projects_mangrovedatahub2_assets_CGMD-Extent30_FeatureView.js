var year = 2023;
var fvLayer = ui.Map.FeatureViewLayer(
  'projects/mangrovedatahub2/assets/CGMD-Extent30_FeatureView'
);
fvLayer.setVisParams({
  rules: [
    {
      filter: ee.Filter.neq('year', year),
      isVisible: false
    }
  ]
});
fvLayer.setName('CGMD mangrove extent ' + year);
Map.setCenter(133.3826, -2.3649, 8);
Map.add(fvLayer);