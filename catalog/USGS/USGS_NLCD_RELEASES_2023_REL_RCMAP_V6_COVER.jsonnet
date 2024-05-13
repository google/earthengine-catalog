local id = 'USGS/NLCD_RELEASES/2023_REL/RCMAP/V6/COVER';
local versions = import 'versions.libsonnet';
local version_table = import 'USGS_NLCD_RCMAP_Cover_versions.libsonnet';

local subdir = 'USGS';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'RCMAP Rangeland Component Timeseries (1985-2023), ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    'The RCMAP (Rangeland Condition Monitoring Assessment and Projection)
    dataset quantifies the percent cover of rangeland components across
    western North America using Landsat imagery from 1985-2023. The RCMAP
    product suite consists of ten fractional components: annual herbaceous,
    bare ground, herbaceous, litter, non-sagebrush shrub, perennial herbaceous,
    sagebrush, shrub, tree, and shrub height in addition to the temporal
    trends of each component. Several enhancements were made to the RCMAP
    process relative to prior generations. First, high-resolution training
    was revised using an improved neural-net classifier and modelling approach.
    These data serve as foundation to the RCMAP approach. The training
    database was further improved by incorporating additional datasets. Next,
    the Landsat compositing approach was improved to better capture the range
    of conditions from across each year and through time. These composites are
    based on Collection 2 Landsat data with improved geolocation accuracy and
    dynamic range. Finally, the Canadian portion of the sagebrush biome was
    included, which expanded the study area by 29,199 km2.

    Processing efficiency has been increased using open-source software and
    USGS High-Performance Computing (HPC) resources. The mapping area included
    eight regions which were subsequently mosaicked. These data can be used to
    answer critical questions regarding the influence of climate change and
    the suitability of management practices. Component products can be
    downloaded at
    [Multi-Resolution Land Characteristics Consortium](https://www.mrlc.gov/data).

    See also:

    * Rigge, M., H. Shi, C. Homer, P. Danielson, and B. Granneman. 2019.
      Long-term trajectories of fractional component change in the Northern
      Great Basin, USA. Ecosphere 10(6):e02762.
      [doi:10.1002/ecs2.2762](https://doi.org/10.1002/ecs2.2762)

    * Rigge, M., C. Homer, L. Cleeves, D. K. Meyer, B. Bunde, H. Shi, G. Xian,
      S. Schell, and M. Bobo. 2020. Quantifying western U.S. rangelands as
      fractional components with multi-resolution remote sensing and in situ
      data. Remote Sensing 12.
      [doi:10.3390/rs12030412](https://doi.org/10.3390/rs12030412)

    * Rigge, M., C. Homer, H. Shi, D. Meyer, B.
      Bunde, B. Granneman, K. Postma, P. Danielson, A. Case, and G. Xian. 2021.
      Rangeland Fractional Components Across the Western United States
      from 1985 to 2018. Remote Sensing 13:813.
      [doi:10.3390/rs13040813](https://doi.org/10.3390/rs13040813).',
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
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
      'https://www.mrlc.gov/'),
    ee.host_provider(self_ee_catalog_url),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(
      -128.0026, 26.5157, -99.6758, 51.5761,
      '1985-01-01T00:00:00Z',
      '2023-12-31T00:00:00Z'),
  'sci:citation': |||
    Rigge, M.B., Bunde, B., Postma, K., and Shi, H., 2024,
    Rangeland Condition Monitoring Assessment and Projection (RCMAP)
    Fractional Component Time-Series Across the Western U.S. 1985-2023:
    U.S. Geological Survey data release,
    [doi:10.5066/P9SJXUI1](https://doi.org/10.5066/P9SJXUI1).
  |||,
  'gee:user_uploaded': true,
  'gee:terms_of_use': |||
    This work was authored as part of the Contributor's official duties as an
    Employee of the United States Government and is therefore a work of the
    United States Government. In accordance with 17 U.S.C. 105, no copyright
    protection is available for such works under U.S. Law. This is an Open
    Access article that has been identified as being free of known restrictions
    under copyright law, including all related and neighboring rights
    (https://creativecommons.org/publicdomain/mark/1.0/). You can copy, modify,
    distribute and perform the work, even for commercial purposes, all without
    asking permission.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [
      30
    ],
    'gee:visualizations': [
      {
        display_name: 'Rangeland Annual Herbaceous %',
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
              100,
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
              'rangeland_annual_herbaceous',
            ],
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'rangeland_annual_herbaceous',
        description:
          'Percent of the pixel covered by annual herbaceous vegetation.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_bare_ground',
        description: 'Percent of the pixel covered by bare ground.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_non_sagebrush_shrub',
        description:
          'Percent of the pixel covered by non-sagebrush shrubs.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_herbaceous',
        description: 'Percent of the pixel covered by herbaceous vegetation.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_litter',
        description: 'Percent of the pixel covered by litter.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_sagebrush',
        description:
          'Percent of the pixel covered by sagebrush (*Artemisia* spp).',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_shrub',
        description: 'Percent of the pixel covered by shrub.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_shrub_height',
        description: 'Average height of shrubs in centimeters.',
        'gee:units': units.centimeter,
      },
      {
        name: 'rangeland_perennial_herbaceous',
        description:
          'Percent of the pixel covered by perennial herbaceous vegetation.',
        'gee:units': units.percent,
      },
      {
        name: 'rangeland_tree',
        description: 'Percent of the pixel covered by tree.',
        'gee:units': units.percent,
      }
    ],
    rangeland_annual_herbaceous: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_bare_ground: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_non_sagebrush_shrub: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_herbaceous: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_litter: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_sagebrush: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_shrub: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_shrub_height: {
      minimum: 0,
      maximum: 500,
      'gee:estimated_range': false,
    },
    rangeland_perennial_herbaceous: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    },
    rangeland_tree: {
      minimum: 0,
      maximum: 100,
      'gee:estimated_range': false,
    }
  }
}
