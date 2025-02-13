var dataset = ee.ImageCollection('MODIS/061/MOD44B')
                .filter(ee.Filter.date('2000-01-01', '2001-01-01'));

var visualization = {
  bands: ['Percent_Tree_Cover'],
  min: 0,
  max: 100,
  palette: ['bbe029', '0a9501', '074b03']
};

Map.setCenter(6.746, 46.529, 3);

Map.addLayer(dataset, visualization, 'Percent Tree Cover');