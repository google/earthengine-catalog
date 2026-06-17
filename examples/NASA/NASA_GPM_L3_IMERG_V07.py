# GPM V7 30 minute data for a single day.
range = ee.Date('2019-09-03').getRange('day')
dataset = ee.ImageCollection('NASA/GPM_L3/IMERG_V07').filter(
    ee.Filter.date(range)
)

# Select the max precipitation and mask out low precipitation values.
precipitation = dataset.select('precipitation').max()
mask = precipitation.gt(0.5)
precipitation = precipitation.updateMask(mask)

palette = [
  '000096','0064ff', '00b4ff', '33db80', '9beb4a',
  'ffeb00', 'ffb300', 'ff6400', 'eb1e00', 'af0000'
]
precipitation_vis = {'min': 0, 'max': 15, 'palette': palette}

m = geemap.Map()
m.add_layer(precipitation, precipitation_vis, 'Precipitation (mm/hr)')
m.set_center(-76, 33, 3)
m
