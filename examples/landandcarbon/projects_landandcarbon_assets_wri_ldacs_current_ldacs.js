// Current LDACS asset
var ldacs = ee.Image('projects/landandcarbon/assets/wri_ldacs/current/ldacs');

//Visualization parameters where:
// 1 = Fire-related
// 2 = Cropland dynamics
// 3 = Water-related
// 4 = Potential conversion
var ldacs_viz = {
    min:1, 
    max:4, 
    palette: ['9A3B01','AB8C00','0000FF','DB2777']};

Map.setCenter(-45.9893, -11.1868, 10);

Map.addLayer(ldacs, ldacs_viz, 'LDACS');