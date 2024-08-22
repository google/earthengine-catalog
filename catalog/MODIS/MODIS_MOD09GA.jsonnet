local id = 'MODIS/MOD09GA';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD09GA_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD09GA.005 Terra Surface Reflectance Daily L2G Global 1km and 500m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS Surface Reflectance products
    provide an estimate of the surface spectral reflectance as it would be
    measured at ground level in the absence of atmospheric scattering or
    absorption. Low-level data are corrected for atmospheric gases and
    aerosols, yielding a level-2 basis for several higher-order gridded
    level-2 (L2G) and level-3 products.

    MOD09GA provides Bands
    1-7 in a daily gridded L2G product in the Sinusoidal projection,
    including 500-meter reflectance values and 1-kilometer observation and
    geolocation statistics. 500-m Science Data Sets provided for this
    product include reflectance for Bands 1-7, a quality rating,
    observation coverage, observation number, and 250-m scan
    information. 1-kilometer Science Data Sets provided include number of
    observations, quality state, sensor angles, solar angles, geolocation
    flags, and orbit pointers.

    Bands:

    - num_observations_1km: Number of observations, 1km
    - state_1km: Reflectance Data State QA
       - Bit 0-1: cloud state bits
          - 00 (0):  clear
          - 01 (1):  cloudy
          - 10 (2):  mixed
          - 11 (3):  not set, assumed clear
       - Bit 2: cloud shadow data (1 = yes)
       - Bit 3-5: land/water flag
          - 000 (0):  shallow ocean
          - 001 (1):  land
          - 010 (2):  ocean coastlines and lake shorelines
          - 011 (3):  shallow inland water
          - 100 (4):  ephemeral water
          - 101 (5):  deep inland water
          - 110 (6):  continental/moderate ocean
          - 111 (7):  deep ocean
       - Bit 6-7: aerosol quantity
          - 00 (0):  climatology
          - 01 (1):  low
          - 10 (2):  average
          - 11 (3):  high
       - Bit 8-9: cirrus detected
          - 00 (0):  none
          - 01 (1):  small
          - 10 (2):  average
          - 11 (3):  high
       - Bit 10: internal cloud algorithm flag data (1 = Cloud)
       - Bit 11: internal fire algorithm flag data (1 = Fire)
       - Bit 12: MOD35 snow/ice flag data (1 = yes)
       - Bit 13: Pixel is adjacent to cloud data (1 = yes)
       - Bit 14: BRDF correction performed data (1 = yes)
       - Bit 15: internal snow mask data (1 = Snow)
    - SensorZenith (degrees * 100): sensor zenith angle
    - SensorAzimuth (degrees * 100): sensor azimuth angle
    - Range (scale 25): pixel to sensor
    - SolarZenith (degrees * 100): solar zenith angle
    - SolarAzimuth (degrees * 100): solar azimuth angle
    - gflags: Geolocation flags
       - Bit 0-2: Fill
       - Bit 3: Sensor range validity flag (0 = Valid)
       - Bit 4: Digital elevation model quality flag (0 = Valid, 1 = Missing/inferior)
       - Bit 5: Terrain data validity (0 = Valid)
       - Bit 6: Ellipsoid intersection flag (0 = Valid intersection, 1 = No intersection)
       - Bit 7: Input data flag (0 = Valid)
    - orbit_pnt: Orbit pointer
    - granule_pnt: Granule pointer (v6 only)
    - num_observations_500m: Number of observations, 500m
    - sur_refl_b01: 500m Surface Reflectance Band 1 (620-670 nm)
    - sur_refl_b02: 500m Surface Reflectance Band 2 (841-876 nm)
    - sur_refl_b03: 500m Surface Reflectance Band 3 (459-479 nm)
    - sur_refl_b04: 500m Surface Reflectance Band 4 (545-565 nm)
    - sur_refl_b05: 500m Surface Reflectance Band 5 (1230-1250 nm)
    - sur_refl_b06: 500m Surface Reflectance Band 6 (1628-1652 nm)
    - sur_refl_b07: 500m Surface Reflectance Band 7 (2105-2155 nm)
    - QC_500m: 500m Reflectance Band Quality
       - Bit 0-1: MODLAND QA bits
          - 00 (0):  corrected product produced at ideal quality all bands
          - 01 (1):  corrected product produced at less than ideal quality some or all bands
          - 10 (2):  corrected product not produced due to cloud effects all bands
          - 11 (3):  corrected product not produced due to other reasons some or all bands may be fill value [Note that a value of (11) overrides a value of (01)].
       - Bit 2-5: band 1 data quality four bit range
          - 0000 (0): highest quality
          - 1000 (8): dead detector; data interpolated in L1B
          - 1001 (9): solar zenith &ge; 86 degrees
          - 1010 (10): solar zenith &ge; 85 and &lt; 86 degrees
          - 1011 (11): missing input
          - 1100 (12): internal constant used in place of climatological data for at least one atmospheric constant
          - 1101 (13): correction out of bounds pixel constrained to extreme allowable value
          - 1110 (14): L1B data faulty
          - 1111 (15): not processed due to deep ocean or clouds
       - Bit 6-9: band 2 data quality four bit range
       - Bit 10-13: band 3 data quality four bit range
       - Bit 14-17: band 4 data quality four bit range
       - Bit 18-21: band 5 data quality four bit range
       - Bit 22-25: band 6 data quality four bit range
       - Bit 26-29: band 7 data quality four bit range
       - Bit 30: atmospheric correction performed data (1 = yes)
       - Bit 31: adjacency correction performed data (1 = yes)
    - obscov_500m (%): Observation coverage, 500m
    - iobs_res: Observation number in coarser grid
    - q_scan: 250m scan value information
       - Bit 0: missing observation in quadrant 4 [+0.5 row, +0.5 column] data (1 = yes)
       - Bit 1: missing observation in quadrant 3 [+0.5 row, -0.5 column] data (1 = yes)
       - Bit 2: missing observation in quadrant 2 [-0.5 row, +0.5 column]data (1 = yes)
       - Bit 3: missing observation in quadrant 1 [-0.5 row, -0.5 column] data (1 = yes)
       - Bit 4: scan of observation in quadrant 4 [+0.5 row, +0.5 column] data (0 = different, 1 = same)
       - Bit 5: scan of observation in quadrant 3 [+0.5 row, -0.5 column] data (0 = different, 1 = same)
       - Bit 6: scan of observation in quadrant 2 [-0.5 row, +0.5 column] data (0 = different, 1 = same)
       - Bit 7: scan of observation in quadrant 1 [-0.5 row, -0.5 column] data (0 = different, 1 = same)

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'daily',
    'global',
    'mod09ga',
    'modis',
    'surface_reflectance',
    'terra',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod09ga'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', '2017-03-30T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'True Color (143)',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'sur_refl_b01',
              'sur_refl_b04',
              'sur_refl_b03',
            ],
          },
        },
      },
      {
        display_name: 'False Color (367: Snow/Water/Ice)',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'sur_refl_b03',
              'sur_refl_b06',
              'sur_refl_b07',
            ],
          },
        },
      },
      {
        display_name: 'False Color (721: Burns)',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              -100.0,
            ],
            max: [
              8000.0,
            ],
            bands: [
              'sur_refl_b07',
              'sur_refl_b02',
              'sur_refl_b01',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  version: ee_const.version_unknown,
}
