local id = 'COPERNICUS/MARINE/INSITU_MULTI_4KM/ARGO';
local insitu = import 'templates/copernicus_marine_insitu.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  id: id,
  title: 'Copernicus Global In-situ Observations of Ocean Currents - Argo',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'earth-engine-public-data.insitu_nrt_currents.argo_latest',
  description: insitu.description + |||

    This dataset is derived from the original trajectory data from Argo GDAC
    (Global Data Assembly Center). In 2020, the GDAC distributes data from more
    than 15,000 Argo floats. Deep ocean current is calculated from floats drift
    at parking depth, surface current is calculated from float surface drift.

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
        description: 'Datetime of the observation',
        type: ee_const.var_type.datetime,
      },
      {
        name: 'DEPTH',
        description: 'Number of depth levels',
        type: ee_const.var_type.double,
      },
      {
        name: 'LATITUDE',
        description: 'Latitude of the observation',
        type: ee_const.var_type.double,
      },
      {
        name: 'LONGITUDE',
        description: 'Longitude of the observation',
        type: ee_const.var_type.double,
      },
      {
        name: 'PRES',
        description: |||
          Representative pressure of the current observation. Can be 0 or
          parking depth pressure (decibar).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'TRAJECTORY',
        description: 'Trajectory identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRES_QC',
        description: insitu.quality_control_flag_description('PRES'),
        type: ee_const.var_type.int,
      },
      {
        name: 'EWCT',
        description: |||
          West-East sea water velocity at the
          representative pressure (m/s)
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
          South-North sea water velocity at the representative pressure (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT_QC',
        description: insitu.quality_control_flag_description('NSCT'),
        type: ee_const.var_type.int,
      },
      {
        name: 'TIME_QC',
        description: insitu.quality_control_flag_description('TIME'),
        type: ee_const.var_type.int,
      },
      {
        name: 'POSITION_QC',
        description: insitu.quality_control_flag_description('POSITION'),
        type: ee_const.var_type.int,
      },
      {
        name: 'CYCLE_NUMBER',
        description: 'Cycle number of the Argo float',
        type: ee_const.var_type.double,
      },
      {
        name: 'GROUNDED',
        description: |||
          Indicates the best estimate of whether the float touched the ground
          for that cycle. The conventions are described below:

          * Y: Yes, the float touched the ground
          * B: Yes, the float touched the ground after bathymetry check with an
              outside database
          * N: No, the float did not touch the ground
          * S: Float is known to be drifting at a shallower depth than
              originally programmed
          * U: Unknown
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DURATION',
        description: 'Duration of measurement',
        type: ee_const.var_type.double,
      },
      {
        name: 'geometry',
        description: 'Geographic location of the observation',
        type: ee_const.var_type.geometry,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Global INSITU Argo EWCT',
        image_visualization: {
          band_names: ['EWCT'],
          min: -0.5,
          max: 0.5,
          palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
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
