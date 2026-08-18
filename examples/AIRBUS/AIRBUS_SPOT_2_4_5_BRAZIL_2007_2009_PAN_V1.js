// To access this dataset, fill out the form: https://forms.gle/jQmCbWgarjENQBYz6

var collection = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PAN/V1');

var image = collection.first();
Map.centerObject(image, 13);
Map.addLayer(image, {min: 0, max: 200}, 'Panchromatic');
