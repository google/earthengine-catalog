local id = 'AIRBUS/SPOT_2_4_5/BRAZIL/2007_2009/PAN/V1';
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
  title: 'SPOT 2, 4, 5 Brazil Panchromatic (PAN) V1',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  'gee:status': 'beta',
  description: importstr 'AIRBUS_SPOT_2_4_5_BRAZIL_2007_2009_PAN_V1_description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://developers.google.com/earth-engine/datasets/catalog/Earth_Engine_SPOT_542_Datasets_License.pdf'),
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'brazil',
    'forest-code',
    'spot',
    'airbus',
  ],
  providers: [
    ee.producer_provider('Airbus / CNES', 'https://www.airbus.com/en/products-solutions/defence/space/earth/observation'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(xmin=-74, ymin=-34, xmax=-34, ymax=6, start='2007-01-01T00:00:00Z', end='2009-11-26T23:59:59Z'),
  summaries: {
    'gee:schema': airbus.brazil_spot_schema,
    gsd: [
      5,
    ],
    'eo:bands': [
      {
        name: 'PAN',
        description: 'Panchromatic reflectance',
      },
    ],
    PAN: {minimum: 0, maximum: 255, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Panchromatic',
        lookat: {lon: -45.2603, lat: -19.5429, zoom: 12},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [200],
            bands: ['PAN'],
          },
        },
      },
    ],
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
