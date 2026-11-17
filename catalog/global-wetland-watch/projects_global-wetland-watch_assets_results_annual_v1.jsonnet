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
    The annual wetland typology maps 20+ wetland types, aligned with the International Union for Conservation of
    Nature (IUCN) [Global Ecosystem Typology](https://global-ecosystems.org/)
    (GET), for each year from 2017 to 2025 at 10 m resolution.

    Alongside the typology (`wetland_classification`), the
    `wetland_probability` band gives the model's confidence, in percent, that
    the pixel is a wetland. The collection is tiled by region; use the `year`
    and `region` image properties to select images.

    Full methods will be described in a forthcoming publication.

    **Possible Uses:**

    * **Reporting under multilateral environmental agreements:** For example,
      national wetland inventories for the Ramsar Convention, the Convention
      on Biological Diversity and Sustainable Development Goal 6.
    * **Year-to-year dynamics:** Changes in inundated wetland extent between
      years.

    **Limitations:**

    * **Year-specific expression:** Wetlands that are dry in a given year
      may not be mapped in that year.
    * **Accuracy:** Accuracy varies by wetland type.
    * **Surface-water classes:** Surface-water types are assigned from
      existing thematic datasets, so their quality varies by region.
    * **Coastal classes:** Coastal classes depend on the 3-year high- and
      low-tide Sentinel-2 composites, so abrupt, unrealistic changes can
      occur between consecutive 3-year periods.
    * **Regional models:** Class boundaries can show discontinuities at the
      edges of processing regions.
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
        lookat: {lon: 117.35, lat: -0.6, zoom: 10},
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
