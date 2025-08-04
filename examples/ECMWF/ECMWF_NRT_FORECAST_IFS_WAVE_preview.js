// Observe the ocean in the vicinity of the Caribbean islands.
var aoi = ee.Geometry.Polygon(
    [[
      [-90.6052734375, 31.751243295508836], [-90.6052734375, 6.080143483787566],
      [-57.18730468750001, 6.080143483787566],
      [-57.18730468750001, 31.751243295508836]
    ]],
    null, false);

// Extract significant wave height forecasts made at noon on 2025/6/11 and
// specifically look at hour 0.
var wave =
    ee.ImageCollection('ECMWF/NRT_FORECAST/IFS/WAVE')
        .filter(ee.Filter.eq('creation_doy', 162))
        .filter(ee.Filter.eq('creation_hour', 12))
        .sort('forecast_hours')
        .select('significant_height_of_combined_wind_waves_and_swell_sfc')
        .first();

var waterLandMask = ee.Image('NOAA/NGDC/ETOPO1').select('bedrock').lte(0.0);
var waterLandBackground = waterLandMask.visualize({
  palette: ['cadetblue', 'lightgray'],
});
var image = wave.mask(waterLandMask).visualize({
  min: 0,
  max: 4,
  palette: ['blue', 'white'],
});

var imageParams = {
  dimensions: [256, 256],
  region: aoi,
  crs: 'EPSG:3857',
  format: 'png',
};
var imageWithBg = waterLandBackground.blend(image);
print(ui.Thumbnail({image: imageWithBg, params: imageParams}));