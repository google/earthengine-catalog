var csPlus = ee.ImageCollection('GOOGLE/CLOUD_SCORE_PLUS/V1/S2_HARMONIZED');

var point = ee.Geometry.Point(82.35459, 29.93228);

var csPlusFilt =
    csPlus.filterDate('2023-01-01', '2023-07-01').filterBounds(point);

var clearThreshold = 0.6;
var vizParams = {min: 0.5, max: 1, palette: ['ffffff', '7f5F00', '000000']};

var clearObsFraction = csPlusFilt.select('cs_cdf')
                           .map(function(image) {
                             return image.gte(clearThreshold);
                           })
                           .mean();

Map.addLayer(clearObsFraction, vizParams, 'fraction clear');