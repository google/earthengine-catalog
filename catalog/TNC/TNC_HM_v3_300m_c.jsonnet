local id = 'TNC/HM/v3/300m_c';
local subdir = 'TNC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'TNC Global Human Modification v3 (Change-Consistent 300m)',
  version: '3.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Human Modification v3 dataset measures cumulative human pressures on
    global terrestrial ecosystems (excluding Antarctica). It tracks data from 1990 to 2022 and is
    intended to help quantify human impact for conservation planning, policy-making, and research.
    This dataset is the "Change-Consistent" Series ("c" series) covering the years 1990, 1995, 2000,
    2005, 2010, 2015, and 2020 at a 300-meter resolution. This series uses consistent input data
    to allow for valid temporal change analysis across these years. The modification score per pixel
    is calculated using modification = footprint proportion * stressor intensity. The values are
    Float32 ranging from 0.0 to 1.0.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['population'],
  keywords: [
    'fragmentation',
    'human_modification',
    'landcover',
    'landscape_gradient',
    'stressors',
    'tnc',
  ],
  providers: [
    ee.producer_provider('The Nature Conservancy', 'https://www.nature.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1990-01-01T00:00:00Z', '2020-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      300.0,
    ],
    'eo:bands': [
      {
        name: 'All_threats_combined',
        description: 'All threats combined',
      },
      {
        name: 'Agriculture',
        description: 'Agriculture',
      },
      {
        name: 'Built_up',
        description: 'Built up or urban areas',
      },
      {
        name: 'Energy_production_and_mining',
        description: 'Energy production and mining',
      },
      {
        name: 'Biological_resource_use',
        description: 'Biological resource use',
      },
      {
        name: 'Human_accessibility',
        description: 'Human accessibility',
      },
      {
        name: 'Natural_system_modification',
        description: 'Natural system modification',
      },
      {
        name: 'Pollution',
        description: 'Pollution',
      },
      {
        name: 'Transportation_and_service_corridors',
        description: 'Transportation and service corridors',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'All threats combined',
        lookat: {
          lat: 40.0,
          lon: -105.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: [
              '0c0c0c',
              '071aff',
              'ff0000',
              'ffbd03',
              'fbff05',
              'fffdfd',
            ],
            bands: [
              'All_threats_combined',
            ],
          },
        },
      },
    ],
    All_threats_combined: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Agriculture: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Built_up: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Energy_production_and_mining: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Biological_resource_use: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Human_accessibility: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Natural_system_modification: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Pollution: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
    Transportation_and_service_corridors: {
      minimum: 0.0,
      maximum: 1.0,
      'gee:estimated_range': false,
    },
  },
  'sci:doi': '10.1038/s41597-025-04892-2',
  'sci:citation': |||
    Theobald, D. M., Oakleaf, J. R., Moncrieff, G., Voigt, M., Kiesecker, J., & Kennedy, C. M. (2025).
    Global extent and change in human modification of terrestrial ecosystems from 1990 to 2022.
    Scientific Data, 12, 489. [doi:10.1038/s41597-025-04892-2](https://doi.org/10.1038/s41597-025-04892-2)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
