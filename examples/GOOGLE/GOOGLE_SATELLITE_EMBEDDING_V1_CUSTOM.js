// Available Custom Satellite Embeddings sample ImageCollections:
var corcoranAg = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/CORCORAN_CITY_2026_AGRICULTURAL_CHANGE');
var futaleufuFire = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/FUTALEUFU_ARGENTINA_2026_FIRE_SCAR');
var kingCountyMonthly = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/KING_COUNTY_2025_MONTHLY');
var melolandCrops = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/MELOLAND_CALIFORNIA_2026_CROP_CYCLES');
var palisadesFire = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/PACIFIC_PALISADES_2025_FIRE');
var theewaterskloofWater = ee.ImageCollection(
    'GOOGLE/SATELLITE_EMBEDDING/V1/CUSTOM/THEEWATERSKLOOF_DAM_2026_WATER_CHANGE');

// Example visualization: Winter bare soil vs. spring peak greenness in Corcoran, CA
var winterBareSoil = corcoranAg.filterDate('2025-12-15', '2026-02-15').mosaic();
var springPeakGreenness = corcoranAg.filterDate('2026-03-15', '2026-05-15').mosaic();

var visParams = {min: -0.3, max: 0.3, bands: ['A01', 'A16', 'A09']};
Map.setCenter(-119.56, 36.10, 12);
Map.addLayer(winterBareSoil, visParams, 'Corcoran Winter Embeddings');
Map.addLayer(springPeakGreenness, visParams, 'Corcoran Spring Embeddings');
