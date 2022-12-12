var dataset = ee.ImageCollection("ESA/WorldCover/v100").first();

var visualization = {
  bands: ['Map'],
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Landcover");
