local id = 'UMN/PGC/ArcticDEM/V3/2m';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/ArcticDEM_2m_versions.libsonnet';

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
  title: 'ArcticDEM Strips',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ArcticDEM is a National Geospatial-Intelligence Agency (NGA) and National
    Science Foundation (NSF) public-private initiative to automatically produce
    a high-resolution, high-quality digital surface model (DSM) of the Arctic
    using optical stereo imagery, high-performance computing, and open source
    photogrammetry software. It includes vegetation, tree canopy, buildings, and
    other man-made surface features. The 2m asset is a collection of strips rather
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
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7910/DVN/OHHUKH',
    },
  ] + version_config.version_links,
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
        'gee:units': units.meter,
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
  'sci:doi': '10.7910/DVN/OHHUKH',
  'sci:citation': |||
    DEM(s) created by the Polar Geospatial Center from DigitalGlobe, Inc. imagery.
    Porter, Claire; Morin, Paul; Howat, Ian; Noh, Myoung-Jon; Bates, Brian;
    Peterman, Kenneth; Keesey, Scott; Schlenk, Matthew; Gardiner, Judith;
    Tomko, Karen; Willis, Michael; Kelleher, Cole; Cloutier, Michael; Husby, Eric;
    Foga, Steven; Nakamura, Hitomi; Platson, Melisa; Wethington, Michael, Jr.;
    Williamson, Cathleen; Bauer, Gregory; Enos, Jeremy; Arnold, Galen; Kramer, William;
    Becker, Peter; Doshi, Abhijit; D'Souza, Cristelle; Cummens, Pat; Laurier, Fabien;
    Bojesen, Mikkel, 2018, ArcticDEM, Harvard Dataverse, V1, [Date Accessed].
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
