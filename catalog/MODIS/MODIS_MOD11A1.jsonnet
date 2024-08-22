local id = 'MODIS/MOD11A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD11A1_versions.libsonnet';

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
  title: 'MOD11A1.005 Terra Land Surface Temperature and Emissivity Daily Global 1 km Grid SIN [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS/Terra Land Surface Temperature and
    Emissivity (LST/E) product, MOD11A1, provides per-pixel temperature and
    emissivity values, which are produced daily using the generalized split-window
    LST algorithm.  This algorithm is optimally used to separate ranges of
    atmospheric column water vapor and lower boundary air surface temperatures into
    tractable sub-ranges. The surface emissivities in bands 31 and 32 are estimated
    from land cover types.

    The V5 MOD11A1 products are projected in a Sinusoidal grid by mapping the
    level-2 LST product (MOD11_L2) on 1-kilometer (precisely 0.928-km) grids. The
    MOD11A1 product comprises the following Science Data Set (SDS) layers for
    daytime and nighttime observations:

    - LST_Day_1km: Daytime Land Surface Temperatures (K),  Scale 0.02
    - QC_Day: Daytime Surface Temperature quality control assessments
    - Day_view_time: Daytime LST Observation Times (Hours), Scale 0.1
    - Day_view_angle: Daytime View Zenith Angles (Degrees), Offset -65.0
    - LST_Night_1km: Nighttime Land Surface Temperatures (K),  Scale 0.02
    - QC_Night: Nighttime Surface Temperature quality control assessments
    - Night_view_time: Nighttime LST Observation Times (Hours), Scale 0.1
    - Night_view_angle: Nighttime View Zenith Angles (Degrees), Offset -65.0
    - Emis_31: Bands 31 Emissivity, Scale 0.002, Offset 0.49
    - Emis_32: Bands 32 Emissivity, Scale 0.002, Offset 0.49
    - Clear_night_cov: Nighttime Clear Sky Coverage, Scale 0.0005
    - Clear_day_cov: Daytime Clear Sky Coverage, Scale 0.0005

    QC bit flags:

    - Bits 0-1: Mandatory QC Flag
       - 00: LST produced, good quality, not necessary to examine detailed QC.
       - 01: LST produced, unreliable or unquantifiable quality, recommend examination of more detailed QC.
       - 10: LST not produced due to cloud effects.
       - 11: LST not produced primarily due to reasons other than clouds.
    - Bits 2-3: Data Quality Flag
       - 00: Good quality L1B in bands 31 and 32.
       - 01: Other quality data.
       - 10: TBD
       - 11: TBD
    - Bits 4-5: Emissivity Error Flag
       - 00: Average emissivity error &le; 0.01
       - 01: Average emissivity error &le; 0.02
       - 10: Average emissivity error &le; 0.04
       - 11: Average emissivity error &gt; 0.04
    - Bits 6-7: LST Error Flag
       - 00: Average LST error &le; 1 K
       - 01: Average LST error &le; 2 K
       - 10: Average LST error &le; 3 K
       - 11: Average LST error &gt; 3 K

    The V5 Terra/MODIS LST/E products, including MOD11A1, are validated to Stage-2
    through field campaigns and radiance-based validation studies.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'daily',
    'emissivity',
    'global',
    'lst',
    'mod11a1',
    'modis',
    'surface_temperature',
    'terra',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod11a1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-03-05T00:00:00Z', '2017-03-30T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'Surface Temperature',
        lookat: {lon: 6.746, lat: 46.529, zoom: 2},
        image_visualization: {
          band_vis: {
            gain: [
              0.1,
            ],
            bias: [
              -1400.0,
            ],
            bands: [
              'LST_Day_1km',
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
