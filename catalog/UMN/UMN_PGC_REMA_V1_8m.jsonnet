local id = 'UMN/PGC/REMA/V1/8m';
local subdir = 'UMN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'REMA Strips 8m',
  version: 'V1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Reference Elevation Model of Antarctica (REMA) is a high resolution,
    time-stamped Digital Surface Model (DSM) of Antarctica at 2-meter and 8-meter
    spatial resolutions.

    Strip DEM files correspond to the overlapping area of the input stereoscopic
    imagery pair strips as they are collected by DigitalGlobe's constellation
    of polar-orbiting satellites. Strip DEM dimensions will vary according to
    the satellite sensor that acquired the images and the off-nadir angle of
    collection. Most strips are between 13 km and 17 km in width, and 110 km
    and 120 km in length.
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
      'GeoEye-1',
      'WorldView-1',
      'WorldView-2',
      'WorldView-3',
    ],
    'eo:bands': [
      {
        name: 'elevation',
        description: 'Elevation',
        'gee:units': units.meters,
      },
      {
        name: 'matchtag',
        description: 'Bitmask raster indicating DEM pixels processing',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Pixel processing',
              bit_count: 1,
              values: [
                {
                  description: 'Pixels have been interpolated',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Pixels are derived from a stereo match',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 1,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lon: -63.16,
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
    National Science Foundation (PGC's primary funding source) policy requires
    researchers to acknowledge NSF support in all publications, web pages, and
    media interviews.

    By using PGC data in Earth Engine, users agree to cite PGC
    and its sponsorship by the NSF. The original source of any third-party data
    supplied by PGC must also be properly attributed.

    For more information see the PGC's
    [Acknowledgement Policy](https://www.pgc.umn.edu/guides/user-services/acknowledgement-policy/).
  |||,
}
