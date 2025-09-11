// Import the tree canopy cover collection
var dataset = ee.ImageCollection('USGS/NLCD_RELEASES/2023_REL/TCC/v2023-5');

//Filter collection to 2021 and CONUS study area 
var tcc = dataset.filter(ee.Filter.calendarRange(2023, 2023,'year'))  // range: [1985, 2023]
               .filter('study_area == "CONUS"')  
               .first();

// TCC palette
var tcc_palette = [
    'CDA066',
    'D7C29E',
    'C2D096',
    'B7D692',
    'ADDD8E',
    '78C679',
    '5CB86B',
    '41AB5D',
    '39A156',
    '329750',
    '238443',
    '11763D',
    '006837',
    '004529'
  ]

// SE palette 
var se_palette = [
    '000000',
    'FFFFFF',
    ]

              
// Display images on map 
Map.addLayer(tcc.select('data_mask'), {min:0,max:2}, 'Data Mask',false);
Map.addLayer(tcc.select('Science_Percent_Tree_Canopy_Cover'), {min:0,max:60,palette:tcc_palette}, 'Science Percent Tree Canopy Cover');
Map.addLayer(tcc.select('Science_Percent_Tree_Canopy_Cover_Standard_Error'), {min:0,max:4000,palette:se_palette}, 'Science Percent Tree Canopy Cover Standard Error');
Map.addLayer(tcc.select('NLCD_Percent_Tree_Canopy_Cover'), {min:0,max:60,palette:tcc_palette}, 'NLCD Percent Tree Canopy Cover');

Map.setCenter(-98.58, 38.14, 4);
