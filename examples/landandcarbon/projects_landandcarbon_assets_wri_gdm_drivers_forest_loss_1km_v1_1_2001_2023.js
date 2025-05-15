Map.setCenter(-9.22,20.65,3)

var drivers = ee.Image('projects/landandcarbon/assets/wri_gdm_drivers_forest_loss_1km/v1_1_2001_2023');

var drivers_class = drivers.select(['classification']);

var vis = {
  "min":1, 
  "max": 7,
  "palette": ['E39D29','E58074','e9d700','51a44e','895128','a354a0','3a209a']
};

Map.addLayer(drivers_class, vis, 'Drivers of Forest Loss, 2001-2023');

var permAg_prob = drivers.select(['probability_1']); //Select a probability band

var probVis = {
  min: 0,
  max: 250,
  palette: ['#440154','#481567','#482677','#453781','#3b528b','#2c728e','#21908d','#27ad81','#5ec962','#aadc32','#fde725']
};

Map.addLayer(permAg_prob, probVis, 'Probability band for permanent agriculture', false); 