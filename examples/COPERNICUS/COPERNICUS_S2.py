def mask_s2_clouds(image):
  """Masks clouds using the Sentinel-2 QA band.

  Args:
      image (ee.Image): Sentinel-2 image.

  Returns:
      ee.Image: Cloud masked Sentinel-2 image.
  """
  qa = image.select('QA60')

  # Bits 10 and 11 are clouds and cirrus, respectively.
  cloud_bit_mask = 1 << 10
  cirrus_bit_mask = 1 << 11

  # Both flags should be set to zero, indicating clear conditions.
  mask = (
      qa.bitwiseAnd(cloud_bit_mask)
      .eq(0)
      .And(qa.bitwiseAnd(cirrus_bit_mask).eq(0))
  )

  return image.updateMask(mask).divide(10000)


# Load Sentinel-2 TOA reflectance data.
dataset = (
    ee.ImageCollection('COPERNICUS/S2')
    .filterDate('2018-01-01', '2018-01-31')
    # Pre-filter to get less cloudy granules.
    .filter(ee.Filter.lt('CLOUDY_PIXEL_PERCENTAGE', 20))
    .map(mask_s2_clouds)
)

rgb_vis = {'min': 0.0, 'max': 0.3, 'bands': ['B4', 'B3', 'B2']}

# Create and display the map.
m = geemap.Map()
m.set_center(-9.1695, 38.6917, 12)
m.add_layer(dataset.median(), rgb_vis, 'RGB')
m
