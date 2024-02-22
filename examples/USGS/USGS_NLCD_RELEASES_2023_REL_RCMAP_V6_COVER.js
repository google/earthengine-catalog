// Import the NLCD RCMAP collection.
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2023_REL/RCMAP/V6/COVER');

// Filter the collection to the 2021 product.
var nlcd2021 = dataset.filter(ee.Filter.eq('system:index', '2021')).first();

// Each product has multiple bands for different rangeland categories.
print('Bands:', nlcd2021.bandNames());

// Select the rangeland_annual_herbaceous band.
var percentCover = nlcd2021.select('rangeland_annual_herbaceous');

var vis = {
  // Map 0..100.
  'palette': [
    '000000', 'f9e8b7', 'f7e3ac', 'f0dfa3', 'eedf9c', 'eada91', 'e8d687',
    'e0d281', 'ddd077', 'd6cc6d', 'd3c667', 'd0c55e', 'cfc555', 'c6bd4f',
    'c4ba46', 'bdb83a', 'bbb534', 'b7b02c', 'b0ad1f', 'adac17', 'aaaa0a',
    'a3a700', '9fa700', '9aa700', '92a700', '8fa700', '87a700', '85a700',
    '82aa00', '7aaa00', '77aa00', '70aa00', '6caa00', '67aa00', '5fa700',
    '57a700', '52a700', '4fa700', '4aa700', '42a700', '3ca700', '37a700',
    '37a300', '36a000', '369f00', '349d00', '339900', '339900', '2f9200',
    '2d9100', '2d8f00', '2c8a00', '2c8800', '2c8500', '2c8400', '2b8200',
    '297d00', '297a00', '297900', '277700', '247400', '247000', '29700f',
    '2c6d1c', '2d6d24', '336d2d', '366c39', '376c44', '396a4a', '396a55',
    '3a6a5f', '3a696a', '396774', '3a6782', '39668a', '376292', '34629f',
    '2f62ac', '2c5fb7', '245ec4', '1e5ed0', '115cdd', '005ae0', '0057dd',
    '0152d6', '0151d0', '014fcc', '014ac4', '0147bd', '0144b8', '0142b0',
    '0141ac', '013da7', '013aa0', '01399d', '013693', '013491', '012f8a',
    '012d85', '012c82', '01297a'
  ]
};

// Display the image on the map.
Map.setCenter(-114, 38, 6);
Map.addLayer(percentCover, vis, 'Rangeland Annual Herbaceous %');
