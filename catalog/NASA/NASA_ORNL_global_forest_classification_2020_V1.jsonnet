local id = 'NASA/ORNL/global_forest_classification_2020/V1';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local version = 'V1';

{
  'gee:status': 'beta',
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global 2020 Forest Classification for IPCC Aboveground Biomass Tier 1 Estimates, ' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset provides classes of global forests delineated by
    status/condition in 2020 at approximately 30m resolution. The data support
    generating Tier 1 estimates for Aboveground dry woody Biomass Density (AGBD)
    in natural forests in the 2019 Refinement to the 2006 IPCC Guidelines for
    National Greenhouse Gas Inventories. Forest classes include primary, young
    secondary (<=20 years), and old secondary forests (>20 years). Classification
    was based on a Boolean combination of a suite of existing Earth Observation
    (EO) products of forest tree cover, height, age, and land use classification
    layers representing years 2000 to 2020. This forest status/condition
    classification prioritizes the reduction of potential errors of commission in
    the delineations by minimizing the inclusion of ambiguous pixels. Hence, it
    provides a conservative estimate of global forest area, identifying
    approximately 3.26 billion ha of forests worldwide.

    ### Quality Assessment

    These data provide a comprehensive compilation of the latest published
    datasets on forest conditions, but the nonexistence of any independent sample
    of global data that would enable the validation of these delineations is a
    constraint. Hence, the global forest status/condition classification has not
    been validated.

    ### Data Acquisition, Materials, and Methods

    The forest status/condition classification is created by conducting a
    Boolean analysis of a suite of existing datasets (see Table 1, Hunka et al.,
    2024, in review), including satellite-derived forest tree cover, height, age,
    and land use classification layers. In this approach, layers that
    identify a potential forest status/condition class (e.g. primary forests) are
    merged, and layers that identify sources of disagreement (e.g. presence of
    plantations or deforestation detected in the delineated primary forests) are
    used to remove areas of potential commission errors.

    The primary forest class is established using datasets identifying
    intact/primary forests, with a high forest integrity index, the presence of
    tree cover and forest heights ≥5 m and no known forest loss events, planted
    forests or plantations.

    The young secondary forest class captures pixels that had changes in
    forest height or cover between 2000 and 2020, excluding planted forests and
    plantations. These forests were identified by heights ≥5 m in 2020 and either
    (a) heights <5 m in 2000 or (b) heights ≥5 m in 2000 but having experienced
    tree cover loss after 2000.

    The old secondary forest class captures the remainder of pixels with
    forests after excluding the primary and young secondary forest classes. These
    pixels had forest heights ≥5 m in both 2000 and 2020 with no tree cover loss
    nor forest disturbances detected after 2000, nor any planted forests or
    plantations.

    [Schematic of analysis workflow](https://daac.ornl.gov/CMS/guides/CMS_Global_Forest_Age_Fig2.jpg)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.3334/ORNLDAAC/2345',
    },
  ],
  keywords: [
    'aboveground',
    'biomass',
    'carbon',
    'classification',
    'forest',
    'ipcc',
    'nasa',
    'primary_forest',
    'secondary_forest',
  ],
  providers: [
    ee.producer_provider('NASA ORNL DAAC at Oak Ridge National Laboratory', 'https://doi.org/10.3334/ORNLDAAC/2345'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T00:00:00Z', '2020-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      30,
    ],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Forest Type',
        'gee:classes': [
          {
            value: 1,
            color: '00ff00',
            description: 'Primary Forest'
          },
          {
            value: 2,
            color: 'ff0000',
            description: 'Young Secondary Forest'
          },
          {
            value: 3,
            color: '6666ff',
            description: 'Old Secondary Forest'
          },
        ]
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Forest Type',
        lookat: {
          lat: -1.94,
          lon: 29.87,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              3.0,
            ],
            palette: [
              '00ff00',
              'ff0000',
              '6666ff',
            ],
            bands: [
              'classification',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.3334/ORNLDAAC/2345',
  'sci:citation': |||
    Hunka, N., L. Duncanson, J. Armston, R.O. Dubayah, S.P. Healey, M.
    Santoro, P. May, A. Araza, C. Bourgain, P.M. Montesano, C.S. Neigh, H.
    Grantham, V. Potapov, S. Turubanova, A. Tyukavina, J. Richter, N. Harris, M.
    Urbazaev, A. Pascual, D. Requena Suarez, M. Herold, B. Poulter, S.N. Wilson,
    G. Grassi, S. Federici, M.J. Sanz Sanchez, and J. Melo. 2024. Classification
    of Global Forests for IPCC Aboveground Biomass Tier 1 Estimates, 2020. ORNL
    DAAC, Oak Ridge, Tennessee, USA.
    [https://doi.org/10.3334/ORNLDAAC/2345](https://doi.org/10.3334/ORNLDAAC/2345)
|||,
  'gee:terms_of_use': |||
    This dataset is in the public domain and is available
    without restriction on use and distribution. See [NASA's
    Earth Science Data & Information Policy](https://www.earthdata.nasa.gov/engage/open-data-services-and-software/data-and-information-policy)
    for additional information.
  |||,
}
