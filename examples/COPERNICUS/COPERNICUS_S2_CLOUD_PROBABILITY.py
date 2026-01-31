s2_sr = ee.ImageCollection('COPERNICUS/S2_SR_HARMONIZED')
s2_clouds = ee.ImageCollection('COPERNICUS/S2_CLOUD_PROBABILITY')

start_date = ee.Date('2019-01-01')
end_date = ee.Date('2019-03-01')
max_cloud_probability = 65
region = ee.Geometry.Rectangle(
    coords=[-76.5, 2.0, -74, 4.0], geodesic=False, proj='EPSG:4326'
)


def maskClouds(img):
  clouds = ee.Image(img.get('cloud_mask')).select('probability')
  is_not_cloud = clouds.lt(max_cloud_probability)
  return img.updateMask(is_not_cloud)


# The masks for the 10m bands sometimes do not exclude bad data at
# scene edges, so we apply masks from the 20m and 60m bands as well.
# Example asset that needs this operation:
# COPERNICUS/S2_CLOUD_PROBABILITY/20190301T000239_20190301T000238_T55GDP
def maskEdges(s2_img):
  return s2_img.updateMask(
      s2_img.select('B8A').mask().updateMask(s2_img.select('B9').mask())
  )


# Filter input collections by desired data range and region.
criteria = ee.Filter.And(
    ee.Filter.bounds(region), ee.Filter.date(start_date, end_date)
)
s2_sr = s2_sr.filter(criteria).map(maskEdges)
s2_clouds = s2_clouds.filter(criteria)

# Join S2 SR with cloud probability dataset to add cloud mask.
s2_sr_with_cloud_mask = ee.Join.saveFirst('cloud_mask').apply(
    primary=s2_sr,
    secondary=s2_clouds,
    condition=ee.Filter.equals(
        leftField='system:index', rightField='system:index'
    ),
)

s_2_cloud_masked = (
    ee.ImageCollection(s2_sr_with_cloud_mask).map(maskClouds).median()
)

rgb_vis = {'min': 0, 'max': 3000, 'bands': ['B4', 'B3', 'B2']}

m = geemap.Map()
m.set_center(-75, 3, 12)
m.add_layer(
    s_2_cloud_masked,
    rgb_vis,
    'S2 SR masked at ' + str(max_cloud_probability) + '%',
    True,
)
m
