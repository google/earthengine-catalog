var dataset = ee.ImageCollection('projects/pml_evapotranspiration/PML/OUTPUT/PML_V22a_VIIRS');

// Convert 8-day averages to annual estimate with 0.01 scale factor
var image = dataset.filterDate('2025-01-01', '2025-12-31')
    .select('GPP')
    .mean()
    .multiply(365)
    .multiply(0.01);
    
// Final unit: gC m-2 yr-1
var visualization = {
  bands: ['GPP'],
  min: 0.0,
  max: 3600, 
  palette: [

   "#A50026", "#D31527", "#F03E33", "#FA6F46", "#FD9D5D", "#FECA81", "#FFFFAC", 
   "#E3F399", "#C1E57A", "#96D35F", "#64BC56", "#34A048", "#12823A", "#006837"

  ]
};

Map.setCenter(0.0, 15.0, 2);

Map.addLayer(
    image, visualization, 'PML_V2.2a Gross Primary Production (GPP)');