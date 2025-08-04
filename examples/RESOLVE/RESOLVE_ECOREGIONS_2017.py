eco_regions = ee.FeatureCollection('RESOLVE/ECOREGIONS/2017')

# patch updated colors
color_updates = [
    {'ECO_ID': 204, 'COLOR': '#B3493B'},
    {'ECO_ID': 245, 'COLOR': '#267400'},
    {'ECO_ID': 259, 'COLOR': '#004600'},
    {'ECO_ID': 286, 'COLOR': '#82F178'},
    {'ECO_ID': 316, 'COLOR': '#E600AA'},
    {'ECO_ID': 453, 'COLOR': '#5AA500'},
    {'ECO_ID': 317, 'COLOR': '#FDA87F'},
    {'ECO_ID': 763, 'COLOR': '#A93800'},
]

# loop over all other features and create a new style property for styling
# later on
eco_regions = eco_regions.map(
    lambda f: f.set({'style': {'color': f.get('COLOR'), 'width': 0}})
)

# make styled features for the regions we need to update colors for,
# then strip them from the main asset and merge in the new feature
for i in range(len(color_updates)):
  color_updates[i]['layer'] = eco_regions.filterMetadata(
      'ECO_ID', 'equals', color_updates[i]['ECO_ID']
  ).map(
      lambda f: f.set(
          {'style': {'color': color_updates[i]['COLOR'], 'width': 0}}
      )
  )

  eco_regions = eco_regions.filterMetadata(
      'ECO_ID', 'not_equals', color_updates[i]['ECO_ID']
  ).merge(color_updates[i]['layer'])

# use style property to color shapes
image_rgb = eco_regions.style(styleProperty='style')

m = geemap.Map()
m.set_center(16, 49, 4)
m.add_layer(image_rgb, {}, 'RESOLVE/ECOREGIONS/2017')
m
