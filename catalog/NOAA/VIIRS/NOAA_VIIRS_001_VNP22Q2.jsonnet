local id = 'NOAA/VIIRS/001/VNP22Q2';
local subdir = 'NOAA/VIIRS';

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
  title: 'VNP22Q2: Land Surface Phenology Yearly L3 Global 500m SIN Grid',
  version: 'V001',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Suomi National Polar-Orbiting Partnership (Suomi NPP) NASA Visible
    Infrared Imaging Radiometer Suite (VIIRS) Land Cover Dynamics data product
    provides global land surface phenology (GLSP) metrics at yearly intervals.
    The VNP22Q2 data product is derived from time series of the two-band
    Enhanced Vegetation Index (EVI2) calculated from VIIRS Nadir Bidirectional
    Reflectance Distribution Function (BRDF)-Adjusted Reflectance (NBAR).
    Vegetation phenology metrics at 500 meter spatial resolution are identified
    for up to two detected growing cycles per year.

    The product contains six phenological transition dates: onset of greenness
    increase, onset of greenness maximum, onset of greenness decrease, onset of
    greenness minimum, dates of mid-greenup, and senescence phases. The product
    also includes the growing season length. The greenness-related metrics
    consist of EVI2 onset of greenness increase, EVI2 onset of greenness
    maximum, EVI2 growing season, rate of greenness increase, and rate of
    greenness decrease. The confidence of phenology detection is provided as
    greenness agreement growing season, proportion of good quality (PGQ)
    growing season, PGQ onset greenness increase, PGQ onset greenness maximum,
    PGQ onset greenness decrease, and PGQ onset greenness minimum.
    The final layer is quality control specifying the overall quality of the
    product.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/637/VNP22_User_Guide_V1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/637/VNP22_User_Guide_V1.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/vnp22q2v001/)

    * [Land Product Quality Assessment website](https://landweb.modaps.eosdis.nasa.gov/NPP_QA/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP22Q2.001',
    },
  ],
  keywords: [
    'land',
    'nasa',
    'ndvi',
    'noaa',
    'npp',
    'phenology',
    'surface',
    'vegetation',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP22Q2.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1711966127-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2013-01-01T00:00:00Z', null),
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
        name: 'Date_Mid_Greenup_Phase',
        description: 'Date at a mid-greenup phase',
      },
      {
        name: 'Date_Mid_Senescence_Phase',
        description: 'Date at a mid-senescence phase',
      },
      {
        name: 'EVI2_Growing_Season_Area',
        description: 'Integrated EVI2 during a growing season',
      },
      {
        name: 'EVI2_Onset_Greenness_Increase',
        description: 'EVI2 value at greenup onset',
      },
      {
        name: 'EVI2_Onset_Greenness_Maximum',
        description: 'EVI2 value at maturity onset',
      },
      {
        name: 'GLSP_QC',
        description: 'Global Land Surface Phenology Quality Control',
        'gee:bitmask': {
          bitmask_parts: [
            {
              description: 'Mandatory Quality',
              bit_count: 3,
              values: [
                {
                  description: 'processed, good quality',
                  value: 0,
                },
                {
                  value: 1,
                  description: 'processed, other quality',
                },
                {
                  value: 2,
                  description: 'processed, backup algorithm',
                },
                {
                  value: 3,
                  description: 'not processed, bad quality',
                },
                {
                  value: 4,
                  description: 'not processed, other',
                },
              ],
              first_bit: 0,
            },
            {
              description: 'TBD',
              bit_count: 2,
              first_bit: 3,
            },
            {
              description: 'Land/Water mask',
              bit_count: 3,
              values: [
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
                  description: 'Ocean coastlines and lake shorelines',
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
              first_bit: 5,
            },
          ],
          total_bit_count: 8,
        },
      },
      {
        name: 'Greenness_Agreement_Growing_Season',
        description: 'EVI2 agreement between modeled values and raw observations',
      },
      {
        name: 'Growing_Season_Length',
        description: 'Growing Season Length',
      },
      {
        name: 'Onset_Greenness_Decrease',
        description: 'Date at which canopy greenness begins to decrease',
      },
      {
        name: 'Onset_Greenness_Increase',
        description: 'Date of onset of greenness increase',
      },
      {
        name: 'Onset_Greenness_Maximum',
        description: 'Date at which canopy greenness approaches its seasonal maximum',
      },
      {
        name: 'Onset_Greenness_Minimum',
        description: 'Date at which canopy greenness reaches a minimum',
      },
      {
        name: 'PGQ_Growing_Season',
        description: 'Proportion of good quality of VIIRS observations during a vegetation growing season',
      },
      {
        name: 'PGQ_Onset_Greenness_Decrease',
        description: 'Proportion of good quality around senescence onset',
      },
      {
        name: 'PGQ_Onset_Greenness_Increase',
        description: 'Proportion of good quality around greenup onset',
      },
      {
        name: 'PGQ_Onset_Greenness_Maximum',
        description: 'Proportion of good quality around maturity onset',
      },
      {
        name: 'PGQ_Onset_Greenness_Minimum',
        description: 'Proportion of good quality around dormancy onset',
      },
      {
        name: 'Rate_Greenness_Decrease',
        description: 'Rates of change in EVI2 values during a senescence phase',
      },
      {
        name: 'Rate_Greenness_Increase',
        description: 'Rates of change in EVI2 values during a greenup phase',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Default visualization',
        lookat: {
          lat: 27.808,
          lon: 95.571,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              10000.0,
            ],
            palette: [
              '000',
              '040',
              '080',
              '0B0',
              '0F0',
            ],
            bands: [
              'EVI2_Growing_Season_Area',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP22Q2.001',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
