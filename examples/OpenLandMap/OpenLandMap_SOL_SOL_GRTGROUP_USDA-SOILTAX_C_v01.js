var dataset = ee.Image('OpenLandMap/SOL/SOL_GRTGROUP_USDA-SOILTAX_C/v01');

var visualization = {
  bands: ['grtgroup'],
  min: 0,
  max: 433,
  palette: [
    'ffffff', 'adff2d', 'adff22', 'a5ff2f', '87ff37', 'baf019',
    '87ff19', '96f03d', 'a3f52f', 'aff319', '91ff37', '9cf319',
    '9bff37', '91ff19', '71ff37', '86ff19', 'a9d42d', 'aff519',
    '9bff19', '9af024', 'a5fd2f', '88ff37', 'afed19', '71ff19',
    'aff026', '8cf537', 'b7ff19', '7177c0', '9a85ec', 'f5f5e1',
    '52cf5a', 'e42777', '4ef76d', 'ff00fb', 'eb05eb', 'fa04fa',
    'fc04f5', 'f50df0', 'f118f1', 'fa0cfa', 'fc05e1', 'f100d5',
    'eb09e6', 'fa22fa', 'ffdab9', 'f5d2bb', 'e8c9b8', 'ffddc4',
    'e7cbc0', 'ffd2c3', 'f5d6bb', 'd5d3b9', 'e8d4b8', 'e7cdc0',
    'f3eac8', 'a0c4ba', 'ffd2b9', 'f5dabb', 'f5d5b9', 'e8ebb8',
    'ffddc2', 'e7ffc0', 'f3e6c8', 'ffdab9', 'f5cdb9', 'a91d30',
    '796578', 'd8ff6e', '177548', '43efd6', '8496a9', '296819',
    '73ffd4', '6fffc8', '75fbc9', '86f5d1', '82ffd2', '88eec8',
    '80ffd4', '6bffc9', '88eec8', '7fffc8', '81ffd2', '86f0d4',
    '67ffc8', '88eec8', '7ffbcb', '87ffd2', '8af5ce', '6bfad2',
    '78f0d4', '88eec8', '7ffbd4', '73f5cd', '88c8d2', '91f0cd',
    '73cdd2', '88eec8', 'fb849b', 'dd4479', '61388b', 'a52a30',
    '722328', 'd81419', 'a42828', '82f5cd', 'a54c2e', 'c11919',
    'b91419', '21b199', '702028', 'b41919', 'b22328', 'a2c7eb',
    '36ba79', '806797', 'cb5b5f', 'cd5c5c', 'd94335', 'd35740',
    'e05a5d', 'cf5b5c', 'ca5964', 'ca5d5f', 'cd5e5a', 'ca5969',
    'd95a35', 'd36240', 'e05c43', 'd64755', 'cf595c', 'ff5f5f',
    'cd6058', 'd95f35', 'd35140', 'd65a55', 'e05c59', 'cf525e',
    'c65978', 'f5615f', '826f9a', 'cff41a', '4a6f31', 'a96989',
    'e16438', '24f640', '88c1f9', 'f5d25c', 'd74322', '7f939e',
    '41a545', '8f8340', '09fe03', '0aff00', '0ff30f', '02f00a',
    '0fc903', '17f000', '0cff00', '0ac814', '0cfe00', '0aff0a',
    '03ff05', '1cf31c', '24f000', '00ff0c', '14c814', '00fe4c',
    '14ff96', '44d205', '05f305', '62f00a', '0fcd03', '00d20f',
    '1add11', '09ff0c', '03ff05', '05e700', '02f00a', '0fea03',
    '00f000', '0ccb0c', '14dd14', '6a685d', 'fae6b9', '769a34',
    '6ff2df', 'ca7fc6', 'd8228f', 'c01bf0', 'd2bad3', 'd8c3cb',
    'd4c6d4', 'd5bed5', 'ddb9dd', 'd8d2d8', 'd4c9d4', 'd2bad5',
    'd5bad5', 'd5b2d5', 'd8c8d2', 'd4cbd4', '552638', '2571eb',
    'ffa514', 'f3a502', 'fb7b00', 'f0b405', 'f7a80f', 'fb9113',
    'ffa519', 'f3a702', 'fbba07', 'f7970f', 'f3a702', 'fb5a00',
    'f0c005', 'f7810f', 'ff9c00', 'f3b002', 'f0b005', 'f7980f',
    '4d7cfc', 'ffff00', 'fafa05', 'ebeb22', 'ffff14', 'f1f10a',
    'fafa05', 'ebeb1e', 'f5eb0c', 'eef506', 'f1f129', 'fafa05',
    'ebeb0c', 'f5d202', 'ffd700', 'f1f12b', 'a91fac', '2da468',
    '9a8b71', '76b989', '713959',
  ]
};

Map.centerObject(dataset);

Map.addLayer(dataset, visualization, 'USDA soil taxonomy great groups');
