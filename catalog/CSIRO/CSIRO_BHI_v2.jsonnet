local id = 'CSIRO/BHI/v2';
local subdir = 'CSIRO';
local version = '2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_nc_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'CSIRO Biodiversity Habitat Index (BHI) v' + version,
  version: version,

  description: |||
    The Biodiversity Habitat Index (BHI) models the proportion of habitat retained
    and the proportion of species expected to be retained across terrestrial biomes
    and ecosystems globally.

    BHI v2 provides global 5-year interval datasets (2000, 2005, 2010, 2015,
    2020) at 30 arc-second (~1 km) resolution, estimating the impact of habitat
    loss and degradation on biodiversity persistence.
  |||,

  'gee:categories': ['ecosystems'],

  keywords: [
    'biodiversity',
    'csiro',
    'habitats',
    'species',
  ],

  providers: [
    ee.producer_provider('CSIRO', 'https://data.csiro.au/collection/csiro:72585v4'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2000-01-01T00:00:00Z', '2021-01-01T00:00:00Z'),

  summaries: {
    gsd: [
      1000.0,
    ],

    'eo:bands': [
      {
        name: 'proportion_habitat',
        description: 'Proportion of habitat retained',
        'gee:units': units.dimensionless,
      },
      {
        name: 'proportion_species',
        description: 'Proportion of species expected to be retained',
        'gee:units': units.dimensionless,
      },
    ],

    proportion_habitat: {minimum: 0.0, maximum: 1.0, 'gee:estimated_range': false},
    proportion_species: {minimum: 0.0, maximum: 1.0, 'gee:estimated_range': false},

    'gee:visualizations': [
      {
        display_name: 'Proportion of Habitat Retained',
        lookat: {lat: -25.0, lon: 133.0, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0.0],
            max: [1.0],
            palette: ['red', 'yellow', 'green'],
            bands: ['proportion_habitat'],
          },
        },
      },
      {
        display_name: 'Proportion of Species Retained',
        lookat: {lat: -25.0, lon: 133.0, zoom: 4},
        image_visualization: {
          band_vis: {
            min: [0.0],
            max: [1.0],
            palette: ['red', 'yellow', 'green'],
            bands: ['proportion_species'],
          },
        },
      },
    ],
  },

  'sci:doi': '10.25919/3j75-f539',
  'sci:citation': |||
    Ferrier, S., Harwood, T. D., Ware, C., & Hoskins, A. J. (2020). BHI v2: Biodiversity Habitat Index: 30s global time series. CSIRO. Data Collection. [doi:10.25919/3j75-f539](https://doi.org/10.25919/3j75-f539)
  |||,

  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 5,
  },

  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,

  'gee:type': ee_const.gee_type.image_collection,

  license: license.id,

  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://creativecommons.org/licenses/by-nc/4.0/'),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.25919/3j75-f539',
    },
    {
      rel: ee_const.rel.source,
      href: 'https://data.csiro.au/collection/csiro:72585v4',
    },
  ],

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
