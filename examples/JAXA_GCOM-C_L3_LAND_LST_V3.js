var dataset = ee.ImageCollection("JAXA/GCOM-C/L3/LAND/LST/V3")
                .filterDate('2021-12-01', '2022-01-01')
                // filter to daytime data only
                .filter(ee.Filter.eq("SATELLITE_DIRECTION", "D"));

// Multiply with slope coefficient
var dataset = dataset.mean().multiply(0.02);

var visualization = {
  bands: ['LST_AVE'],
  min: 250,
  max: 316,
  palette: [
    "040274","040281","0502a3","0502b8","0502ce","0502e6",
    "0602ff","235cb1","307ef3","269db1","30c8e2","32d3ef",
    "3be285","3ff38f","86e26f","3ae237","b5e22e","d6e21f",
    "fff705","ffd611","ffb613","ff8b13","ff6e08","ff500d",
    "ff0000","de0101","c21301","a71001","911003",
  ]
};

Map.setCenter(128.45, 33.33, 5);

Map.addLayer(dataset, visualization, "Land Surface Temperature");
