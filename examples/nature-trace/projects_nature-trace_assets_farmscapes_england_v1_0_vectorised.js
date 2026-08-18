var fc = ee.FeatureCollection('projects/nature-trace/assets/farmscapes/england_v1_0_vectorised');

var styles = {
  'hedgerow': {color: 'FF00FF', fillColor: '40FF00FF'},
  'copse': {color: '00FF7F', fillColor: '4000FF7F'},
  'linear_woodland': {color: '2E8B57', fillColor: '402E8B57'},
  'stone wall': {color: 'D3D3D3', fillColor: '40D3D3D3'},
  'woodland': {color: '005e5e', fillColor: '40005e5e'},
};

var styleDict = ee.Dictionary(styles);

var styledFc = fc.map(function(f) {
  var featureStyle = ee.Dictionary(styleDict.get(f.get('feature_name')));
  return f.set('style', featureStyle);
});

var styledImage = styledFc.style({
  styleProperty: 'style', width: 2
});

Map.addLayer(styledImage, {}, 'Farmscapes Vectors');

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
  style: {fontWeight: 'bold', fontSize: '16px', margin: '0 0 4px 0', padding: '0'}
}));

var palette = [
  {color: 'FF00FF', name: 'Hedgerow'},
  {color: '00FF7F', name: 'Copse'},
  {color: '2E8B57', name: 'Linear Woodland'},
  {color: 'D3D3D3', name: 'Stone Wall'},
  {color: '005e5e', name: 'Woodland'},
];

palette.forEach(function(item) {
  var colorBox = ui.Label({
    style: {backgroundColor: '#' + item.color, padding: '8px', margin: '0 0 4px 0'}
  });
  var desc = ui.Label({value: item.name, style: {margin: '0 0 4px 6px'}});
  legend.add(ui.Panel({
    widgets: [colorBox, desc],
    layout: ui.Panel.Layout.Flow('horizontal')
  }));
});

Map.add(legend);

var lon = -1.43;
var lat = 52.973;
Map.setCenter(lon, lat, 15);