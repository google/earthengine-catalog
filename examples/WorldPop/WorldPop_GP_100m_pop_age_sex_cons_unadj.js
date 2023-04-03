var dataset = ee.ImageCollection("WorldPop/GP/100m/pop_age_sex_cons_unadj");

var visualization = {
  bands: ['population'],
  min: 0.0,
  max: 50.0,
  palette: ['24126c', '1fff4f', 'd4ff50']
};

Map.setCenter(113.643, 34.769, 7);

Map.addLayer(dataset, visualization, "Population");
