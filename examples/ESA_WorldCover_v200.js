var dataset = ee.ImageCollection('ESA/WorldCover/v200').first();

var visualization = {
  bands: ['Map'],
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Landcover");
