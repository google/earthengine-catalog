const image = ee.Image('projects/nature-trace/assets/mapl_emit_plumes_v3/MAPL_EMIT_PLM_EMIT_L1B_RAD_001_20220810T051918_2222204_023_002');

const enh = image.select('B0');
const prob = image.select('B1');
const masked = enh.updateMask(prob.gt(0.6));

const visParams = {
  min: 0,
  max: 300,
  palette: ['#000004', '#1b0c41', '#4a0c6b', '#781c6d', '#a52c60', '#cf4446', '#ed6925', '#fb9b06', '#f7d13d', '#fcffa4']
};

const gray = 150;
const background = ee.Image.rgb(gray, gray, gray).visualize({min: 0, max: 255});
const visualizedImage = masked.visualize(visParams);
const imageWithBackground = ee.ImageCollection([background, visualizedImage]).mosaic();

const region = image.geometry();

const imageParams = {
  dimensions: '256x256',
  region: region,
  format: 'png'
};

print(ui.Thumbnail({image: imageWithBackground, params: imageParams}));
