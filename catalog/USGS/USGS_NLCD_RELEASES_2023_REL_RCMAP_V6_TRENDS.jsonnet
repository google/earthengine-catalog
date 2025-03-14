local id = 'USGS/NLCD_RELEASES/2023_REL/RCMAP/V6/TRENDS';
local versions = import 'versions.libsonnet';
local version_table = import 'USGS_NLCD_RCMAP_Trends_versions.libsonnet';

local subdir = 'USGS';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local utils = import 'templates/RCMAP_rangeland_trends_V6.libsonnet';
local license = spdx.cc0_1_0;
local model_type = ['_linear_model_pvalue', '_linear_model_slope'];

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'RCMAP Rangeland Trends for Component Timeseries (1985-2023), ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image,
  description: utils.description,
  'sci:publications': utils.publication,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'climate_change',
    'disturbance',
    'landsat_derived',
    'nlcd',
    'rangeland',
    'trends'
  ],
  providers: [
    ee.producer_provider(
      'United States Geological Survey and Bureau of Land Management',
      'https://www.mrlc.gov/'
    ),
    ee.host_provider(self_ee_catalog_url),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(
    -128.0026, 26.5157, -99.6758, 51.5761,
    '1985-01-01T00:00:00Z',
    '2023-12-31T00:00:00Z'
  ),
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: name + desc,
        description: std.join(
          ' ',
          [
            utils.band_description[desc][0],
            std.join(' ', std.split(name, '_')),
            'time series',
          ]
        ),
        'gee:units': utils.band_description[desc][1],
        [if std.member(model_type, desc) then 'gee:scale']: 0.01,
      }
      for desc in std.objectFields(utils.band_description)
      for name in utils.bands_prefix
    ] + [
      {
        name: 'total_change_intensity_index',
        description: |||
          Total Change Intensity is a derivative index designed to highlight
          the total amount of change across primary components (shrub,
          bare ground, litter, and herbaceous). Change indicates the slope
          values from the structural change analysis. Values are constructed
          so that 100 means the maximum observed change across all components
          and 0 means no change.
        |||,
        'gee:units': units.dimensionless,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'annual herbaceous breakpoint in integer',
        lookat: {
          lat: 38,
          lon: -114,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              5,
            ],
            palette: [
              '000000',
              'f9e8b7',
              'f7e3ac',
              'f0dfa3',
              'eedf9c',
              'eada91',
              'e8d687',
              'e0d281',
              'ddd077',
              'd6cc6d',
              'd3c667',
              'd0c55e',
              'cfc555',
              'c6bd4f',
              'c4ba46',
              'bdb83a',
              'bbb534',
              'b7b02c',
              'b0ad1f',
              'adac17',
              'aaaa0a',
              'a3a700',
              '9fa700',
              '9aa700',
              '92a700',
              '8fa700',
              '87a700',
              '85a700',
              '82aa00',
              '7aaa00',
              '77aa00',
              '70aa00',
              '6caa00',
              '67aa00',
              '5fa700',
              '57a700',
              '52a700',
              '4fa700',
              '4aa700',
              '42a700',
              '3ca700',
              '37a700',
              '37a300',
              '36a000',
              '369f00',
              '349d00',
              '339900',
              '339900',
              '2f9200',
              '2d9100',
              '2d8f00',
              '2c8a00',
              '2c8800',
              '2c8500',
              '2c8400',
              '2b8200',
              '297d00',
              '297a00',
              '297900',
              '277700',
              '247400',
              '247000',
              '29700f',
              '2c6d1c',
              '2d6d24',
              '336d2d',
              '366c39',
              '376c44',
              '396a4a',
              '396a55',
              '3a6a5f',
              '3a696a',
              '396774',
              '3a6782',
              '39668a',
              '376292',
              '34629f',
              '2f62ac',
              '2c5fb7',
              '245ec4',
              '1e5ed0',
              '115cdd',
              '005ae0',
              '0057dd',
              '0152d6',
              '0151d0',
              '014fcc',
              '014ac4',
              '0147bd',
              '0144b8',
              '0142b0',
              '0141ac',
              '013da7',
              '013aa0',
              '01399d',
              '013693',
              '013491',
              '012f8a',
              '012d85',
              '012c82',
              '01297a'
            ],
            bands: [
              'annual_herbaceous_break_point',
            ],
          },
        },
      },
    ],
    annual_herbaceous_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    bare_ground_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    herbaceous_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    litter_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    sagebrush_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    shrub_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    shrub_height_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    non_sagebrush_shrub_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    perennial_herbaceous_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    tree_break_point: {
      minimum: 0,
      maximum: 3,
      'gee:estimated_range': false,
    },
    annual_herbaceous_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    bare_ground_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    herbaceous_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    litter_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    sagebrush_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    shrub_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },   
    shrub_height_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    non_sagebrush_shrub_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    perennial_herbaceous_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    tree_linear_model_pvalue: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    annual_herbaceous_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    bare_ground_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    herbaceous_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    litter_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    sagebrush_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    shrub_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    shrub_height_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    non_sagebrush_shrub_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    perennial_herbaceous_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    tree_linear_model_slope: {
      minimum: -383,
      maximum: 351,
      'gee:estimated_range': false,
    },
    annual_herbaceous_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    bare_ground_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    herbaceous_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    litter_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    sagebrush_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    shrub_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    shrub_height_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    non_sagebrush_shrub_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    perennial_herbaceous_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    tree_most_recent_break_point: {
      minimum: 1985,
      maximum: 2023,
      'gee:estimated_range': false,
    },
    total_change_intensity_index: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    }
  },
  'sci:citation': utils.citation,
  'gee:terms_of_use': utils.terms_of_use,
}
