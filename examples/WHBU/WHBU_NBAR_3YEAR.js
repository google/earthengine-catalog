var dataset = ee.ImageCollection("WHBU/NBAR_3YEAR");

Map.addLayer(dataset.mean(), {min:0, max:7000});
