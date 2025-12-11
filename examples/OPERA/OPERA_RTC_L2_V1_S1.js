var geometry = ee.Geometry.BBox(-18, 49, 8, 60);
var waterLandMask =
    ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gte(0.0).clip(geometry);

var rtc_s1 = ee.ImageCollection('OPERA/RTC/L2_V1/S1')
                 .filterDate('2025-10-25', '2025-11-01')
                 .filterBounds(geometry)
                 .mean()
                 .mask(waterLandMask);

Map.centerObject(geometry);
Map.addLayer(rtc_s1.select('VV'), {min: 0, max: 0.5}, 'VV');
