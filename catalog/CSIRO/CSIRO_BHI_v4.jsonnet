local id = 'CSIRO/BHI/v4';
local subdir = 'CSIRO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_nc_sa_4_0;

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
  title: 'CSIRO Global Biodiversity Indicators',
  version: 'v4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The CSIRO biodiversity indicators v4 dataset, produced by CSIRO using the BILBI
    (Biogeographic Infrastructure for Large-scale Biodiversity Indicators) framework,
    models global terrestrial biodiversity indicators at 30 arcsecond (~1 km) resolution
    annually from 2000 to 2024. These indicators provide a system-level view of change
    in biodiversity protection, expected persistence, and resilience in the face of
    climate change.

    A complementary static global weighting surface is available as a standalone image
    at CSIRO/BHI/v4_weights. It represents summed compositional similarity across
    terrestrial pixels, which is used for calculating regional and global geometric
    aggregations of the biodiversity indicators.

    For more detailed explanations of the indicators and how they are derived, see
    [CSIRO Biodiversity Modelling](https://research.csiro.au/biodiversitymodelling/indicators-tracking-progress-for-biodiversity/).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.25919/3aka-y730',
    },
  ],
  'gee:categories': ['ecosystems'],
  keywords: [
    'bhi',
    'biodiversity',
    'csiro',
    'ecosystems',
    'habitat',
    'species',
  ],
  providers: [
    ee.producer_provider('CSIRO', 'https://www.csiro.au/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2025-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'bhi',
        description: |||
          Biodiversity Habitat Index: Estimates the proportion of species diversity
          retained within each pixel as a function of the area, condition, and
          connectivity of natural ecosystems.
        |||,
      },
      {
        name: 'beri',
        description: |||
          Bioclimatic Ecosystem Resilience Index: Estimates the capacity of landscapes to
          retain species diversity in the face of climate change as a function of the area,
          condition, and connectivity of natural ecosystems across those landscapes.
        |||,
      },
      {
        name: 'parc_rep',
        description: |||
          Protected Area Representativeness: Estimates the extent to which a system of
          terrestrial protected areas is ecologically representative of the full range of
          environmental and biological diversity in any region.
        |||,
      },
      {
        name: 'parc_con',
        description: |||
          Protected Area Connectedness: Estimates the extent to which protected areas are
          functionally connected to one another and to other areas of intact natural ecosystems.
        |||,
      },
      {
        name: 'ecosystem_condition',
        description: |||
          Ecosystem Condition: Estimates the biological integrity of any location compared
          to undisturbed reference states (0-100%).
        |||,
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Biodiversity Habitat Index (BHI)',
        lookat: {
          lat: -25.27,
          lon: 133.78,
          zoom: 4,
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
              '440154',
              '3b528b',
              '21918c',
              '5ec962',
              'fde725',
            ],
            bands: [
              'bhi',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'sci:doi': '10.25919/3aka-y730',
  'sci:citation': |||
    Ware, C., Valavi, R., Vickers, M., Giljohann, K., Mokany, K., Purvis, A.,
    Walkden, P., De Palma, A., Duffin, C., Contu, S., Harwood, T., Hoskins, A.,
    Ferrier, S. (2024). Global biodiversity indicator data for BHI, BERI,
    PARC-representativeness, PARC-connectedness and ecosystem condition
    (2000-2024). CSIRO. [doi:10.25919/3aka-y730](https://doi.org/10.25919/3aka-y730)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
}
