// Observe the ocean in the vicinity of the Caribbean islands and
// Gulf coast.
var aoi = ee.Geometry.Polygon(
    [[
      [-100.6052734375, 31.751243295508836],
      [-100.6052734375, 6.080143483787566],
      [-57.18730468750001, 6.080143483787566],
      [-57.18730468750001, 31.751243295508836]
    ]],
    null, false);

// Extract significant wave height forecasts made at noon on 2025/6/11.
var wave =
    ee.ImageCollection('ECMWF/NRT_FORECAST/IFS/WAVE')
        .filter(ee.Filter.eq('creation_doy', 162))
        .filter(ee.Filter.eq('creation_hour', 12))
        .sort('forecast_hours')
        .select('significant_height_of_combined_wind_waves_and_swell_sfc');

// Display the observations at forecast hour 0 on the map.
var hour0 = wave.first().clip(aoi);
Map.centerObject(hour0);
Map.addLayer(hour0, {min: 0, max: 5}, 'sig height fc=0');

// Animate the wave height forecasts over time.
var videoArgs = {
  dimensions: 540,
  region: aoi,
  framesPerSecond: 7,
  crs: 'EPSG:3857',
  min: 0,
  max: 5,
};
print(ui.Thumbnail(wave, videoArgs));