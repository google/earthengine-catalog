var csPlus = ee.ImageCollection('GOOGLE/CLOUD_SCORE_PLUS/V1/S2_HARMONIZED');

var point = ee.Geometry.Point(148.0365, -9.5473);
Map.centerObject(point, 9);

// Filter CS+ collection by desired data range and region.
var csPlusFilt =
    csPlus.filterDate('2023-01-01', '2023-07-01').filterBounds(point);

// Specify CS+ QA band to use for masking. Options are 'cs' and 'cs_cdf'.
var qaBand = 'cs_cdf';

// Adjustable threshold for converting CS+ QA to a binary mask.
// Higher thresholds will mask out partial occlusions like thin clouds, haze &
// cirrus shadows. Lower thresholds will be more permissive of these occlusions.
var clearThreshold = 0.6;

var vizParams = {min: 0.5, max: 1, palette: ['ffffff', '000080', '000000']};

// Compute the fraction of total observations that are above the specified
// clearThreshold.
var clearObsFraction = csPlusFilt.select(qaBand)
                           .map(function(image) {
                             return image.gte(clearThreshold);
                           })
                           .mean();

Map.addLayer(clearObsFraction, vizParams, 'fraction clear');