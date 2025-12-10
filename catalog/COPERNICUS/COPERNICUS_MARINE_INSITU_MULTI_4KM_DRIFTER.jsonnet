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
  title: 'Copernicus Global In-situ Observations of Ocean Currents - Drifter',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'earth-engine-public-data.insitu_nrt_currents.drifter_latest',
  description: |||
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
    DBCP's Global Drifter Program, and drifter data retrieved from the OGS
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
    'currents',
    'marine',
    'ocean',
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
        description: |||
          Quality control flag for TIME

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for DEPH.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for TEMP.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for EWCT.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for NSCT.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for WSTN_MODEL.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for WSTE_MODEL.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for WSPN_MODEL.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for WSPE_MODEL.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'EWCT_WS',
        description: 'West-East wind slippage correction (m/s)',
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCT_WS_QC',
        description: |||
          Quality control flag for EWCT_WS.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'NSCT_WS',
        description: 'South-North wind slippage correction (m/s)',
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_WS_QC',
        description: |||
          Quality control flag for NSCT_WS.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value

          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
        description: |||
          Quality control flag for CURRENT_TEST.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value
          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'DC_REFERENCE',
        description: 'Reference to the data center.',
        type: ee_const.var_type.string,
      },
      {
        name: 'POSITION_QC',
        description: |||
          Quality control flag for the position.

          * 0: No QC was performed
          * 1: good
          * 2: probably good
          * 3: Bad data that are potentially correctable
          * 4: Bad data
          * 5: value changed
          * 6: Not used
          * 7: nominal
          * 8: interpolated
          * 9: Missing value
          Note that a valid value for the corresponding variable has a QC bit
          equal to 1, 2, 5, 7, or 8.
        |||,
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
  'gee:terms_of_use': |||
    The data is provided free of charge by the Copernicus Marine Service.
    Users must acknowledge the Copernicus Marine Service as the data source
    when using the data. More details on the terms of use can be found on
    the [Copernicus Marine Service website](https://marine.copernicus.eu/user-corner/service-commitments-and-licence).
  |||,
}
