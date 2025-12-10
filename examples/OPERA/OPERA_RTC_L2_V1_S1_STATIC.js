var geometry = ee.Geometry.BBox(-18, 49, 8, 60);
var waterLandMask =
    ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').gte(0.0).clip(geometry);

var rtc_s1_static = ee.ImageCollection('OPERA/RTC/L2_V1/S1_STATIC')
                        .filterBounds(geometry)
                        .mean()
                        .mask(waterLandMask);

Map.centerObject(geometry);
Map.addLayer(
    rtc_s1_static.select('number_of_looks'),
    {min: 15, max: 19, palette: ['yellow', 'red']}, 'Number of Looks');