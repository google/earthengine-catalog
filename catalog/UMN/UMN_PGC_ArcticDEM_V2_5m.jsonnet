local id = 'UMN/PGC/ArcticDEM/V2/5m';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/ArcticDEM_5m_versions.libsonnet';

local subdir = 'UMN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'ArcticDEM Mosaic [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image,
  description: |||
    ArcticDEM is a digital surface model (DSM) that portrays first-return
    elevation values that include vegetation, tree canopy, buildings, and other
    man-made surface features. The 2m asset is a collection of strips rather
    than a single mosaic due to projection differences between strips.

    Mosaicked DEM files are compiled from the best quality strip DEM files
    which have been blended and feathered to reduce void areas and edge-matching
    artifacts. Filtered IceSAT altimetry data has been applied to the raster
    files to improve absolute accuracy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'arctic',
    'dem',
    'geophysical',
    'pgc',
    'umn',
  ],
  providers: [
    ee.producer_provider('University of Minnesota Polar Geospatial Center', 'https://www.pgc.umn.edu/data/arcticdem/'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent(-180.0, 50.0, 180.0, 90.0,
                    '2016-09-21T00:00:00Z', '2016-09-21T00:00:00Z'),
  summaries: {
    gsd: [
      5.0,
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
        'gee:units': units.meter,
      },
      {
        name: 'matchtag',
        description: |||
          Bitmask raster indicating DEM pixels derived from a stereo
          match (1) or those that have been interpolated (0)
        |||,
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
    elevation: {
      minimum: -416.45,
      maximum: 5971.24,
      'gee:estimated_range': true,
    },
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
