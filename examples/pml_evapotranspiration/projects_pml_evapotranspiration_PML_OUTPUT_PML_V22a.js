var dataset = ee.ImageCollection('projects/pml_evapotranspiration/PML/OUTPUT/PML_V22a');

// Convert 8-day averages to annual estimate with 0.01 scale factor
var annualImage = dataset.filterDate('2024-01-01', '2024-12-31')
    .select('ET')
    .mean()
    .multiply(365)
    .multiply(0.01);
    
// Final unit: mm yr-1
var visualization = {
  bands: ['ET'],
  min: 0.0,
  max: 1600, 
  palette: [
    "#A02323", "#C80000", "#FF0000", "#FF6E00", "#FFAA00", "#FFE132", 
    "#FFFFC8", "#D2F5FF", "#A0D2FF", "#00BFFF", "#1E90FF", "#4169E1", 
    "#0000CD", "#000096"
  ]
};

Map.setCenter(0.0, 15.0, 2);

Map.addLayer(
    annualImage, visualization, 'PML_V2.2a Evapotranspiration (ET)');