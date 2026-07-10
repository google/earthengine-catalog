var dataset = ee.ImageCollection('projects/pml_evapotranspiration/PML/OUTPUT/PML_V22a_VIIRS');

// Convert 8-day averages to annual estimate with 0.01 scale factor
var image = dataset.filterDate('2025-01-01', '2025-12-31')
    .select('GPP')
    .mean()
    .multiply(365)
    .multiply(0.01);
    
// Final unit: mm yr-1
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
    image, visualization, 'PML_V2.2a Gross Primary Productivity (GPP)');

    
var white = 255; 
var background = ee.Image.rgb(white, white, white).visualize({min: 0, max: 255});


// Visualize the image and layer it over the gray background
var visualizedImage = image.visualize(visualization);
var imageWithBackground = ee.ImageCollection([background, visualizedImage]).mosaic();

var lon = -58;
var lat = -11;
Map.setCenter(lon, lat, 6);

// Viewport parameters for the 256x256 thumbnail
var delta = 24;
var pixels = 256;
var areaOfInterest = ee.Geometry.Rectangle(
    [lon - delta, lat - delta, lon + delta, lat + delta], null, false);

var visParams = {
  dimensions: [pixels, pixels],
  region: areaOfInterest,
  crs: 'EPSG:4326',
  format: 'png',
};

print(ui.Thumbnail({image: imageWithBackground, params: visParams}));