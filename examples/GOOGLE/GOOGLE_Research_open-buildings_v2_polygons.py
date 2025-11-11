# Visualization of GOOGLE/Research/open-buildings/v2/polygons.
t = ee.FeatureCollection('GOOGLE/Research/open-buildings/v2/polygons')

t_060_065 = t.filter('confidence >= 0.60 && confidence < 0.65')
t_065_070 = t.filter('confidence >= 0.65 && confidence < 0.70')
t_gte_070 = t.filter('confidence >= 0.70');

m = geemap.Map()
m.set_center(3.389, 6.492, 17)
m.add_layer(t_060_065, {'color': 'FF0000'}, 'Buildings confidence [0.60; 0.65)')
m.add_layer(t_065_070, {'color': 'FFFF00'}, 'Buildings confidence [0.65; 0.70)')
m.add_layer(t_gte_070, {'color': '00FF00'}, 'Buildings confidence >= 0.70')
m
