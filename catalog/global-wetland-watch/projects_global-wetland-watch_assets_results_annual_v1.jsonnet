local id = 'projects/global-wetland-watch/assets/results/annual/v1';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local gww = import 'gww.libsonnet';

local subdir = gww.subdir;
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Global Wetland Watch Annual Wetland Typology v' + version,
  version: version,
  description: |||
    The Global Wetland Watch annual wetland typology provides global maps
    of wetland occurrence and wetland ecosystem type for each year from 2017
    to 2025 at 10 m resolution. Each image represents the year-specific
    expression of wetlands: which pixels behaved as wetlands in that year and
    which wetland type they most resembled.

    Each image has two bands: `wetland_classification`, the wetland type
    assigned to the pixel, and `wetland_probability`. The collection is tiled
    by region; use the `year` and `region` image properties to select images.

    `wetland_probability` is the summed classifier probability of all wetland
    classes, in percent. It reflects the model's confidence that the pixel is
    a wetland. It helps interpret the classification by showing where the
    model is more and less confident, and can guide model improvement, for
    example by collecting additional training samples in uncertain areas.

    The typology has 23 classes covering coastal wetlands, inland wetlands
    and surface-water systems, aligned where possible with the
    International Union for Conservation of Nature (IUCN)
    [Global Ecosystem Typology](https://global-ecosystems.org/) (GET).
    Ocean (27) delineates the seaward boundary and is not a wetland type;
    Unclassified water (31) is a wetland not yet assigned to a specific type.

    Inland and coastal classes are predicted with regionally trained
    machine-learning models using the annual AlphaEarth Foundations satellite
    embeddings and, for coastal classes, high- and low-tide Sentinel-2
    composites. Training labels are compiled from existing wetland
    inventories and refined with Global Wetland Watch
    environmental layers. Surface-water
    classes are assigned within the predicted water extent using existing
    thematic datasets. Full methods will be described in a forthcoming
    publication.

    **Possible Uses:**

    * **Wetland inventories:** Supporting national and sub-national wetland
      inventories and reporting under multilateral environmental agreements
      such as the Ramsar Convention, the Convention on Biological Diversity
      and Sustainable Development Goal 6.
    * **Year-to-year dynamics:** Comparing years to identify wetlands that
      are only expressed in wet years.

    **Limitations:**

    * **Year-specific expression:** Annual maps reflect the conditions of a
      single year, so wetlands that are dry in a given year may not be
      mapped.
    * **Accuracy:** Accuracy has not been assessed across the whole range of
      products, including the individual annual maps; see the accompanying
      pre-print for details. Accuracy varies by class, and wetland types can
      be confused with each other.
    * **Wetland probability:** `wetland_probability` is a model confidence
      score, not a calibrated probability of wetland occurrence. Use it to
      compare relative confidence rather than as an absolute likelihood.
    * **Surface-water classes:** Detailed water classes depend on the
      coverage and accuracy of the source thematic datasets, which vary by
      region.
    * **Regional models:** Models are trained per region, so class
      boundaries can show discontinuities at the edges of processing regions.
    * **Coverage:** Global, excluding Antarctica and Greenland.
  |||,
  'gee:categories': ['ecosystems', 'surface-ground-water'],
  keywords: [
    'classification',
    'global',
    'landcover',
    'water',
    'wetland',
  ],
  providers: [
    gww.producer,
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -57.0, 180.0, 84.0,
                    '2017-01-01T00:00:00Z', '2026-01-01T00:00:00Z'),
  summaries: {
    gsd: [10.0],
    'eo:bands': [
      {
        name: 'wetland_classification',
        description: 'Wetland ecosystem type assigned to the pixel for the year.',
        'gee:classes': gww.typology_classes,
      },
      {
        name: 'wetland_probability',
        description: 'Summed classifier probability of all wetland classes: the model confidence that the pixel is a wetland (not a calibrated probability).',
        'gee:units': units.percent,
      },
    ],
    wetland_probability: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Wetland typology (2024)',
        lookat: {lon: -65.3, lat: -2.5, zoom: 11},
        image_visualization: {
          band_vis: {
            min: [1],
            max: [31],
            palette: gww.typology_palette,

            bands: ['wetland_classification'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'year',
        description: 'Year that the image represents',
        type: ee_const.var_type.int,
      },
      {
        name: 'region',
        description: 'Processing region of the tile (e.g. Africa, EU, SouthAmerica)',
        type: ee_const.var_type.string,
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'sci:citation': gww.citation,
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "Global Wetland Watch (DHI, UNEP-DHI, UNEP), 2026".
  |||,
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
