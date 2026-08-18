// To access this dataset, fill out the form: https://forms.gle/jQmCbWgarjENQBYz6

// SINGLE IMAGE VIEW
// Load the multispectral collection.
var msCol = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS/V1');

// Filter for a specific satellite and region and get a sample image.
var image = msCol.filter(ee.Filter.eq('satellite', 'SPOT5'))
  .filterBounds(ee.Geometry.Point([-51.5, -16.5])).first();

// Define visualization (false color: NIR, Red, Green).
var visParams = {
  bands: ['N', 'R', 'G'],
  min: 20,
  max: 200
};

Map.centerObject(image, 11);
Map.addLayer(image, visParams, 'SPOT 5 Original');


// APPLYING A CLOUD MASK
// Load the companion MS_NC collection which includes a cloud mask band.
var maskCol = ee.ImageCollection('AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS_NC/V1');

// Merge the mask band into the MS collection.
var msWithMaskCol = msCol.linkCollection(maskCol, ['cloud_mask']);

// Function to apply the mask and remove the mask band from the output
var maskClouds = function(img) {
  var mask = img.select('cloud_mask');

  // Identify bands to keep (everything except the cloud_mask itself).
  var bandsToKeep = img.bandNames().removeAll(['cloud_mask']);

  return img.updateMask(mask).select(bandsToKeep);
};

// Map the function over the collection.
var maskedCol = msWithMaskCol.map(maskClouds);

// Get the same image but with the cloud mask applied.
var maskedImage = maskedCol.filter(
  ee.Filter.eq('system:index', image.id())).first();
Map.addLayer(maskedImage, visParams, 'SPOT 5 Cloud Masked');
