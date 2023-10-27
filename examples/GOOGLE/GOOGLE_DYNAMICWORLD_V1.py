# Construct a collection of corresponding Dynamic World and Sentinel-2 for
# inspection. Filter the DW and S2 collections by region and date.
START = ee.Date('2021-04-02')
END = START.advance(1, 'day')

col_filter = ee.Filter.And(
    ee.Filter.bounds(ee.Geometry.Point(20.6729, 52.4305)),
    ee.Filter.date(START, END),
)

dw_col = ee.ImageCollection('GOOGLE/DYNAMICWORLD/V1').filter(col_filter)
s2_col = ee.ImageCollection('COPERNICUS/S2').filter(col_filter)

# Join corresponding DW and S2 images (by system:index).
dw_s2_col = ee.Join.saveFirst('s2_img').apply(
    dw_col,
    s2_col,
    ee.Filter.equals(leftField='system:index', rightField='system:index'),
)

# Extract an example DW image and its source S2 image.
dw_image = ee.Image(dw_s2_col.first())
s2_image = ee.Image(dw_image.get('s2_img'))

# Create a visualization that blends DW class label with probability.
# Define list pairs of DW LULC label and color.
CLASS_NAMES = [
    'water',
    'trees',
    'grass',
    'flooded_vegetation',
    'crops',
    'shrub_and_scrub',
    'built',
    'bare',
    'snow_and_ice',
]

VIS_PALETTE = [
    '419bdf',
    '397d49',
    '88b053',
    '7a87c6',
    'e49635',
    'dfc35a',
    'c4281b',
    'a59b8f',
    'b39fe1',
]

# Create an RGB image of the label (most likely class) on [0, 1].
dw_rgb = (
    dw_image.select('label')
    .visualize(min=0, max=8, palette=VIS_PALETTE)
    .divide(255)
)

# Get the most likely class probability.
top1_prob = dw_image.select(CLASS_NAMES).reduce(ee.Reducer.max())

# Create a hillshade of the most likely class probability on [0, 1]
top1_prob_hillshade = ee.Terrain.hillshade(top1_prob.multiply(100)).divide(255)

# Combine the RGB image with the hillshade.
dw_rgb_hillshade = dw_rgb.multiply(top1_prob_hillshade)

# Display the Dynamic World visualization with the source Sentinel-2 image.
m = geemap.Map()
m.set_center(20.6729, 52.4305, 12)
m.add_layer(
    s2_image,
    {'min': 0, 'max': 3000, 'bands': ['B4', 'B3', 'B2']},
    'Sentinel-2 L1C',
)
m.add_layer(
    dw_rgb_hillshade,
    {'min': 0, 'max': 0.65},
    'Dynamic World V1 - label hillshade',
)
m
