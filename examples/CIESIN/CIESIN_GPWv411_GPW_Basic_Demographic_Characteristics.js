var dataset = ee.ImageCollection("CIESIN/GPWv411/GPW_Basic_Demographic_Characteristics").first();
var raster = dataset.select('basic_demographic_characteristics');
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
Map.addLayer(raster, raster_vis, 'basic_demographic_characteristics');

