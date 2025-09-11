local id = 'projects/nature-trace/assets/forest_typology/natural_forest_2020_v1_0_collection';
local subdir = 'nature-trace';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_sa_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Natural Forests of the World 2020',
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  'gee:type': ee_const.gee_type.image_collection,
  stac_extensions: [
    ee_const.ext_sci,
  ],
  description: |||
    Natural Forests of the World 2020, provides a global map of
    natural forest probability for the year 2020 at a 10-meter resolution. It
    was developed to support initiatives like the European Union's
    Deforestation Regulation (EUDR) and other efforts for forest conservation
    and monitoring.
    The map represents the likelihood of an area being a natural forest, which
    includes primary, naturally regenerating secondary, and managed natural
    forests. It distinguishes these from planted forests, tree crops, and
    other land cover types. The dataset was created using a multi-modal
    temporal-spatial vision transformer model that analyzed seasonal
    multi-temporal Sentinel-2 satellite imagery and topographical data
    (elevation, slope, aspect based on TanDEM-X's Copernicus GLO-30 DEM).
    The data is provided as a probabilistic map, allowing users to apply a
    probability threshold to create a binary natural forest map tailored to
    their specific needs.

    Limitations: While this map provides a valuable global baseline, users
    should be aware of several limitations in our map (assessed at the OA
    optimal probability threshold of 0.52):

    * The model can have difficulty distinguishing complex agroforestry systems
    (e.g., with shaded tree crops), and smallholder agricultural mosaics can be
    difficult to distinguish from natural forests.
    * Differentiating planted forests from naturally regenerating ones can be
    challenging, especially in boreal and some temperate zones, where natural
    forests have lower species diversity and are harvested with longer rotation
    times compared to the tropics.
    * Sparse natural forests, such as savanna, are often at the threshold of
    natural forest definition for the tree canopy height and coverage ratios.
    Forest type assignment immediately after a disturbance event (e.g., fire,
    logging) is inherently ambiguous. It may not be clear from satellite imagery
    whether the forest will regenerate naturally or if the land will be
    converted to another use (e.g., plantation, agriculture).
    * Other areas of potential confusion could include large parks within urban
    areas, or planted tree belts that meet forest definition criteria but are
    not natural.
    * The accuracy of our natural forest map is intrinsically linked to the
    quality and consistency of the various input datasets used for training
    label generation. These datasets were created using different methodologies,
    spatial resolutions, temporal ranges, and definitions. Some label layers
    were the outputs of other models, and are therefore limited by the quality
    of those models. While our approach aimed to harmonize sources and mitigate
    the impact of individual dataset errors, inconsistencies and inaccuracies in
    the underlying data could still influence the final map.
  |||,
  'gee:categories': ['forest-biomass'],
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
    [CC-BY 4.0 ShareAlike](https://creativecommons.org/licenses/by-sa/4.0/) and requires the
    following attribution: "This dataset is produced by Google".
  |||,
  'gee:unusual_terms_of_use': true,
}