local id = 'UMN/PGC/REMA/V1_1/8m';
local subdir = 'UMN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'REMA Mosaic',
  version: 'V1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Reference Elevation Model of Antarctica (REMA) is a high resolution,
    time-stamped Digital Surface Model (DSM) of Antarctica at 2-meter and 8-meter
    spatial resolutions.

    Mosaicked DEM files are compiled from multiple strips that have been
    co-registered, blended, and feathered to reduce edge-matching artifacts.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5194/tc-13-665-2019',
    },
  ],
  keywords: [
    'dem',
    'geophysical',
    'pgc',
    'rema',
    'umn',
  ],
  providers: [
    ee.producer_provider('University of Minnesota Polar Geospatial Center', 'https://www.pgc.umn.edu/data/arcticdem/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -88.3, 180.0, -53.8,
                    '2009-01-01T00:00:00Z', '2018-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      8.0,
    ],
    platform: [
      'WorldView-1',
      'WorldView-2',
      'WorldView-3',
      'GeoEye-1',
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
          lon: -61.0,
          lat: -75.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              -50.0,
            ],
            max: [
              1000.0,
            ],
            palette: [
              '0d13d8',
              '60e1ff',
              'ffffff',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5194/tc-13-665-2019',
  'sci:citation': |||
    Howat, I. M., Porter, C., Smith, B. E., Noh, M.-J., and Morin, P.:
    The Reference Elevation Model of Antarctica, The Cryosphere, 13, 665-674, 2019.
  |||,
  'gee:terms_of_use': |||
    National Science Foundation (PGC’s primary funding source) policy requires
    researchers to acknowledge NSF support in all publications, web pages, and
    media interviews.

    By using PGC data in Earth Engine, users agree to cite PGC
    and its sponsorship by the NSF. The original source of any third-party data
    supplied by PGC must also be properly attributed.

    For more information see the PGC's
    [Acknowledgement Policy](https://www.pgc.umn.edu/guides/user-services/acknowledgement-policy/).
  |||,
}
