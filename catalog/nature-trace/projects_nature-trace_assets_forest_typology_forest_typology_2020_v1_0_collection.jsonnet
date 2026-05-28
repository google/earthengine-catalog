local id = 'projects/nature-trace/assets/forest_typology/forest_typology_2020_v1_0_collection';
local subdir = 'nature-trace';
local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Forest Typology (ForTy) 2020 v1.0',
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  'gee:type': ee_const.gee_type.image_collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  description: |||
    The Forest Typology (ForTy) v1 dataset consists of a global per-class
    probability map at 10 m resolution covering all land areas between
    65°S and 84°N latitude for the year 2020.

    The six-class typology is aligned with FAO and EU Deforestation
    Regulation (EUDR) definitions:

    * Class 1 – Primary Forest: Natural forest of native species with no
    visible indications of human-caused disturbance.
    * Class 2 – Naturally Regenerating Forest: Forests predominantly
    established through natural regeneration, including secondary forests
    recovering from disturbance and mixed forests where natural
    regeneration dominates.
    * Class 3 – Planted Forest: Forests established predominantly through
    planting or seeding, with an operational rotation period exceeding
    40 years.
    * Class 4 – Plantation Forest: Intensively managed forests
    characterized by one or two species, even age, regular spacing, and
    a rotation period of 40 years or less.
    * Class 5 – Tree Crops and Agroforestry: Agricultural plantations
    producing commodities other than wood (e.g., oil palm, rubber, fruit
    orchards), including agroforestry systems. Classified as agricultural
    land use under EUDR.
    * Class 6 – Other Land: All non-tree land uses, sparse woody
    vegetation (canopy cover < 10%), other wooded land, trees in urban
    environments, and small tree patches that do not meet forest
    thresholds.

    The primary data record is a five-band raster containing unsigned 8-bit
    integer values (0–250) representing quantized probability values for
    each of five forest type classes. The probability for the sixth class
    (Other land) is obtained as the complement: p_other = 250 − sum(p_i).
    The map uses the Universal Transverse Mercator (UTM) coordinate system.

    To get the probability score of the sixth, "Other land" class, you to
    subtract from 250 the sum of the first five probabilities. A categorical
    map can be derived by assigning each pixel to the class with the highest
    probability (argmax). The probability
    representation enables users to apply custom thresholds, assess
    prediction confidence, and compute uncertainty estimates for downstream
    applications.

    The source data is provided as Cloud Optimized GeoTIFFs (COGs) stored
    on Google Cloud Storage at
    `gs://nature-trace/export_rasters/forest_typology_2020_v1_0/`. The
    Earth Engine ImageCollection is backed by these COGs.

    Limitations: While this map provides a valuable global baseline, users
    should be aware of several limitations:

    * Temporal reference date: The map represents the state of land cover
    as of the year 2020, based on multi-temporal satellite composites.
    Rapid land-use changes occurring within the compositing period may not
    be fully captured.
    * Definitional ambiguity: The FAO-based definitions underlying the
    EUDR classification rely on management intent and history, which are
    not directly observable from satellite imagery. The model infers these
    categories from proxy indicators (spectral signatures, canopy
    structure, spatial patterns), introducing irreducible uncertainty at
    class boundaries. For example, mature naturally regenerating
    (secondary) forests can be spectrally and structurally
    indistinguishable from undisturbed primary forests.
    * Agroforestry ambiguity: Mixed agroforestry systems—where tree crops
    such as cocoa or coffee grow beneath a native canopy—are among the
    most challenging classes to resolve. Shaded cocoa and coffee
    agroforests can still be misclassified as natural forest in some
    regions.
    * Planted forest confusion: Planted forests exhibit the lowest
    classification accuracy among all forest classes (F1 = 58.2%). This
    class can be spectrally and structurally similar to naturally
    regenerating forests at one end and to plantation forests at the
    other, resulting in frequent misclassification in both directions.
    * Small patches and threshold canopy coverage: Isolated tree patches
    near the FAO forest area threshold (0.5 ha) and areas at the canopy
    cover boundary (10%) are inherently ambiguous.
    * Probability calibration: The per-class probabilities represent
    ensemble-averaged softmax outputs and have not been post-hoc
    calibrated. Users requiring well-calibrated probabilities for
    quantitative risk assessment should consider regional recalibration
    using independent reference data.
    * Wildfires: It is not always possible to determine the land use
    after a wildfire.
    * Conservative primary forest mapping: The primary forest class
    boundary is conservative near human infrastructure. Due to a spatial
    buffering effect inherited from the training data, the model
    systematically excludes forest edges near roads, settlements, or
    agriculture from the primary forest class, often labeling them as
    naturally regenerating instead.
    * Temporarily unstocked areas: Under FAO definitions, temporarily
    unstocked areas (such as recently harvested plantations awaiting
    replanting or forests in early post-disturbance recovery) are still
    considered forest. However, because this map relies on a single year
    of observations (2020), these areas may appear as non-forest and be
    misclassified as "Other Land."
    * Planted vs. plantation proxy: The distinction between planted and
    plantation forests uses an operational 40-year rotation threshold as
    a proxy. True EUDR/FAO management intensity criteria (e.g., even-aged
    class, regular spacing) are not directly observable from satellite
    imagery.
    * Other Wooded Land (OWL) omission: The EUDR recognizes "Other Wooded
    Land" (OWL) as a distinct category, but in this dataset, OWL is not
    resolved as a separate class and is entirely subsumed into the
    "Other Land" category.
    * Sub-pixel heterogeneity: Mixed pixels, particularly in complex
    smallholder landscapes, can reduce classification precision.
    Additionally, while the output is at 10 m, the effective resolution
    of the model's input data might be coarser than 10 m.
  |||,
  'gee:categories': ['forest-biomass'],
  keywords: [
    'alphaearth-derived',
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
  extent: ee.extent(-180, -65, 180, 84, '2020-01-01T00:00:00Z', '2020-12-31T23:59:59Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'PrimaryForest',
        description: |||
          Quantized probability (unsigned 8-bit integer, 0–250) that the
          pixel belongs to the primary forest class.
        |||,
        'gee:scale': 0.004,
      },
      {
        name: 'NaturallyRegeneratingForest',
        description: |||
          Quantized probability (unsigned 8-bit integer, 0–250) that the
          pixel belongs to the naturally regenerating forest class.
        |||,
        'gee:scale': 0.004,
      },
      {
        name: 'PlantedForest',
        description: |||
          Quantized probability (unsigned 8-bit integer, 0–250) that the
          pixel belongs to the planted forest class.
        |||,
        'gee:scale': 0.004,
      },
      {
        name: 'PlantationForest',
        description: |||
          Quantized probability (unsigned 8-bit integer, 0–250) that the
          pixel belongs to the plantation forest class.
        |||,
        'gee:scale': 0.004,
      },
      {
        name: 'TreeCropsAndAgroforestry',
        description: |||
          Quantized probability (unsigned 8-bit integer, 0–250) that the
          pixel belongs to the tree crops and agroforestry class. The
          probability for the sixth class (Other land) is obtained as the
          complement: p_other = 250 − sum of all five band values.
        |||,
        'gee:scale': 0.004,
      },
    ],
    gsd: [
      10.0,
    ],
    PrimaryForest: { minimum: 0, maximum: 250, 'gee:estimated_range': false },
    NaturallyRegeneratingForest: { minimum: 0, maximum: 250, 'gee:estimated_range': false },
    PlantedForest: { minimum: 0, maximum: 250, 'gee:estimated_range': false },
    PlantationForest: { minimum: 0, maximum: 250, 'gee:estimated_range': false },
    TreeCropsAndAgroforestry: { minimum: 0, maximum: 250, 'gee:estimated_range': false },
    'gee:visualizations': [
      {
        display_name: 'Forest Typology 2020 - Classification',
        lookat: {
          lat: 10,
          lon: 20,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [1],
            max: [6],
            palette: ['1B7837', '7FBF7B', '1D91C0', 'E65FA9', 'E6AB02', 'FDE278'],
            bands: ['PrimaryForest'],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Maxim Neumann, Anton Raichuk, Peter Potapov, Myroslava Lesiv,
    Matthew Overlan, Melanie Rey, Ravindran Rajakumar, Michelangelo
    Conserva, Radost Stanimirova, Michelle Sims, Sarah Carter,
    Elizabeth Goldman, Yuchang Jiang, Linus Scheibenreif, Ivelina
    Georgieva, Maria Shchepashchenko, Steffen Fritz, Nicholas Clinton,
    Charlotte Stanton, Dan Morris, Drew Purves: "Global forest typology
    at 10-meter resolution for forest and land-use monitoring", May 2026
    (preprint:
    [doi.org/10.31223/X58R27](https://doi.org/10.31223/X58R27)).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: [PLACEHOLDER ATTRIBUTION].
  |||,
}
