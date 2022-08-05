local id = 'NRCan/CDEM';
local subdir = 'NRCan';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.ogl_canada_2_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'Canadian Digital Elevation Model',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Canadian Digital Elevation Model (CDEM) is part of Natural Resources
    Canada's (NRCan) altimetry system and stems from the existing Canadian
    Digital Elevation Data (CDED). In these data, elevations can be either
    ground or reflective surface elevations.

    The CDEM is comprised of multiple DEMs with varying resolutions. These
    vary according to latitude and have a base resolution of 0.75 arc-seconds.
    For more information see the [Product Specifications](https://ftp.geogratis.gc.ca/pub/nrcan_rncan/elevation/cdem_mnec/doc/CDEM_product_specs.pdf)

    Contains information licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://open.canada.ca/en/open-government-licence-canada'),
    {
      rel: ee_const.rel.source,
      href: 'https://ftp.geogratis.gc.ca/pub/nrcan_rncan/elevation/cdem_mnec/',
    },
  ],
  keywords: [
    'canada',
    'cdem',
    'dem',
    'elevation',
    'geophysical',
    'nrcan',
    'topography',
  ],
  providers: [
    ee.producer_provider('NRCan', 'https://open.canada.ca/data/en/dataset/7f245e4d-76c2-4caa-951a-45d1d2051333'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-142.0, 41.0, -52.0, 84.0,
                    '1945-01-01T00:00:00Z', '2011-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      23.19,
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': 'm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 63.3213,
          lon: -139.3643,
          zoom: 9,
        },
        image_visualization: {
          band_vis: {
            min: [
              -50.0,
            ],
            max: [
              1500.0,
            ],
            palette: [
              '0905ff',
              'ffefc4',
              'ffffff',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    elevation: {
      minimum: -226.0,
      maximum: 5944.0,
      'gee:estimated_range': true,
    },
  },
  'gee:terms_of_use': |||
    Licensed under the
    [Open Government Licence - Canada](https://open.canada.ca/en/open-government-licence-canada).
  |||,
}
