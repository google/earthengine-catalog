var nidem = ee.Image('projects/geoscience-aus-cat/assets/NIDEM');

var elevation = nidem.select('nidem');
var elevationVis = {
  min: -2.5,
  max: 1.5,
  palette: [
    '440154', '471365', '482475', '463480', '414487', '3b528b', '355f8d',
    '2f6c8e', '2a788e', '25848e', '21918c', '1e9c89', '22a884', '2fb47c',
    '44bf70', '5ec962', '7ad151', '9bd93c', 'bddf26', 'dfe318', 'fde725'
  ],
};
Map.setCenter(122.36, -18.10, 11);
Map.addLayer(
    elevation, elevationVis,
    'National Intertidal Digital Elevation Model (NIDEM; m)');
