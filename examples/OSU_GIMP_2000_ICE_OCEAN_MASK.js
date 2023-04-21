var dataset = ee.Image('OSU/GIMP/2000_ICE_OCEAN_MASK');
var oceanAndIceMaskVis = {
  min: 0.0,
  max: 1.0,
  bands: ['ice_mask', 'ice_mask', 'ocean_mask'],
};
Map.setCenter(-41.0, 74.0, 4);
Map.addLayer(dataset, oceanAndIceMaskVis, 'Ocean and Ice Mask');
