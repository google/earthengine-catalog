var dataset = ee.ImageCollection("NASA/ORNL/biomass_carbon_density/v1");

var visualization = {
  bands: ['agb'],
  min: -50.0,
  max: 80.0,
  palette: ['d9f0a3', 'addd8e', '78c679', '41ab5d', '238443', '005a32']
};

Map.setCenter(-60.0, 7.0, 4);

Map.addLayer(dataset, visualization, "Aboveground biomass carbon");