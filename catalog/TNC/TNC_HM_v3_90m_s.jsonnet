local id = 'TNC/HM/v3/90m_s';
local subdir = 'TNC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'TNC Global Human Modification v3 (Static Snapshot 90m)',
  version: '3.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Human Modification v3 dataset measures cumulative human pressures on global
    terrestrial ecosystems (excluding Antarctica). It tracks data from 1990 to 2022 and is
    intended to help quantify human impact for conservation planning, policy-making, and research.

    This is the 2022 static snapshot ("s" series) available at 90 meter resolution.
    Because it uses updated satellite and land-cover inputs, it is not recommended for
    direct quantitative comparison with the 1990–2020 "c" series.

    The modification score per pixel is calculated using the formula:
    modification = footprint proportion multiplied by stressor intensity.
    The data values are stored as 32-bit floats ranging from 0.0 to 1.0, where
    0.0 indicates no detectable human modification and 1.0 represents the maximum modeled modification.

    This dataset provides data for eight IUCN-aligned threat categories, plus one combined index.
    It was rigorously validated using a spatially balanced sample from the Global Land
    Use Emergent Dataset (GLUED). It achieved a root-mean-squared error (RMSE) of 0.178 at 90m.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://gdra-tnc.org/current/',
    },
  ],
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
  extent: ee.extent_global('2022-01-01T00:00:00Z', '2022-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      90.0,
    ],
    'eo:bands': [
      {
        name: 'All_threats_combined',
        description: 'All threats combined (overall modification)',
      },
      {
        name: 'Agriculture',
        description: 'Agriculture (croplands, forestry)',
      },
      {
        name: 'Built_up',
        description: 'Built-Up (residential, commercial, recreation areas)',
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
        description: 'Human accessibility (roads, trails, infrastructure)',
      },
      {
        name: 'Natural_system_modification',
        description: 'Natural system modification (e.g., dams, water regulation)',
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
        display_name: 'Human modification (All threats combined)',
        lookat: {
          lon: -105.0,
          lat: 40.0,
          zoom: 10.0,
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
    Theobald, D.M., Oakleaf, J.R., Moncrieff, G., Voigt, M., Kiesecker, J. & Kennedy, C.M. (2025).
    Global extent and change in human modification of terrestrial ecosystems from 1990 to 2022.
    Scientific Data 12, 489.
    [doi:10.1038/s41597-025-04892-2](https://doi.org/10.1038/s41597-025-04892-2)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
