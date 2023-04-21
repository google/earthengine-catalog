var dataset = ee.ImageCollection("JAXA/GCOM-C/L3/OCEAN/SST/V2")
                .filterDate('2020-01-01', '2020-02-01')
                // filter to daytime data only
                .filter(ee.Filter.eq("SATELLITE_DIRECTION", "D"));

// Multiply with slope coefficient and add offset
var dataset = dataset.mean().multiply(0.0012).add(-10);

var vis = {
  bands: ['SST_AVE'],
  min: 0,
  max: 30,
  palette: ['000000', '005aff', '43c8c8', 'fff700', 'ff0000'],
};

Map.setCenter(128.45, 33.33, 5);

Map.addLayer(dataset, vis, "Sea Surface Temperature");
