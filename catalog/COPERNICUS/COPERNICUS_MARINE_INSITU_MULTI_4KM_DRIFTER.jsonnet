local id = 'COPERNICUS/MARINE/INSITU_MULTI_4KM/DRIFTER';
local subdir = 'COPERNICUS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  id: id,
  title: 'Copernicus Global Ocean In Situ - Drifter',
  'gee:type': ee_const.gee_type.bigquery_table,
  description: |||
    This product is entirely dedicated to ocean current data observed in
    near-real time.

    The In Situ TAC is a distributed centre organized around 7 oceanographic
    regions: the global ocean and the 6 EUROGOOS regional alliances. It involves
    14 partners from 11 countries in Europe. It doesn't deploy any observing
    system and relies on data, exclusively funded by other sources than
    Copernicus Marine Service.

    Regarding the production of global ocean products like the present one,
    activities among partners are organized according to the expertise and
    background in data management for operational oceanography. Drifter data
    in this collection come from two main sources: near-surface velocity
    measurements (15 m depth) from the French project Coriolis, part of the
    DBCP’s Global Drifter Program, and drifter data retrieved from the OGS
    Mediterranean drifter dataset. The latter includes raw data from various
    research institutions and international data centers, processed using
    techniques described in Menna et al. (2017, 2018). The drifters have
    varying drogue depths, mostly between 0 and 15 m, but ranging from 0 to
    300 m.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['oceans'],
  keywords: [
    'copernicus',
    'marine',
    'ocean',
    'insitu',
    'drifter',
  ],
  providers: [
    ee.producer_provider('Copernicus', 'https://marine.copernicus.eu/'),
    ee.host_provider(self_ee_catalog_url),
  ],
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
        description: 'Quality control flag for TIME.',
        type: ee_const.var_type.double,
      },
      {
        name: 'DEPTH',
        description: 'Depth of the observation.',
        type: ee_const.var_type.double,
      },
      {
        name: 'DEPH',
        description: 'Depth of the observation.',
        type: ee_const.var_type.double,
      },
      {
        name: 'DEPH_QC',
        description: 'Quality control flag for DEPH.',
        type: ee_const.var_type.double,
      },
      {
        name: 'TEMP',
        description: |||
          Temperature 20-30 cm beneath the sea surface Degrees Celsius
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'TEMP_QC',
        description: 'Quality control flag for TEMP.',
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT',
        description: |||
          West-East sea water velocity at the drogue depth from the drifter
          position
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT_QC',
        description: 'Quality control flag for EWCT.',
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT',
        description: |||
          South-North sea water velocity at the drogue depth from the
          drifter position
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_QC',
        description: 'Quality control flag for NSCT.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTN_MODEL',
        description: |||
          North component of the 6-hour integrated wind stress from ECMWF model
          interpolated at the drifter''s position
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTN_MODEL_QC',
        description: 'Quality control flag for WSTN_MODEL.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTE_MODEL',
        description: |||
          East component of the 6-hour integrated wind stress from ECMWF model
          interpolated at the drifter''s position
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSTE_MODEL_QC',
        description: 'Quality control flag for WSTE_MODEL.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WSPN_MODEL',
        description: |||
          South-North 6-hour integrated 10-m wind component from ECMWF model
          interpolated at the drifter''s position
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSPN_MODEL_QC',
        description: 'Quality control flag for WSPN_MODEL.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WSPE_MODEL',
        description: |||
          West-East 6 hour integrated 10-m wind component from ECMWF model
          interpolated at the drifter''s position
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WSPE_MODEL_QC',
        description: 'Quality control flag for WSPE_MODEL.',
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT_WS',
        description: 'West-East wind slippage correction',
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT_WS_QC',
        description: 'Quality control flag for EWCT_WS.',
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_WS',
        description: 'South-North wind slippage correction',
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_WS_QC',
        description: 'Quality control flag for NSCT_WS.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WS_TYPE_OF_PROCESSING',
        description: |||
          Wind slippage correction processing method Dimensionless
        |||,
        type: ee_const.var_type.string,
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
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'CURRENT_TEST_QC',
        description: 'Quality control flag for CURRENT_TEST.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DC_REFERENCE',
        description: 'Reference to the data center.',
        type: ee_const.var_type.string,
      },
      {
        name: 'POSITION_QC',
        description: 'Quality control flag for the position.',
        type: ee_const.var_type.string,
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
      {
        name: 'system:time_start',
        description: 'Start time of the observation.',
        type: ee_const.var_type.datetime,
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
  'gee:terms_of_use': |||
    The data is provided free of charge by the Copernicus Marine Service.
    Users must acknowledge the Copernicus Marine Service as the data source
    when using the data. More details on the terms of use can be found on
    the [Copernicus Marine Service website](https://marine.copernicus.eu/user-corner/service-commitments-and-licence).
  |||,
}
