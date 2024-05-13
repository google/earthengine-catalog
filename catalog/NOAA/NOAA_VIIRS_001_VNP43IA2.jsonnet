local id = 'NOAA/VIIRS/001/VNP43IA2';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local quality_bands = ['I1', 'I2', 'I3'];

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
  title: 'VNP43IA2: BRDF/Albedo Quality Daily L3 Global 500m SIN Grid',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-Orbiting Partnership (Suomi NPP) NASA Visible
    Infrared Imaging Radiometer Suite (VIIRS) Bidirectional Reflectance
    Distribution Function (BRDF) and Albedo Quality (VNP43IA2) Version 1 product
    provides BRDF and Albedo quality at 500m resolution. The VNP43IA2
    product is produced daily using 16 days of VIIRS data and is weighted
    temporally to the ninth day, which is reflected in the file name.
    The VNP43IA2 product provides information regarding band quality and days
    of valid observation within a 16-day period for the VIIRS imagery bands.
    The VNP43 data products are designed to promote the continuity of
    NASA&apos;s Moderate Resolution Imaging Spectroradiometer (MODIS)
    BRDF/Albedo data product suite.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/viirs_user_guide/vnp43ia2_and_vnp43ma2_brdf_albedo_quality_product)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/194/VNP43_ATBD_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp43ia2v001/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/browse?sensor=VIIRS&sat=SNPP)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP43IA2.001',
    },
  ],
  keywords: [
    'land',
    'nasa',
    'noaa',
    'surface',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP43IA2.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1412449611-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2012-01-17T00:00:00Z', null),
  summaries: {
    gsd: [
      500.0,
    ],
    platform: [
      'Suomi NPP',
    ],
    instruments: [
      'VIIRS',
    ],
    'eo:bands': [
      {
        name: 'BRDF_Albedo_Band_Quality_' + band,
        description: 'BRDF inversion information ' + band,
        'gee:classes': [
          {
            description: |||
              best quality, full inversion (WoDs, RMSE majority good)
            |||,
            value: 0,
          },
          {
            value: 1,
            description: 'good quality, full inversion',
          },
          {
            value: 2,
            description: 'Magnitude inversion (numobs &ge; 7)',
          },
          {
            value: 3,
            description: 'Magnitude inversion (numobs &ge; 2 &amp; 7)',
          },
        ],
      }
      for band in quality_bands
    ] + [
      {
        name: 'BRDF_Albedo_LandWaterType',
        description: 'Land/Water type',
        'gee:classes': [
          {
            description: 'Shallow ocean',
            value: 0,
          },
          {
            value: 1,
            description: 'Land (Nothing else but land)',
          },
          {
            value: 2,
            description: 'Ocean and lake shorelines',
          },
          {
            value: 3,
            description: 'Shallow inland water',
          },
          {
            value: 4,
            description: 'Ephemeral water',
          },
          {
            value: 5,
            description: 'Deep inland water',
          },
          {
            value: 6,
            description: 'Moderate or continental ocean',
          },
          {
            value: 7,
            description: 'Deep ocean',
          },
        ],
      },
      {
        name: 'BRDF_Albedo_LocalSolarNoon',
        description: 'Solar zenith angle at local solar noon',
        'gee:units': units.degree,
      },
      {
        name: 'BRDF_Albedo_Platform',
        # TODO(kumaraashutosh): Describe this band in greater detail after the
        # provider responds with context.
        description: 'Platform name',
      },
      {
        name: 'BRDF_Albedo_Uncertainty',
        description: 'Weight of Determination (WoD) of WSA',
      },
    ] + [
      {
        name: 'BRDF_Albedo_ValidObs_' + band,
        description: |||
          Days of valid observation within 16-day period for band 
        ||| + band,
        'gee:units': units.day,
      }
      for band in quality_bands
    ] + [
      {
        name: 'Snow_BRDF_Albedo',
        description: 'Snow flag',
        'gee:classes': [
          {
            description: 'snow-free albedo retrieved',
            value: 0,
          },
          {
            value: 1,
            description: 'snow albedo retrieved',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Days of valid observation for band I1',
        lookat: {
          lat: 89,
          lon: 58,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              35550,
            ],
            max: [
              45535,
            ],
            palette: [
              '000080',
              '0000d9',
              '4000ff',
              '8000ff',
              '0080ff',
              '00ffff',
              '00ff80',
              '80ff00',
              'daff00',
              'ffff00',
              'fff500',
              'ffda00',
              'ffb000',
              'ffa400',
              'ff4f00',
              'ff2500',
              'ff0a00',
              'ff00ff',
            ],
            bands: [
              'BRDF_Albedo_ValidObs_I1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP43IA2.001',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
