var dataset = ee.ImageCollection('RUB/RUBCLIM/LCZ/global_lcz_map/latest')
            .mosaic();

var visualization = {
  bands: ['LCZ_Filter'],
  min: 1,
  max: 17,
  palette: [
    '8c0000','d10000','ff0000','bf4d00','ff6600',
    'ff9955','faee05','bcbcbc','ffccaa','555555',
    '006a00','00aa00','648525','b9db79','000000',
    'fbf7ae','6a6aff'
    ]
};

Map.setCenter(7.26, 51.44, 6);
Map.addLayer(dataset, visualization, 'LCZ_Filter');
