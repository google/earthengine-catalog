var dataset = ee.ImageCollection('CANADA/NFIS/NTEMS/CA_FOREST_AGE');

Map.setCenter(-107.94, 58.18, 3);
Map.addLayer(
    dataset,
    {palette: ['006600', '002200', 'fff700', 'ab7634', 'c4d0ff', 'ffffff']},
    'Canada Primary Forest Data');