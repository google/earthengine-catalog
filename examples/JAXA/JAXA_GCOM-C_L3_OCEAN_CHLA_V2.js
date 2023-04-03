var dataset = ee.ImageCollection("JAXA/GCOM-C/L3/OCEAN/CHLA/V2")
                .filterDate('2020-01-01', '2020-02-01')
                // filter to daytime data only
                .filter(ee.Filter.eq("SATELLITE_DIRECTION", "D"));

// Multiply with slope coefficient
var image = dataset.mean().multiply(0.0016).log10();

var vis = {
  bands: ['CHLA_AVE'],
  min: -2,
  max: 2,
  palette: [
    '3500a8','0800ba','003fd6',
    '00aca9','77f800','ff8800',
    'b30000','920000','880000'
  ]
};

Map.addLayer(image, vis, "Chlorophyll-a concentration");

Map.setCenter(128.45, 33.33, 5);
