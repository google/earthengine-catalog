local id = 'COPERNICUS/MARINE/INSITU_MULTI_4KM/DRIFTER';
local insitu = import 'templates/copernicus_marine_insitu.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  id: id,
  title: 'Copernicus Global In-situ Observations of Ocean Currents - Drifter',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'earth-engine-public-data.insitu_nrt_currents.drifter_latest',
  description: insitu.description + |||

    Regarding the production of global ocean products like the present one,
    activities among partners are organized according to the expertise and
    background in data management for operational oceanography. Drifter data
    in this collection come from two main sources: near-surface velocity
    measurements (15 m depth) from the French project Coriolis, part of the
    DBCP's Global Drifter Program, and drifter data retrieved from the OGS
    Mediterranean drifter dataset. The latter includes raw data from various
    research institutions and international data centers, processed using
    techniques described in Menna et al. (2017, 2018). The drifters have
    varying drogue depths, mostly between 0 and 15 m, but ranging from 0 to
    300 m.

    For more details refer to this
    [user manual](https://documentation.marine.copernicus.eu/PUM/CMEMS-INS-PUM-013-048.pdf)
  |||,
  license: insitu.license.id,
  links: ee.standardLinks(insitu.subdir, id),
  'gee:categories': ['oceans'],
  keywords: insitu.keywords,
  providers: insitu.providers(self_ee_catalog_url),
  extent: ee.extent_global('2025-03-28T00:00:00Z', null),
  summaries: {
    'gee:schema': [
      {
        name: 'TIME',
        description: 'datetime of the observation',
        type: ee_const.var_type.datetime,
      },
      {
        name: 'TIME_QC',
        description: insitu.quality_control_flag_description('TIME'),
        type: ee_const.var_type.int,
      },
      {
        name: 'DEPTH',
        description: 'Number of Depth levels',
        type: ee_const.var_type.double,
      },
      {
        name: 'DEPH',
        description: 'Depth of the observation. (m)',
        type: ee_const.var_type.double,
      },
      {
        name: 'DEPH_QC',
        description: insitu.quality_control_flag_description('DEPH'),
        type: ee_const.var_type.int,
      },
      {
        name: 'TEMP',
        description: |||
          Temperature 20-30 cm beneath the sea surface. (Degrees Celsius)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'TEMP_QC',
        description: insitu.quality_control_flag_description('TEMP'),
        type: ee_const.var_type.int,
      },
      {
        name: 'EWCT',
        description: |||
          West-East sea water velocity at the drogue depth from the drifter
          position (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT_QC',
        description: insitu.quality_control_flag_description('EWCT'),
        type: ee_const.var_type.int,
      },
      {
        name: 'NSCT',
        description: |||
          South-North sea water velocity at the drogue depth from the
          drifter position (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_QC',
        description: insitu.quality_control_flag_description('NSCT'),
        type: ee_const.var_type.int,
      },
      {
        name: 'WSTN_MODEL',
        description: |||
          North component of the 6-hour integrated wind stress from ECMWF model
          interpolated at the drifter's position (N/m^2)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTN_MODEL_QC',
        description: insitu.quality_control_flag_description('WSTN_MODEL'),
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTE_MODEL',
        description: |||
          East component of the 6-hour integrated wind stress from ECMWF model
          interpolated at the drifter's position (N/m^2)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTE_MODEL_QC',
        description: insitu.quality_control_flag_description('WSTE_MODEL'),
        type: ee_const.var_type.int,
      },
      {
        name: 'WSPN_MODEL',
        description: |||
          South-North 6-hour integrated 10-m wind component from ECMWF model
          interpolated at the drifter's position (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSPN_MODEL_QC',
        description: insitu.quality_control_flag_description('WSPN_MODEL'),
        type: ee_const.var_type.int,
      },
      {
        name: 'WSPE_MODEL',
        description: |||
          West-East 6-hour integrated 10-m wind component from ECMWF model
          interpolated at the drifter's position (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSPE_MODEL_QC',
        description: insitu.quality_control_flag_description('WSPE_MODEL'),
        type: ee_const.var_type.int,
      },
      {
        name: 'EWCT_WS',
        description: 'West-East wind slippage correction (m/s)',
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT_WS_QC',
        description: insitu.quality_control_flag_description('EWCT_WS'),
        type: ee_const.var_type.int,
      },
      {
        name: 'NSCT_WS',
        description: 'South-North wind slippage correction (m/s)',
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_WS_QC',
        description: insitu.quality_control_flag_description('NSCT_WS'),
        type: ee_const.var_type.double,
      },
      {
        name: 'WS_TYPE_OF_PROCESSING',
        description: |||
          Wind slippage correction processing method (Dimensionless)

          * 0: Optimal mode, it is considered that the drifter trajectory is
          longer than 30 days
          * 1: Mean, the first/last days of the trajectory are completed using
          the mean value over the nearest 7 days.
          * 2: Undefined for drifters with trajectories shorter than 30 days.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'PLATFORM_CODE',
        description: 'Platform code relative to each measurement',
        type: ee_const.var_type.string,
      },
      {
        name: 'CURRENT_TEST',
        description: |||
          Tests of drogue loss results. It contains the 3 flags value for the
          3 tests in a float format [SAW]

            * [S] submersion test
            * [A] acceleration not done
            * [W] wind-currents correlation

          It's a three-character string where each character is one of the
          following digits:

            * 0: Drogue probably missing
            * 1: Test not performed or not relevant (case for some MO_TS_DC
            platforms)
            * 2: Weak probability of drogue presence
            * 3: Strong probability of drogue presence
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'CURRENT_TEST_QC',
        description: insitu.quality_control_flag_description('CURRENT_TEST'),
        type: ee_const.var_type.int,
      },
      {
        name: 'DC_REFERENCE',
        description: 'Reference to the data center.',
        type: ee_const.var_type.string,
      },
      {
        name: 'POSITION_QC',
        description: insitu.quality_control_flag_description('POSITION'),
        type: ee_const.var_type.int,
      },
      {
        name: 'TRAJECTORY',
        description: 'Trajectory identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'geometry',
        description: 'Geographic location of the observation.',
        type: ee_const.var_type.geometry,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Sea Water Temperature',
        image_visualization: {
          band_names: ['TEMP'],
          min: 18,
          max: 25,
          palette: ['d7191c', 'fdae61', 'ffffbf', 'abd9e9', '2c7bb6'],
        },
        lookat: {
          lon: -100.5,
          lat: 30.2,
          zoom: 3,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:terms_of_use': insitu.terms_of_use,
}
