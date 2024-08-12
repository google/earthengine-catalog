local id = 'NOAA/GOES/16/FDCC';
local subdir = 'NOAA';

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
  ],
  id: id,
  title: 'GOES-16 FDCC Series ABI Level 2 Fire/Hot Spot Characterization CONUS',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    [GOES](https://www.goes.noaa.gov) satellites are geostationary weather satellites run by NOAA.

    The Fire (HSC) product contains four images: one in the form
    of a fire mask and the other three with pixel values identifying fire temperature, fire area,
    and fire radiative power.

    The ABI L2+ FHS metadata mask assigns a flag to every earth-navigated pixel
    that indicates its disposition with respect to the FHS algorithm. Operational users who have
    the lowest tolerance for false alarms should focus on the "processed" and
    "saturated" categories (mask codes 10, 11, 30, and 31), but within these categories there
    can still be false alarms.

    [README](https://www.ncei.noaa.gov/products/satellite/goes-r)

    NOAA provides the following scripts for suggested categories,
    color maps, and visualizations:

     - [GOES-16-17_FireDetection.js](https://github.com/google/earthengine-community/blob/master/datasets/scripts/GOES-16-17_FireDetection.js)
     - [GOES-16-17_FireReclassification.js](https://github.com/google/earthengine-community/blob/master/datasets/scripts/GOES-16-17_FireReclassification.js)
  ||| + importstr 'general_satellite_messages_description.md',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://console.cloud.google.com/storage/browser/gcp-public-data-goes-16/ABI-L2-FDCC/',
    },
  ],
  keywords: [
    'abi',
    'climate',
    'fdc',
    'fire',
    'goes',
    'goes_16',
    'goes_east',
    'goes_r',
    'hotspot',
    'nesdis',
    'noaa',
    'ospo',
    'wildfire',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://data.noaa.gov/onestop/collections/details/d9303237-8672-4917-a251-29c3f7640684'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-152.11, 14.0, -49.18, 56.77, '2017-05-24T00:00:00Z', null),
  summaries: {
    gsd: [
      2000.0,
    ],
    'eo:bands': [
      {
        name: 'Area',
        description: 'Fire area',
        'gee:units': units.square_m,
        'gee:scale': 60.98,
        'gee:offset': 4000.0,
      },
      {
        name: 'Temp',
        description: 'Fire temperature',
        'gee:units': units.kelvin,
        'gee:scale': 0.05493667,
        'gee:offset': 400.0,
      },
      {
        name: 'Mask',
        description: |||
          Fire mask categories.  Pixel values in the fire mask image
          identify a fire category and diagnostic information associated
          with algorithm execution. The six fire categories include: Good
          quality or temporally filtered good quality fire pixel;
          Saturated fire pixel or temporally filtered saturated fire
          pixel; Cloud contaminated or temporally filtered cloud
          contaminated fire pixel; High probability or temporally filtered
          high probability fire pixel; Medium probability or temporally
          filtered high probability fire pixel; Low probability or
          temporally filtered high probability fire. Temporally filtered
          fire pixels are those resulting from fire pixels that are in
          close proximity in both space and time.
        |||,
        'gee:classes': [
          {
            value: 10,
            color: 'red',
            description: 'Processed fire',
          },
          {
            value: 11,
            color: 'white',
            description: 'Saturated fire',
          },
          {
            value: 12,
            color: 'slategray',
            description: 'Cloud contaminated fire',
          },
          {
            value: 13,
            color: 'orange',
            description: 'High probability fire',
          },
          {
            value: 14,
            color: 'violet',
            description: 'Medium probability fire',
          },
          {
            value: 15,
            color: 'blue',
            description: 'Low probability fire',
          },
          {
            value: 30,
            color: 'darkred',
            description: 'Processed fire, filtered',
          },
          {
            value: 31,
            color: 'ghostwhite',
            description: 'Saturated fire, filtered',
          },
          {
            value: 32,
            color: 'darkslategray',
            description: 'Cloud contaminated fire, filtered',
          },
          {
            value: 33,
            color: 'darkorange',
            description: 'High probability fire, filtered',
          },
          {
            value: 34,
            color: 'darkviolet',
            description: 'Medium probability fire, filtered',
          },
          {
            value: 35,
            color: 'darkblue',
            description: 'Low probability fire, filtered',
          },
        ],
      },
      {
        name: 'Power',
        description: 'Fire radiative power',
        'gee:units': units.megawatt,
      },
      {
        name: 'DQF',
        description: 'Data quality flags',
        'gee:classes': [
          {
            color: 'ffffff',
            description: 'Good quality fire',
            value: 0,
          },
          {
            value: 1,
            color: 'ff00ff',
            description: 'Good quality fire-free land',
          },
          {
            value: 2,
            color: '0000ff',
            description: 'Invalid due to opaque cloud',
          },
          {
            value: 3,
            color: '00ffff',
            description: 'Invalid due to surface type or sunglint or LZA threshold exceeded or off earth or missing input data',
          },
          {
            value: 4,
            color: 'ffff00',
            description: 'Invalid due to bad input data',
          },
          {
            value: 5,
            color: 'ff0000',
            description: 'Invalid due to algorithm failure',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Data Quality Flags (DQF)',
        lookat: {
          lon: -75.0,
          lat: 43.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              5.0,
            ],
            palette: [
              'blanchedalmond',
              'olive',
              'teal',
              'darkslateblue',
              'lemonchiffon',
              'burlywood',
            ],
            bands: [
              'DQF',
            ],
          },
        },
      },
    ],
    Area: {
      minimum: 0.0,
      maximum: 16723.0,
      'gee:estimated_range': true,
    },
    Temp: {
      minimum: 0.0,
      maximum: 32642.0,
      'gee:estimated_range': true,
    },
    Power: {
      minimum: 0.0,
      maximum: 200000.0,
      'gee:estimated_range': false,
    },
    DQF: {
      minimum: 0.0,
      maximum: 5.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Early characterization of the active fire detection products derived from the next generation
    NPOESS/VIIRS and GOES-R/ABI instruments.  Schroeder, W., Csiszar, I., et al, (2010), Early
    characterization of the active fire detection products derived from the next generation
    NPOESS/VIIRS and GOES-R/ABI instruments, paper presented at 2010 IEEE International Geoscience
    and Remote Sensing Symposium (IGARSS), Honolulu, HI.
    [doi:10.1109/IGARSS.2010.5650863](https://doi.org/10.1109/IGARSS.2010.5650863)
  |||,
  'sci:publications': [
    {
      citation: |||
        Schmit, T., Griffith, P., et al, (2016), A closer look at the ABI on the GOES-R series, Bull.
        Amer. Meteor. Soc., 98(4), 681-698.
        [doi:10.1175/BAMS-D-15-00230.1](https://doi.org/10.1175/BAMS-D-15-00230.1)
      |||,
      doi: '10.1175/BAMS-D-15-00230.1',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'minute',
    interval: 10,
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use.
  |||,
}
