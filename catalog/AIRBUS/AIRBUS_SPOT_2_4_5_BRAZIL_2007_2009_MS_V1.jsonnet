local id = 'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/MS/V1';
local subdir = 'AIRBUS';
local version = 'V1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local airbus = import 'airbus.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'SPOT 2, 4, 5 Brazil Multispectral (MS) V1',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description: importstr 'AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_MS_V1_description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf'),
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'brazil',
    'forest-code',
    'multispectral',
    'analysis',
    'spot',
    'airbus',
  ],
  providers: [
    ee.producer_provider('Airbus / CNES', 'https://www.airbus.com/en/products-solutions/defence/space/earth-observation'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(xmin=-74, ymin=-34, xmax=-34, ymax=6, start='2007-01-01T00:00:00Z', end='2009-11-26T23:59:59Z'),
  summaries: {
    'gee:schema': airbus.brazil_spot_schema,
    gsd: [
      10,
    ],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Green (0.50-0.59 µm)',
      },
      {
        name: 'B2',
        description: 'Red (0.61-0.68 µm)',
      },
      {
        name: 'B3',
        description: 'Near-Infrared (NIR) (0.78-0.89 µm)',
      },
      {
        name: 'SWIR',
        description: 'Shortwave IR (1.53-1.78 µm). Available for SPOT 4/5',
      },
    ],
    B1: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    B2: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    B3: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    SWIR: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Multispectral False Color (B3, B2, B1)',
        lookat: {lon: -45.2603, lat: -19.5429, zoom: 12},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [200],
            bands: ['B3', 'B2', 'B1'],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
