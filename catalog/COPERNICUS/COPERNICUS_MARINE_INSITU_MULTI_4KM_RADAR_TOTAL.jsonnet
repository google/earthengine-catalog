local id = 'COPERNICUS/MARINE/INSITU_MULTI_4KM/RADAR_TOTAL';
local insitu = import 'templates/copernicus_marine_insitu.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  id: id,
  title: 'Copernicus Global In-situ Observations of Ocean Currents - Radar Total',
  'gee:type': ee_const.gee_type.bigquery_table,
  'gee:bq_table_name': 'earth-engine-public-data.insitu_nrt_currents.radar_total_latest',
  description: insitu.description + |||

    This dataset contains sea surface current observations from High-Frequency
    (HF) radars. Sea surface currents measured by HF radar are an average over
    the top 0.3-2.5 m of the water column, depending on the operating central
    frequency.

    This dataset provides total velocity components. It comprises gridded maps
    of total velocity fields of the surface current averaged over a time
    interval. Total velocities are derived using an un-weighted least-square fit
    that maps radial velocities, measured by individual measurement stations,
    onto a Cartesian grid. The final product is a map of the zonal and
    meridional components of the ocean currents on a regular grid in the area of
    overlap of two or more radar stations.

    For more details refer to this
    [user manual](https://documentation.marine.copernicus.eu/PUM/CMEMS-INS-PUM-013-048.pdf)
  |||,
  license: insitu.license.id,
  links: ee.standardLinks(insitu.subdir, id),
  'gee:categories': ['oceans'],
  keywords: insitu.keywords + ['radar'],
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
        name: 'DEPTH',
        description: 'Number of depth levels',
        type: ee_const.var_type.double,
      },
      {
        name: 'DEPH',
        description: 'Depth of the observation (m)',
        type: ee_const.var_type.double,
      },
      {
        name: 'GDOP',
        description: 'Geometric Dilution of Precision',
        type: ee_const.var_type.double,
      },
      {
        name: 'DDNS_QC',
        description: insitu.quality_control_flag_description('DDNS'),
        type: ee_const.var_type.int,
      },
      {
        name: 'CSPD_QC',
        description: insitu.quality_control_flag_description('CSPD'),
        type: ee_const.var_type.int,
      },
      {
        name: 'VART_QC',
        description: insitu.quality_control_flag_description('VART'),
        type: ee_const.var_type.int,
      },
      {
        name: 'GDOP_QC',
        description: insitu.quality_control_flag_description('GDOP'),
        type: ee_const.var_type.int,
      },
      {
        name: 'QCflag',
        description: |||
          Overall quality flag

          Note: a value of 1 here indicates that all data in that row's source
          file was good, but because each row has QC bits for individual fields,
          a value other than 1 here does not necessarily mean that a row cannot
          or should not be used.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'EWCT',
        description: 'Surface Eastward sea water velocity (m/s)',
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCT',
        description: 'Surface Northward sea water velocity (m/s)',
        type: ee_const.var_type.double,
      },
      {
        name: 'EWCS',
        description: |||
          Standard Deviation Of Surface Eastward Sea Water Velocity (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'NSCS',
        description: |||
          Standard Deviation Of Surface Northward Sea Water Velocity (m/s)
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'CCOV',
        description: 'Covariance of Surface Sea Water Velocity (m^2/s^2)',
        type: ee_const.var_type.double,
      },
      {
        name: 'POSITION_QC',
        description: insitu.quality_control_flag_description('POSITION'),
        type: ee_const.var_type.int,
      },
      {
        name: 'SDN_STATION',
        description: 'Station identifier',
        type: ee_const.var_type.string,
      },
      {
        name: 'TIME_QC',
        description: insitu.quality_control_flag_description('TIME'),
        type: ee_const.var_type.int,
      },
      {
        name: 'DEPH_QC',
        description: insitu.quality_control_flag_description('DEPH'),
        type: ee_const.var_type.int,
      },
      {
        name: 'geometry',
        description: 'Geographic location of the observation',
        type: ee_const.var_type.geometry,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Global INSITU Radar Total EWCT',
        image_visualization: {
          band_names: ['EWCT'],
          min: -0.5,
          max: 0.5,
          palette: ['a50026', 'd73027', '333333', '4575b4', '313695'],
        },
        lookat: {
          lon: 25.5,
          lat: 71.5,
          zoom: 8,
        },
      },
    ],
  },
  'gee:skip_featureview_generation': true,
  'gee:terms_of_use': insitu.terms_of_use,
}
