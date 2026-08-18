var image = ee.Image(
    'projects/nature-trace/assets/ghg/emit/mapl_emit_plumes_v1_0/MAPL_EMIT_PLM_EMIT_L1B_RAD_001_20220810T051918_2222204_023_002');

var enh = image.select('methane_enhancement');
var prob = image.select('plume_probability');
var masked = enh.updateMask(prob.gt(0.6));

var visParams = {
  min: 0,
  max: 300,
  palette: [
    '#000004', '#1b0c41', '#4a0c6b', '#781c6d', '#a52c60', '#cf4446', '#ed6925',
    '#fb9b06', '#f7d13d', '#fcffa4'
  ]
};

var gray = 150;
var background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
var visualizedImage = masked.visualize(visParams);
var imageWithBackground =
    ee.ImageCollection([background, visualizedImage]).mosaic();

var region = image.geometry();

var imageParams = {dimensions: '256x256', region: region, format: 'png'};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
