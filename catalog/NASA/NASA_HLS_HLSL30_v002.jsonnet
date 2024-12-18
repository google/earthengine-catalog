local id = 'NASA/HLS/HLSL30/v002';
local subdir = 'NASA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local hls = import 'NASA_HLS_v2.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'HLSL30: HLS-2 Landsat Operational Land Imager Surface Reflectance and TOA Brightness Daily Global 30m',
  version: hls.version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Harmonized Landsat Sentinel-2 (HLS) project provides consistent surface
    reflectance (SR) and top of atmosphere (TOA) brightness data from a virtual
    constellation of satellite sensors. The Operational Land Imager (OLI) is
    housed aboard the joint NASA/USGS Landsat 8 and Landsat 9 satellites, while
    the Multi-Spectral Instrument (MSI) is mounted aboard Europe's Copernicus
    Sentinel-2A and Sentinel-2B satellites. The combined measurement enables
    global observations of the land every 2 to 3 days at 30m spatial
    resolution.
  ||| + hls.common_description + |||

    * [General Documentation](https://lpdaac.usgs.gov/products/hlsl30v002/)
    * S30 catalog link: [NASA/HLS/HLSS30/v002](NASA_HLS_HLSS30_v002)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/HLS/HLSL30.002',
    },
  ],
  keywords: hls.keywords,
  providers: [
    ee.producer_provider('NASA LP DAAC', 'https://lpdaac.usgs.gov/products/hlsl30v002/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2021957657-LPCLOUD',
  ],
  extent: ee.extent_global('2013-04-11T00:00:00Z', null),
  summaries: {
    gsd: hls.gsd,
    instruments: hls.instruments,
    'gee:schema': [
      {
        name: 'ACCODE',
        description: 'LaSRC version, e.g. LaSRCS2AV3.5.5 or LaSRCL8V3.5.5',
        type: ee_const.var_type.string,
      },
      {
        name: 'LANDSAT_PRODUCT_ID',
        description: |||
          The Landsat-8 input L1 scene product ID for processing backtracing.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TIRS_SSM_MODEL',
        description: |||
          TIRS SSM encoder position model (Preliminary, Final or Actual).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'TIRS_SSM_POSITION_STATUS',
        description: 'L30',
        type: ee_const.var_type.string,
      },
      {
        name: 'USGS_SOFTWARE',
        description: 'LPGS_2.6.2',
        type: ee_const.var_type.string,
      },
    ] + hls.common_properties,
    'eo:bands': hls.rgb_bands + [
      {
        name: 'B5',
        description: 'NIR',
      },
      {
        name: 'B6',
        description: 'SWIR1',
      },
      {
        name: 'B7',
        description: 'SWIR2',
      },
      {
        name: 'B9',
        description: 'Cirrus',
      },
      {
        name: 'B10',
        description: 'TIRS1',
      },
      {
        name: 'B11',
        description: 'TIRS2',
      },
      {
        name: 'Fmask',
        description: 'Quality Bits',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Cirrus',
              bit_count: 1,
              values: [
                {
                  description: 'Reserved but not used',
                  value: 0,
                },
                {
                  description: 'Reserved but not used',
                  value: 1,
                },
              ],
              first_bit: 0,
            },
            {
              description: 'Cloud',
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
              first_bit: 1,
            },
            {
              description: 'Adjacent to cloud/shadow',
              first_bit: 2,
              bit_count: 1,
              values: [
                {
                  value: 0,
                  description: 'No',
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Cloud shadow',
              first_bit: 3,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Snow/ice',
              first_bit: 4,
              bit_count: 1,
              values: [
                {
                  description: ' No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Water',
              first_bit: 5,
              bit_count: 1,
              values: [
                {
                  description: 'No',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Yes',
                },
              ],
            },
            {
              description: 'Aerosol level',
              first_bit: 6,
              bit_count: 2,
              values: [
                {
                  description: 'Climatology aerosol',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'Low aerosol',
                },
                {
                  value: 2,
                  description: 'Moderate aerosol',
                },
                {
                  value: 3,
                  description: 'High aerosol',
                },
              ],
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'SZA',
        description: 'Sun Zenith Angle',
        'gee:units': units.degree,
      },
      {
        name: 'SAA',
        description: 'Sun Azimuth Angle',
        'gee:units': units.degree,
      },
      {
        name: 'VZA',
        description: 'View Zenith Angle',
        'gee:units': units.degree,
      },
      {
        name: 'VAA',
        description: 'View Azimuth Angle',
        'gee:units': units.degree,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'HLS L30 RGB bands',
        lookat: {
          lat: -5.467,
          lon: 141.74,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.01,
            ],
            max: [
              0.18,
            ],
            bands: ['B4', 'B3', 'B2'],
          },
        },
      },
    ],
  },
  'sci:citation': hls.citation,
  'gee:terms_of_use': hls.terms_of_use,
}
