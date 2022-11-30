var dataset = ee.ImageCollection("CIESIN/GPWv411/GPW_Population_Density").first();
var raster = dataset.select('population_density');
var raster_vis = {
  "max": 1000.0,
  "palette": [
    "ffffe7",
    "FFc869",
    "ffac1d",
    "e17735",
    "f2552c",
    "9f0c21"
  ],
  "min": 200.0
};
Map.setCenter(79.1, 19.81, 3);
Map.addLayer(raster, raster_vis, 'population_density');

