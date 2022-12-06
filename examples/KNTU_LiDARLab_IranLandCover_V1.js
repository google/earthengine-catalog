var dataset = ee.Image("KNTU/LiDARLab/IranLandCover/V1");

var visualization = {
  bands: ['classification']
};

Map.setCenter(54.0, 33.0, 5);

Map.addLayer(dataset, visualization, "Classification");
