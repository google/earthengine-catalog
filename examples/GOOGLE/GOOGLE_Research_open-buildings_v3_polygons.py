# Visualization of GOOGLE/Research/open-buildings/v3/polygons.
t = ee.FeatureCollection('GOOGLE/Research/open-buildings/v3/polygons')

t_065_070 = t.filter('confidence >= 0.65 && confidence < 0.7')
t_070_075 = t.filter('confidence >= 0.7 && confidence < 0.75')
t_gte_075 = t.filter('confidence >= 0.75');

m = geemap.Map()
m.set_center(3.389, 6.492, 17)
m.add_layer(t_065_070, {'color': 'FF0000'}, 'Buildings confidence [0.65; 0.7)')
m.add_layer(t_070_075, {'color': 'FFFF00'}, 'Buildings confidence [0.7; 0.75)')
m.add_layer(t_gte_075, {'color': '00FF00'}, 'Buildings confidence >= 0.75')
m
