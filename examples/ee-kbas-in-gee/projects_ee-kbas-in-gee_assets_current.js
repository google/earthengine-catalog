var kbas = ee.FeatureCollection('projects/ee-kbas-in-gee/assets/current');

var KbasStyled = kbas.style({
  color: '#FFD700',        
  fillColor: '#FFD70066',  
  width: 1                 
});

Map.setCenter(0, 0,4);
Map.addLayer(KbasStyled, {}, 'Key Biodiversity Areas');