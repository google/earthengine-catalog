local id = 'UMT/NTSG/v2/LANDSAT/GPP';
local subdir = 'UMT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'Landsat Gross Primary Production CONUS',
  version: '0.2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Landsat Gross Primary Production (GPP) CONUS dataset estimates GPP using
    Landsat Surface Reflectance for CONUS. GPP is the amount of
    carbon captured by plants in an ecosystem and is an essential component in
    the calculations of Net Primary Production (NPP). GPP is calculated using the
    MOD17 algorithm (see [MOD17 User
    Guide](https://www.ntsg.umt.edu/files/modis/MOD17UsersGuide2015_v3.pdf)) with
    Landsat Surface Reflectance, gridMET, and the National Land Cover Database.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['plant-productivity'],
  keywords: [
    '16_day',
    'conus',
    'gpp',
    'gridmet_derived',
    'landsat',
    'mod17',
    'nlcd_derived',
    'photosynthesis',
    'production',
    'productivity',
  ],
  providers: [
    ee.producer_provider('University of Montana Numerical Terradynamic Simulation Group (NTSG)', 'https://www.ntsg.umt.edu/project/landsat/landsat-productivity.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-124.84, 24.42, -64.82, 49.72,
                    '1986-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      30.0,
    ],
    platform: [
      'Landsat 5',
      'Landsat 7',
      'Landsat 8',
    ],
    instruments: [
      'ETM',
      'ETM+',
      'OLI',
    ],
    'eo:bands': [
      {
        name: 'GPP',
        description: '16-day gross primary production',
        'gee:units': 'kg*C/m^2/16-day',
        'gee:scale': 0.0001,
      },
      {
        name: 'QC',
        description: 'Indicates the quality of the Landsat NDVI pixel used in the GPP Calculation',
        'gee:classes': [
          {
            value: 10,
            color: 'e6194b',
            description: 'Clear not smoothed',
          },
          {
            value: 11,
            color: '3cb44b',
            description: 'Clear smoothed',
          },
          {
            value: 20,
            color: 'ffe119',
            description: 'Snow or water not smoothed',
          },
          {
            value: 21,
            color: '4363d8',
            description: 'Snow or water smoothed',
          },
          {
            value: 30,
            color: 'f58231',
            description: 'Climatology not smoothed',
          },
          {
            value: 31,
            color: '911eb4',
            description: 'Climatology smoothed',
          },
          {
            value: 40,
            color: '46f0f0',
            description: 'Gap filled not smoothed',
          },
          {
            value: 41,
            color: 'f032e6',
            description: 'Gap filled smoothed',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'GPP',
        lookat: {
          lat: 37.07,
          lon: -94.83,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              1000.0,
            ],
            palette: [
              'bbe029',
              '0a9501',
              '074b03',
            ],
            bands: [
              'GPP',
            ],
          },
        },
      },
    ],
    GPP: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Robinson, N.P., B.W. Allred, W.K. Smith, M.O. Jones, A. Moreno, T.A.
    Erickson, D.E. Naugle, and S.W. Running. 2018. Terrestrial primary
    production for the conterminous United States derived from Landsat 30 m and
    MODIS 250 m. Remote Sensing in Ecology and Conservation.
    [doi:10.1002/rse2.74](https://doi.org/10.1002/rse2.74)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': |||
    This work is in the public domain and is free of known copyright
    restrictions. Users should properly cite the source used in the creation of
    any reports and publications resulting from the use of this dataset and note
    the date when the data was acquired.
  |||,
  'gee:user_uploaded': true,
}
