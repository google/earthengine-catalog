var palettes = require('users/gena/packages:palettes');

// GEDI image collections at different spatial resolutions
var ic_1k = ee.ImageCollection('LARSE/GEDI/GRIDDEDVEG_002/V1/1KM')
var ic_6k = ee.ImageCollection('LARSE/GEDI/GRIDDEDVEG_002/V1/6KM')
var ic_12k = ee.ImageCollection('LARSE/GEDI/GRIDDEDVEG_002/V1/12KM')

// slopeshade basemap
var elev = ee.Image('MERIT/DEM/v1_0_3').select('dem')
var slope = ee.Terrain.slope(elev)
Map.setCenter(92.319, 27.129, 8)
Map.addLayer(
    slope, {min: 0, max: 40, palette: ['ffffff', '000000']}, 'Slopeshade')

var opac = 0.7
// View various measurement count metrics from 2019 to 2023
// "va" in the asset name corresponds to the count of high-quality, leaf-on
// vegetation measurements by GEDI
var i_counts_1k_19to23 = ee.Image(
    'LARSE/GEDI/GRIDDEDVEG_002/V1/1KM/gediv002_counts_va_20190417_20230316')
// Number of GEDI laser shots (i.e. footprints) per 1km pixel
Map.addLayer(
    i_counts_1k_19to23.select('shots_count'),
    {min: 0, max: 200, palette: palettes.matplotlib.magma[7]},
    'Shot count per 1km pixel, 2019 to 2023', 0, opac)
// Number of ISS orbits (with valid GEDI shots) per 1km pixel
Map.addLayer(
    i_counts_1k_19to23.select('orbits_uniq'),
    {min: 0, max: 10, palette: palettes.matplotlib.plasma[7]},
    'Unique orbits per 1km pixel, 2019 to 2023', 0, opac)
// The Nearest Neighbor Index (Evans et al. 2023), a proxy for quantifying
// spatial clustering/dispersion of GEDI shots
Map.addLayer(
    i_counts_1k_19to23.select('shots_nni'),
    {min: 0.5, max: 1.5, palette: palettes.colorbrewer.RdBu[7]},
    'Shot nearest neighbor index per 1km pixel, 2019 to 2023', 0, opac)

// View several GEDI vegetation structure metrics at 1km spatial res.
// For GEDI metric descriptions see Table 1 at
// https://daac.ornl.gov/GEDI/guides/GEDI_HighQuality_Shots_Rasters.html
// Relative height of the 98th percentile of returned energy (RH98), a proxy for
// tree canopy height
var i_rh98_1k_19to23 = ee.Image(
    'LARSE/GEDI/GRIDDEDVEG_002/V1/1KM/gediv002_rh-98-a0_vf_20190417_20230316')
// display the median value of GEDI RH98 measurements per 1km pixel, masking out
// values less than 3 consider using a threshold of 10 shots per 1km pixel. More
// shots generally yield more accurate estimates of the aggregation statistics
// (different bands)
var i_rh98_1k_19to23_med = i_rh98_1k_19to23.select('median')
var rh98_pal = palettes.crameri.bamako[10].reverse()
Map.addLayer(
    i_rh98_1k_19to23_med.updateMask(i_rh98_1k_19to23_med.gte(3).and(
        i_rh98_1k_19to23.select('countf').gte(10))),
    {min: 3, max: 40, palette: rh98_pal},
    'Median RH98 per 1km pixel, 2019 to 2023', 1, opac)
// Standard deviation of RH98 per 1km pixel. Captures variability of GEDI
// measurements and vegetation heterogeneity
Map.addLayer(
    i_rh98_1k_19to23.select('sd').updateMask(i_rh98_1k_19to23_med.gte(3).and(
        i_rh98_1k_19to23.select('countf').gte(10))),
    {min: 2, max: 20, palette: palettes.cmocean.Curl[7]},
    'SD of RH98 per 1km pixel, 2019 to 2023', 0, opac)
// Foliage height diversity of the 1m vertical Plant Area Index (PAI) profile
var i_fhd_1k_19to23 = ee.Image(
    'LARSE/GEDI/GRIDDEDVEG_002/V1/1KM/gediv002_fhd-pai-1m-a0_vf_20190417_20230316')
Map.addLayer(
    i_fhd_1k_19to23.select('median').updateMask(i_rh98_1k_19to23_med.gte(3).and(
        i_rh98_1k_19to23.select('countf').gte(10))),
    {min: 1.2, max: 3.2, palette: palettes.matplotlib.viridis[7].reverse()},
    'Median FHD per 1km pixel, 2019 to 2023', 0, opac)
// The height above ground associated with the peak of the vertical Plant Area
// Volume Density (PAVD) profile
var i_pavdmaxh_19to23 = ee.Image(
    'LARSE/GEDI/GRIDDEDVEG_002/V1/1KM/gediv002_pavd-max-h_vf_20190417_20230316')
Map.addLayer(
    i_pavdmaxh_19to23.select('mean').updateMask(i_rh98_1k_19to23_med.gte(3).and(
        i_pavdmaxh_19to23.select('countf').gte(10))),
    {min: 0, max: 25, palette: palettes.cmocean.Haline[7].reverse()},
    'Mean Height of Max. PAVD, 2019 to 2023', 0, opac)

// 1km coverage is not great in the low latitudes, try 6 or 12km for a more
// continuous depiction
var i_rh98_6k_19to23 = ee.Image(
    'LARSE/GEDI/GRIDDEDVEG_002/V1/6KM/gediv002_rh-98-a0_vf_20190417_20230316')
// display the median value of GEDI RH98 measurements per 6km pixel, masking out
// values less than 3 consider using a threshold of 100 shots per 6km pixel.
// More shots generally yield more accurate estimates of the aggregation
// statistics (different bands)
var i_rh98_6k_19to23_med = i_rh98_6k_19to23.select('median')
Map.addLayer(
    i_rh98_6k_19to23_med.updateMask(i_rh98_6k_19to23_med.gte(3).and(
        i_rh98_6k_19to23.select('countf').gte(100))),
    {min: 3, max: 40, palette: rh98_pal},
    'Median RH98 per 6km pixel, 2019 to 2023', 0, opac)