var nicfi = ee.ImageCollection('projects/planet-nicfi/assets/basemaps/americas');

// Filter basemaps by date and get the first image from filtered results
var basemap= nicfi.filter(ee.Filter.date('2021-03-01','2021-07-01')).first();

Map.centerObject(basemap, 4)

var vis = {"bands":["R","G","B"],"min":64,"max":5454,"gamma":1.8};

Map.addLayer(basemap, vis, '2021-03 mosaic');
Map.addLayer(
    basemap.normalizedDifference(['N','R']).rename('NDVI'),
    {min:-0.55,max:0.8,palette: [
        '8bc4f9', 'c9995c', 'c7d270','8add60','097210'
    ]}, 'NDVI', false);
