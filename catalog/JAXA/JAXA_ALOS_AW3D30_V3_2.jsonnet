local id = 'JAXA/ALOS/AW3D30/V3_2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/AW3D30_versions.libsonnet';

local subdir = 'JAXA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary {
  reference: 'https://earth.jaxa.jp/en/data/policy/',
};

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'ALOS DSM: Global 30m  v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    ALOS World 3D - 30m (AW3D30) is a global digital surface
    model (DSM) dataset with a horizontal resolution of approximately
    30 meters (1 arcsec mesh). The dataset is based on the DSM dataset
    (5-meter mesh version) of the [World 3D Topographic Data](https://www.aw3d.jp/en/).
    More details are available in the dataset [documentation](https://www.eorc.jaxa.jp/ALOS/en/aw3d30/aw3d30v11_format_e.pdf).

    Version 3.2, released in January 2021, is an improved version created by reconsidering
    the format in the high latitude area, auxiliary data, and processing method. Different pixel
    spacing for each latitude zone was adopted at high latitude area. Coastline data, which is one
    of the auxiliary datasets, was changed, and new supplementary data was used. In addition, as a
    source data for Japan, AW3D version 3 was also used. Furthermore, the method of detecting
    anomalous values in the process was improved.

    Note: See the code example for the recommended way of computing slope.
    Unlike most DEMs in Earth Engine, this is an image collection due to
    multiple resolutions of source files that make it impossible to mosaic them
    into a single asset, so the slope computations need a reprojection.

    The AW3D DSM elevation is calculated by an image matching process
    that uses a stereo pair of optical images. Clouds, snow, and ice are
    automatically identified during processing and applied the
    mask information. However, mismatched points sometimes
    remain especially surrounding (or at the edges of) clouds, snow,
    and ice areas, which cause some height errors in the final DSM.

    Here are some example areas with data values outside of valid elevation
    range. Impossibly low negative values are concentrated in Antarctica around
    (-63.77, -61.660), (-77.22, -150.27), and (-73.29, 168.14); in Indonesia
    around (-5.36, 134.55); in Brazil around (-1.667113844, -50.6269684);
    and in Peru around (-10.45048137, -75.39459876) with approximate values of
    -1013, -998, -635, and -610 respectively. Impossibly high
    positive values are found in several locations in the Arctic around
    (79.83, -77.67) and (69.54, -75.42); in Fiji around (-16.58, 179.44)
    and (-18.96, 178.39); and in Nepal around (28.50, 84.56) with
    approximate values of 15369, 15213, and 10900 respectively.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ] + version_config.version_links,
  keywords: [
    'alos',
    'dem',
    'elevation',
    'geophysical',
    'jaxa',
    'topography',
  ],
  providers: [
    ee.producer_provider('JAXA Earth Observation Research Center', 'https://www.eorc.jaxa.jp/ALOS/en/dataset/aw3d30/aw3d30_e.htm'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2006-01-24T00:00:00Z', '2011-05-12T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'DSM',
        description: |||
          Height above sea level. Signed 16 bits.
          Elevation (in meter) converted from the ellipsoidal height based on ITRF97
          and GRS80, using EGM96&#8224;1 geoid model.
        |||,
      },
      {
        name: 'STK',
        description: |||
          Stacking number of the scene unit DSM used in producing
          DSM. The band is derived by resampling the stacking number for
          5m resolution DSM to 30m resolution.
        |||,
      },
      {
        name: 'MSK',
        description: '8-bit mask for the band.',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Generated from resampled DSM.',
              bit_count: 8,
              values: [
                {
                  description: 'Valid',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Cloud and snow mask (invalid).',
                },
                {
                  value: 2,
                  description: 'Land water and low correlation mask (valid).',
                },
                {
                  value: 3,
                  description: 'Sea mask (valid).',
                },
                {
                  value: 4,
                  description: 'Void filled with GSI DTM (valid).',
                },
                {
                  value: 8,
                  description: 'Void filled with Shuttle Radar Topography Mission\nSRTM-1 Version 3 (valid).',
                },
                {
                  value: 12,
                  description: 'Void filled with PRISM DSM (valid).',
                },
                {
                  value: 16,
                  description: 'Void filled with ViewFinder Panoramas DEM (valid).',
                },
                {
                  value: 24,
                  description: 'Void filled with ASTER GDEM v2 (valid).',
                },
                {
                  value: 28,
                  description: 'Void filled with ArcticDEM v2 (valid).',
                },
                {
                  value: 32,
                  description: 'Void filled with TanDEM-X 90m DEM (valid).',
                },
                {
                  value: 36,
                  description: 'Void filled with ArcticDEM v3 (valid).',
                },
                {
                  value: 40,
                  description: 'Void filled with ASTER GDEM v3 (valid).',
                },
                {
                  value: 44,
                  description: 'Void filled with REMA v1.1 (valid).',
                },
                {
                  value: 252,
                  description: 'Void filled with applied IDW method (gdal_fillnodata) (valid)',
                },
              ],
              first_bit: 0,
            },
          ],
          total_bit_count: 8,
        },
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 37.37,
          lon: 136.85,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              5000.0,
            ],
            palette: [
              '0000ff',
              '00ffff',
              'ffff00',
              'ff0000',
              'ffffff',
            ],
            bands: [
              'DSM',
            ],
          },
        },
      },
    ],
    DSM: {
      minimum: -433.0,
      maximum: 8768.0,
      'gee:estimated_range': true,
    },
    STK: {
      minimum: 1.0,
      maximum: 54.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    T. Tadono, H. Ishida, F. Oda, S. Naito, K. Minakawa, H. Iwamoto
    : Precise Global DEM Generation By ALOS PRISM, ISPRS Annals of
    the Photogrammetry, Remote Sensing and Spatial Information Sciences,
    Vol.II-4, pp.71-76, 2014. [PDF file](https://www.isprs-ann-photogramm-remote-sens-spatial-inf-sci.net/II-4/71/2014/isprsannals-II-4-71-2014.pdf)
  |||,
  'sci:publications': [
    {
      citation: |||
        J. Takaku, T. Tadono, K. Tsutsui : Generation of High Resolution
        Global DSM from ALOS PRISM, The International Archives of the Photogrammetry,
        Remote Sensing and Spatial Information Sciences, Vol. XL-4, pp.243-248,
        ISPRS, 2014. [PDF file](https://www.int-arch-photogramm-remote-sens-spatial-inf-sci.net/XL-4/243/2014/isprsarchives-XL-4-243-2014.pdf)
      |||,
    },
    {
      citation: |||
        J. Takaku, T. Tadono, K. Tsutsui, M. Ichikawa : Validation of
        'AW3D' Global DSM Generated from ALOS PRISM, ISPRS
        Annals of the Photogrammetry, Remote Sensing and Spatial Information
        Sciences, Vol.III-4, pp.25-31, 2016. [PDF file](https://www.isprs-ann-photogramm-remote-sens-spatial-inf-sci.net/III-4/25/2016/isprs-annals-III-4-25-2016.pdf)
      |||,
    },
    {
      citation: |||
        T. Tadono, H. Nagai, H. Ishida, F. Oda, S. Naito, K. Minakawa,
        H. Iwamoto : Initial Validation of the 30 m-mesh Global Digital
        Surface Model Generated by ALOS PRISM, The International Archives
        of the Photogrammetry, Remote Sensing and Spatial Information Sciences,
        ISPRS, Vol. XLI-B4, pp.157-162, 2016. [PDF file](https://www.int-arch-photogramm-remote-sens-spatial-inf-sci.net/XLI-B4/157/2016/isprs-archives-XLI-B4-157-2016.pdf)
      |||,
    },
  ],
  'gee:terms_of_use': |||
    This dataset is available to use with no charge under
    the conditions specified in the [Terms of use for ALOS Global Digital
    Surface Model](https://earth.jaxa.jp/en/data/policy/).
  |||,
}
