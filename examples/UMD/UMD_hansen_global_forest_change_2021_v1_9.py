dataset = ee.Image('UMD/hansen/global_forest_change_2021_v1_9')

tree_cover_vis_param = {
    'bands': ['treecover2000'],
    'min': 0,
    'max': 100,
    'palette': ['black', 'green'],
}

tree_loss_vis_param = {
    'bands': ['lossyear'],
    'min': 0,
    'max': 21,
    'palette': ['yellow', 'red'],
}

m = geemap.Map()
m.add_layer(dataset, tree_cover_vis_param, 'tree cover')
m.add_layer(dataset, tree_loss_vis_param, 'tree loss year')
m
