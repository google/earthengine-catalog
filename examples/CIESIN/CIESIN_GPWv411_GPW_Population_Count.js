var dataset = ee.ImageCollection("CIESIN/GPWv411/GPW_Population_Count").first();
var raster = dataset.select('population_count');
var raster_vis = {
  "max": 1000.0,
  "palette": [
    "ffffe7",
    "86a192",
    "509791",
    "307296",
    "2c4484",
    "000066"
  ],
  "min": 0.0
};
Map.setCenter(79.1, 19.81, 3);
Map.addLayer(raster, raster_vis, 'population_count');

