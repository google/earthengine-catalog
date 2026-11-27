local id = 'projects/global-wetland-watch/assets/results/multiannual/v1';
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
  title: 'Global Wetland Watch Multiannual Wetland Typology v' + version,
  version: version,
  description: |||
    The multiannual wetland typology aggregates the annual wetland typology
    (`projects/global-wetland-watch/assets/results/annual/v1`) over 3-year and
    5-year windows between 2017 and 2025 at 10 m resolution. It represents the
    maximum wetland extent and the dominant wetland type in each window: a
    pixel is included if it was mapped as wetland in at least one year, and
    its class is the most frequent wetland class over those years.

    In addition to the typology (`mode_class`), further bands describe model
    confidence and how persistently each pixel was mapped as wetland over the
    window.

    Each image covers one window, identified by the `period` image property
    (e.g. `'2023-2025'`). The 3-year windows are 2017&ndash;2019,
    2020&ndash;2022 and 2023&ndash;2025; the 5-year windows are
    2017&ndash;2021, 2019&ndash;2023 and 2021&ndash;2025. Filter on `period`
    before mosaicking so that overlapping windows are not mixed.

    Full methods will be described in a forthcoming publication.

    **Possible Uses:**

    * **Reporting under multilateral environmental agreements:** For example,
      national wetland inventories for the Ramsar Convention, the Convention
      on Biological Diversity and Sustainable Development Goal 6.
    * **Comparing periods:** Differences in wetland extent and type between
      windows, with less influence from single wet or dry years. Differences
      have not been validated as wetland change.
    * **Wetland persistence:** Separating permanent wetlands from
      intermittent ones using the frequency bands.

    **Limitations:**

    * **Maximum extent:** A single wetland year is enough for inclusion, so
      the extent includes wetlands expressed only in wet years.
    * **Temporal aggregation:** The dominant class hides changes within a
      window; use the annual typology for individual years.
    * **Accuracy:** Accuracy varies by wetland type.
    * **Coastal classes:** Coastal classes depend on the 3-year high- and
      low-tide Sentinel-2 composites, so abrupt, unrealistic changes can
      occur between consecutive 3-year periods.
    * **Regional models:** Class boundaries can show discontinuities at the
      edges of processing regions.
    * **Pyramiding:** `class_frequency` and `wetland_frequency` use mode
      pyramiding: at scales coarser than 10 m, values are the most common
      number of years.
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
        name: 'mode_class',
        description: 'Most frequent wetland ecosystem type over the window.',
        'gee:classes': gww.typology_classes,
      },
      {
        name: 'mean_prob',
        description: 'Mean over the window of the annual combined probability of all wetland classes.',
        'gee:units': units.percent,
      },
      {
        name: 'class_frequency',
        description: 'Number of years in the window in which the pixel was assigned mode_class (class-specific).',
        'gee:units': units.year,
      },
      {
        name: 'wetland_frequency',
        description: 'Number of years in the window in which the pixel was mapped as wetland, regardless of class.',
        'gee:units': units.year,
      },
    ],
    mean_prob: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    class_frequency: {minimum: 0, maximum: 5, 'gee:estimated_range': false},
    wetland_frequency: {minimum: 0, maximum: 5, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Dominant wetland type (2023-2025)',
        lookat: {lon: 104.0, lat: 12.95, zoom: 9},
        image_visualization: {
          band_vis: {
            min: [1],
            max: [31],
            palette: gww.typology_palette,

            bands: ['mode_class'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'period',
        description: 'Aggregation window as startYear-endYear, e.g. 2023-2025',
        type: ee_const.var_type.string,
      },
      {
        name: 'startYear',
        description: 'First year of the aggregation window',
        type: ee_const.var_type.int,
      },
      {
        name: 'endYear',
        description: 'Last year of the aggregation window (inclusive)',
        type: ee_const.var_type.int,
      },
      {
        name: 'centerYear',
        description: 'Center year of the aggregation window',
        type: ee_const.var_type.int,
      },
      {
        name: 'range',
        description: 'Length of the aggregation window in years (3 or 5)',
        type: ee_const.var_type.int,
      },
      {
        name: 'version',
        description: 'Product version',
        type: ee_const.var_type.string,
      },
      {
        name: 'region',
        description: 'Processing region (tiling unit)',
        type: ee_const.var_type.string,
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 3,
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
