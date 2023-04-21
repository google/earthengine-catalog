var dataset = ee.ImageCollection("ECMWF/ERA5/MONTHLY");

var visualization = {
  bands: ['mean_2m_air_temperature'],
  min: 250.0,
  max: 320.0,
  palette: [
    "#000080","#0000D9","#4000FF","#8000FF","#0080FF","#00FFFF",
    "#00FF80","#80FF00","#DAFF00","#FFFF00","#FFF500","#FFDA00",
    "#FFB000","#FFA400","#FF4F00","#FF2500","#FF0A00","#FF00FF",
  ]
};

Map.setCenter(22.2, 21.2, 0);

Map.addLayer(dataset, visualization, "Monthly average air temperature [K] at 2m height");