local id = 'UMN/PGC/ArcticDEM/V2/2m';
local successor_id = 'UMN/PGC/ArcticDEM/V3/2m';
local subdir = 'UMN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'ArcticDEM Strips [deprecated]',
  version: 'V2',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ArcticDEM is a digital surface model (DSM) that portrays first-return
    elevation values that include vegetation, tree canopy, buildings, and other
    man-made surface features. The 2m asset is a collection of strips rather
    than a single mosaic due to projection differences between strips.

    Strip DEM files correspond to the overlapping area of the input stereopair
    image swaths as they are collected by DigitalGlobe's constellation of
    polar-orbiting satellites. Strip DEM dimensions will vary according to the
    satellite sensor that acquired the images and the off-nadir angle of
    collection. Most strips are between 16km and 18km in width, and 110km and
    120km in length.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'arctic',
    'dem',
    'geophysical',
    'pgc',
    'umn',
  ],
  providers: [
    ee.producer_provider('University of Minnesota Polar Geospatial Center', 'https://www.pgc.umn.edu/data/arcticdem/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, 50.0, 180.0, 90.0,
                    '2009-08-16T00:00:00Z', '2017-03-12T00:00:00Z'),
  summaries: {
    gsd: [
      2.0,
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
          lat: 66.368,
          lon: -63.402,
          zoom: 7,
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
  'sci:citation': 'DEM(s) created by the Polar Geospatial Center from DigitalGlobe, Inc. imagery.',
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
