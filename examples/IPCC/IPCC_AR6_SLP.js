var image =
    ee.Image('IPCC/AR6/SLP/ssp126_2030').select('total_values_quantile_0_5');
var visParams = {
  min: 10,
  max: 150,
  palette: ['0000FF', '00FFFF', 'FFFF00', 'FF0000'],
};

Map.addLayer(
    image, visParams, '0.5 quantile projection for sea level change in 2030');
