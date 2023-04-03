var dataset = ee.ImageCollection("WHBU/NBAR_2YEAR");

Map.addLayer(dataset.mean(), {min:0, max:7000});
