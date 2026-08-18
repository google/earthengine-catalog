local id = 'USDA/SOLUS100/V0';
local subdir = 'USDA';

local ee_const = import '../earthengine_const.libsonnet';
local ee = import '../earthengine.libsonnet';
local spdx = import '../spdx.libsonnet';
local units = import '../units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local band_group(depth) = [
  {
    name: 'r_%s_cm_p' % depth,
    description: 'Predicted value of soil property at %scm depth' % depth,
  },
  {
    name: 'r_%s_cm_l' % depth,
    description:
      'Lower 95%% confidence limit of soil property at %scm depth' % depth,
  },
  {
    name: 'r_%s_cm_h' % depth,
    description:
      'Upper 95%% confidence limit of soil property at %scm depth' % depth,
  },
  {
    name: 'r_%s_cm_rpi' % depth,
    description:
      'Relative property index of soil property at %scm depth' % depth,
  },
];

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'SOLUS: Soil properties of the conterminous United States at 100-m resolution',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    SOLUS (Soil Landscapes of the United States) is a national map product
    developed by the National Cooperative Soil Survey that is focused on
    providing a consistent set of spatially continuous soil property maps to
    support large scope soil investigations and land use decisions. SOLUS maps
    use a digital soil mapping framework that combines multiple sources of soil
    survey data with environmental covariate data and machine learning.
    SOLUS100 is 100 m spatial resolution. Each 100 m raster cell represents
    a 100 m by 100 m square on the ground with soil property values
    estimated at seven depths: 0, 5, 15, 30, 60, 100, and 150 cm.

    It provides estimates for soil organic carbon, bulk density, pH,
    texture fractions (clay, silt, sand), calcium carbonate equivalent,
    and depth to an anylithic contact (e.g. bedrock).

    Each soil property is represented by a separate image in this collection.
    For each soil property except depth to anylithic contact, bands are
    provided for 7 depths: 0, 5, 15, 30, 60, 100, and 150cm. For each depth,
    4 layers are provided: predicted value, lower 95% confidence limit,
    upper 95% confidence limit, and a relative property index.
    For depth to anylithic contact, a single image provides the 4 layers
    representing depth in cm.

    Image IDs correspond to soil properties:

    *   `soc`: Soil organic carbon (%)
    *   `bd`: Bulk density (g/cm^3)
    *   `phh2o`: pH in water
    *   `claytotal`: Clay (%)
    *   `silttotal`: Silt (%)
    *   `sandtotal`: Sand (%)
    *   `caco3`: Calcium Carbonate (%)
    *   `anylithicdpt`: Depth to an Anylithic Contact (cm)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['soil'],
  keywords: [
    'soil',
    'usda'
  ],
  providers: [
    ee.producer_provider(
      'USDA-ARS',
      'https://www.nrcs.usda.gov/resources/data-and-reports/soil-landscapes-of-the-united-states-solus'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: {
    spatial: {
      bbox: [
        [-125, 24, -66, 50],
      ],
    },
    temporal: {
      interval: [
        ['2023-12-15T00:00:00Z', '2024-01-01T00:00:00Z'],
      ],
    },
  },
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': std.flattenArrays([band_group(x) for x in [0, 5, 15, 30, 60, 100, 150]]) + [
      {
        name: 'r_cm_p',
        description: |||
          Predicted depth to anylithic contact in cm
        |||,
        'gee:units': units.centimeter,
      },
      {
        name: 'r_cm_l',
        description: |||
          Lower 95% confidence limit of depth to anylithic contact in cm
        |||,
        'gee:units': units.centimeter,
      },
      {
        name: 'r_cm_h',
        description: |||
          Upper 95% confidence limit of depth to anylithic contact in cm
        |||,
        'gee:units': units.centimeter,
      },
      {
        name: 'r_cm_rpi',
        description: |||
          Relative property index of depth to anylithic contact
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil Organic Carbon',
        lookat: {
          lat: 38,
          lon: -95,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [0],
            max: [2000],
            bands: ['r_0_cm_p'],
          },
          image_id: ['USDA/SOLUS100/V0/soc'],
        },
      },
    ],
  },
  'gee:terms_of_use': |||
    The SOLUS dataset is in the public domain and is available without
    restriction on use or distribution.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'sci:doi': '10.1002/saj2.20769',
  'sci:citation': |||
    Nauman, T. W., Kienast-Brown, S., Roecker, S. M., Brungard, C., White,
    D., Philippe, J., & Thompson, J. A. (2024). Soil landscapes of the
    United States (SOLUS): developing predictive soil property maps of the
    conterminous United States using hybrid training sets. Soil Science
    Society of America Journal, 1-20.
    [doi:10.1002/saj2.20769](https://doi.org/10.1002/saj2.20769)
  |||
}
