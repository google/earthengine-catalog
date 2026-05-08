dataset = ee.ImageCollection('JAXA/ALOS/AW3D30/V3_2')
elevation = dataset.select('DSM')

# Use a projection from one of the image tiles,
# rather than using the default projection returned by .mosaic().
proj = elevation.first().select(0).projection()
slope_reprojected = ee.Terrain.slope(
    elevation.mosaic().setDefaultProjection(proj)
)

elevation_vis = {
    'min': 0,
    'max': 5000,
    'palette': ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff'],
}

m = geemap.Map()
m.set_center(138.73, 35.36, 11)
m.add_layer(elevation, elevation_vis, 'Elevation')
m.add_layer(slope_reprojected, {'min': 0, 'max': 45}, 'Slope')
m
