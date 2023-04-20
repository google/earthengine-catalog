var dataset = ee.Image("OpenLandMap/PNV/PNV_BIOME-TYPE_BIOME00K_C/v01");

var visualization = {
  bands: ['biome_type'],
  min: 1.0,
  max: 32.0,
  palette: [
    "1c5510","659208","ae7d20","000065","bbcb35","009a18",
    "caffca","55eb49","65b2ff","0020ca","8ea228","ff9adf",
    "baff35","ffba9a","ffba35","f7ffca","e7e718","798649",
    "65ff9a","d29e96",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Potential distribution of biomes");