// Request access to this data by filling out the form at: https://forms.gle/jqw4Mvr63dsV1fUF8
var fvLayer = ui.Map.FeatureViewLayer('FeatureViews/projects_edf-methanesat-ee_assets_public-preview_L4point_FeatureView');

var visParams = {
  color: 'red',
  fillColor: 'red',
  opacity: 1,
  pointSize: 5
};

fvLayer.setVisParams(visParams);
fvLayer.setName('Feature view of methane point sources flux in kg/h');

Map.setCenter(-43.03, 37.48, 3);
Map.add(fvLayer);
