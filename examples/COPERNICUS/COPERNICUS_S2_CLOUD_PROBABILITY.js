var s2Sr = ee.ImageCollection('COPERNICUS/S2_SR');
var s2Clouds = ee.ImageCollection('COPERNICUS/S2_CLOUD_PROBABILITY');

var START_DATE = ee.Date('2019-01-01');
var END_DATE = ee.Date('2019-03-01');
var MAX_CLOUD_PROBABILITY = 65;
var region =
    ee.Geometry.Rectangle({coords: [-76.5, 2.0, -74, 4.0], geodesic: false});
Map.setCenter(-75, 3, 12);

function maskClouds(img) {
  var clouds = ee.Image(img.get('cloud_mask')).select('probability');
  var isNotCloud = clouds.lt(MAX_CLOUD_PROBABILITY);
  return img.updateMask(isNotCloud);
}

// The masks for the 10m bands sometimes do not exclude bad data at
// scene edges, so we apply masks from the 20m and 60m bands as well.
// Example asset that needs this operation:
// COPERNICUS/S2_CLOUD_PROBABILITY/20190301T000239_20190301T000238_T55GDP
function maskEdges(s2_img) {
  return s2_img.updateMask(
      s2_img.select('B8A').mask().updateMask(s2_img.select('B9').mask()));
}

// Filter input collections by desired data range and region.
var criteria = ee.Filter.and(
    ee.Filter.bounds(region), ee.Filter.date(START_DATE, END_DATE));
s2Sr = s2Sr.filter(criteria).map(maskEdges);
s2Clouds = s2Clouds.filter(criteria);

// Join S2 SR with cloud probability dataset to add cloud mask.
var s2SrWithCloudMask = ee.Join.saveFirst('cloud_mask').apply({
  primary: s2Sr,
  secondary: s2Clouds,
  condition:
      ee.Filter.equals({leftField: 'system:index', rightField: 'system:index'})
});

var s2CloudMasked =
    ee.ImageCollection(s2SrWithCloudMask).map(maskClouds).median();
var rgbVis = {min: 0, max: 3000, bands: ['B4', 'B3', 'B2']};

Map.addLayer(
    s2CloudMasked, rgbVis, 'S2 SR masked at ' + MAX_CLOUD_PROBABILITY + '%',
    true);
