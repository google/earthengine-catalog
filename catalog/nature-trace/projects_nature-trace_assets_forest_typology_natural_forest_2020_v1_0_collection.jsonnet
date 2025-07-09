local id = 'projects/nature-trace/assets/forest_typology/natural_forest_2020_v1_0_collection';
local subdir = 'nature-trace';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Natural Forests of the World 2020',
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  // TODO(ravirajakumar): Remove when the dataset is ready.
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  stac_extensions: [
    ee_const.ext_sci,
  ],
  description: |||
    This dataset, Natural Forests of the World 2020, provides a global map of
    natural forest probability for the year 2020 at a 10-meter resolution. It
    was developed to support initiatives like the European Union's
    Deforestation Regulation (EUDR) and other efforts for forest conservation
    and monitoring.
    The map represents the likelihood of an area being a natural forest, which
    includes primary, naturally regenerating secondary, and managed natural
    forests. It distinguishes these from planted forests, tree crops, and
    other land cover types. The dataset was created using a deep learning
    model that analyzed multi-temporal Sentinel-2 satellite imagery and
    topographical data.
    The data is provided as a probabilistic map, allowing users to apply a
    probability threshold to create a binary natural forest map tailored to
    their specific needs.
  |||,
  'gee:categories': ['forest-biomass'], // From the fixed list of published categories.
  keywords: [
    'biodiversity',
    'conservation',
    'climate',
    'deforestation',
    'eudr',
    'forest',
  ],
  providers: [
    ee.producer_provider('Google', 'https://deepmind.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2020-12-31T23:59:59Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'B0',
        description: |||
          Natural forest probabilities (scaled to [0-1]).
        |||,
      },
    ],
    gsd: [
      10.0,
    ],
    B0: { minimum: 0, maximum: 1, 'gee:estimated_range': false },
    'gee:visualizations':[
      {
        display_name: 'Natural forests 2020',
        lookat: {
          lat: -30,
          lon: 10,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0
            ],
            max: [
              1,
            ],
            palette: ['white', 'green'],
            bands: [
              'B0',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Maxim Neumann , Anton Raichuk, Radost Stanimirova, Michelle Sims , Sarah Carter,
    Elizabeth Goldman, Melanie Rey, Yuchang Jiang, Keith Anderson, Petra Poklukar,
    Katelyn Tarrio, Myroslava Lesiv, Steffen Fritz, Nicholas Clinton,
    Charlotte Stanton, Dan Morris, Drew Purves, "Natural forests of the world:
    A 2020 baseline for deforestation and degradation monitoring" (in review).
    [doi:10.31223/X5ZX6P](https://doi.org/10.31223/X5ZX6P),
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "This dataset is produced by Google".
  |||,
}