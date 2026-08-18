var fv = ui.Map.FeatureViewLayer(
    'projects/nature-trace/assets/farmscapes/england_v1_0_vectorised_FeatureView');

fv.setVisParams({
  lineWidth: 2,
  color: '808080',
  polygonFillOpacity: 0.25,
  rules: [
    {
      filter: ee.Filter.eq('feature_name', 'hedgerow'),
      color: 'FF00FF',
      polygonFillColor: 'FF00FF'
    },
    {
      filter: ee.Filter.eq('feature_name', 'copse'),
      color: '00FF7F',
      polygonFillColor: '00FF7F'
    },
    {
      filter: ee.Filter.eq('feature_name', 'linear_woodland'),
      color: '2E8B57',
      polygonFillColor: '2E8B57'
    },
    {
      filter: ee.Filter.eq('feature_name', 'stone wall'),
      color: 'D3D3D3',
      polygonFillColor: 'D3D3D3'
    },
    {
      filter: ee.Filter.eq('feature_name', 'woodland'),
      color: '005e5e',
      polygonFillColor: '005e5e'
    }
  ]
});
fv.setName('Farmscapes Vectors');
Map.add(fv);

var legend = ui.Panel({
  style: {
    position: 'top-left',
    padding: '8px 15px',
    backgroundColor: 'rgba(255, 255, 255, 0.9)',
    border: '1px solid black'
  }
});
legend.add(ui.Label({
  value: 'Farmscapes Vectors',
  style:
      {fontWeight: 'bold', fontSize: '16px', margin: '0 0 4px 0', padding: '0'}
}));

var palette = [
  {color: 'FF00FF', name: 'Hedgerow'}, {color: '00FF7F', name: 'Copse'},
  {color: '2E8B57', name: 'Linear Woodland'},
  {color: 'D3D3D3', name: 'Stone Wall'}, {color: '005e5e', name: 'Woodland'},
];

palette.forEach(function(item) {
  var colorBox = ui.Label({
    style:
        {backgroundColor: '#' + item.color, padding: '8px', margin: '0 0 4px 0'}
  });
  var desc = ui.Label({value: item.name, style: {margin: '0 0 4px 6px'}});
  legend.add(ui.Panel(
      {widgets: [colorBox, desc], layout: ui.Panel.Layout.Flow('horizontal')}));
});

Map.add(legend);

var lon = -1.43;
var lat = 52.973;
Map.setCenter(lon, lat, 15);