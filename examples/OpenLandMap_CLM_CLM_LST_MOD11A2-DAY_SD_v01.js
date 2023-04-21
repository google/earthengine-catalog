var dataset = ee.Image("OpenLandMap/CLM/CLM_LST_MOD11A2-DAY_SD/v01");

var visualization = {
  bands: ['jan'],
  min: 25.0,
  max: 390.0,
  palette: [
    "2828ff","2828ff","6666ff","8989ff","a1a1ff","b2b2ff",
    "c0c0ff","cbcbff","d5d5ff","dedeff","e6e6ff","ededff",
    "f5f5ff","ffffff","fcfcff","fffbfb","fff4f4","ffeded",
    "ffe5e5","ffdddd","ffd4d4","ffcbcb","ffbfbf","ffb2b2",
    "ffa1a1","ff8a8a","ff6767","ff2929",
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, "Long-term Land Surface Temperature daytime monthly sd");