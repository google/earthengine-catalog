var dataset = ee.ImageCollection('JAXA/ALOS/AW3D30/V3_2');
var elevation = dataset.select('DSM');
var elevationVis = {
  min: 0,
  max: 5000,
  palette: ['0000ff', '00ffff', 'ffff00', 'ff0000', 'ffffff']
};
Map.setCenter(138.73, 35.36, 11);
Map.addLayer(elevation, elevationVis, 'Elevation');

// Reproject an image mosaic using a projection from one of the image tiles,
// rather than using the default projection returned by .mosaic().
var proj = elevation.first().select(0).projection();
var slopeReprojected = ee.Terrain.slope(elevation.mosaic()
                             .setDefaultProjection(proj));
Map.addLayer(slopeReprojected, {min: 0, max: 45}, 'Slope');
