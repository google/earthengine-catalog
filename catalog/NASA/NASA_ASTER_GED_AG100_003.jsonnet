local id = 'NASA/ASTER_GED/AG100_003';
local subdir = 'NASA';

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
  title: 'AG100: ASTER Global Emissivity Dataset 100-meter V003',
  version: 'V003',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Advanced Spaceborne Thermal Emission and Reflection Radiometer Global
    Emissivity Database (ASTER-GED) was developed by the National Aeronautics
    and Space Administration's (NASA) Jet Propulsion Laboratory (JPL),
    California Institute of Technology. This product includes the mean
    emissivity and standard deviation for all 5 ASTER Thermal Infrared bands,
    mean land surface temperature (LST) and standard deviation, a re-sampled
    ASTER GDEM, land-water mask, mean Normalized Difference Vegetation Index
    (NDVI) and standard deviation, and observation count.

    ASTER-GED land surface temperature and emissivity (LST&E) are generated
    using the ASTER Temperature Emissivity Separation (TES) algorithm in
    combination with a Water Vapor Scaling (WVS) atmospheric correction method
    using MODIS MOD07 atmospheric profiles and the MODTRAN 5.2 radiative
    transfer model.

    This product was derived from clear-sky pixels for all available ASTER data
    (2000-2008).

    [User's Guide] (https://lpdaac.usgs.gov/documents/120/ASTERGED_User_Guide_V3.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/COMMUNITY/ASTER_GED/AG100.003',
    },
  ],
  keywords: [
    'aster',
    'caltech',
    'elevation',
    'emissivity',
    'ged',
    'geophysical',
    'infrared',
    'jpl',
    'lst',
    'nasa',
    'ndvi',
    'temperature',
    'thermal',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/COMMUNITY/ASTER_GED/AG100.003'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000362-LPDAAC_ECS',
  ],
  extent: ee.extent(-180.0, -59.0, 180.0, 80.0,
                    '2000-01-01T00:00:00Z', '2008-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'emissivity_band10',
        description: 'Mean band 10',
        'gee:scale': 0.001,
      },
      {
        name: 'emissivity_band11',
        description: 'Mean band 11',
        'gee:scale': 0.001,
      },
      {
        name: 'emissivity_band12',
        description: 'Mean band 12',
        'gee:scale': 0.001,
      },
      {
        name: 'emissivity_band13',
        description: 'Mean band 13',
        'gee:scale': 0.001,
      },
      {
        name: 'emissivity_band14',
        description: 'Mean band 14',
        'gee:scale': 0.001,
      },
      {
        name: 'emissivity_sdev_band10',
        description: 'Standard deviation band 10',
        'gee:scale': 0.0001,
      },
      {
        name: 'emissivity_sdev_band11',
        description: 'Standard deviation band 11',
        'gee:scale': 0.0001,
      },
      {
        name: 'emissivity_sdev_band12',
        description: 'Standard deviation band 12',
        'gee:scale': 0.0001,
      },
      {
        name: 'emissivity_sdev_band13',
        description: 'Standard deviation band 13',
        'gee:scale': 0.0001,
      },
      {
        name: 'emissivity_sdev_band14',
        description: 'Standard deviation band 14',
        'gee:scale': 0.0001,
      },
      {
        name: 'temperature',
        description: 'Temperature mean',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
      },
      {
        name: 'temperature_sdev',
        description: 'Temperature standard deviation',
        'gee:units': units.kelvin,
        'gee:scale': 0.01,
      },
      {
        name: 'ndvi',
        description: 'NDVI mean',
        'gee:scale': 0.01,
      },
      {
        name: 'ndvi_sdev',
        description: 'NDVI standard deviation',
        'gee:scale': 0.01,
      },
      {
        name: 'elevation',
        description: 'ASTER Global Digital Elevation Model V002',
        'gee:units': units.meter,
      },
      {
        name: 'land_water_map',
        description: 'Land water map',
        'gee:classes': [
          {
            value: 1,
            color: 'brown',
            description: 'Land',
          },
          {
            value: 2,
            color: 'blue',
            description: 'Water',
          },
        ],
      },
      {
        name: 'num_obs',
        description: 'Number of observations',
        'gee:units': 'Number per pixel',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 37.72,
          lon: 89.12,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              -15.0,
            ],
            max: [
              5000.0,
            ],
            palette: [
              '0602ff',
              '235cb1',
              '307ef3',
              '269db1',
              '30c8e2',
              '32d3ef',
              '3ae237',
              'b5e22e',
              'd6e21f',
              'fff705',
              'ffd611',
              'ffb613',
              'ff8b13',
              'ff6e08',
              'ff500d',
              'ff0000',
              'de0101',
              'c21301',
            ],
            bands: [
              'elevation',
            ],
          },
        },
      },
    ],
    emissivity_band10: {
      minimum: 0.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_band11: {
      minimum: 0.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_band12: {
      minimum: 0.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_band13: {
      minimum: 0.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_band14: {
      minimum: 0.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_sdev_band10: {
      minimum: -1000.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_sdev_band11: {
      minimum: -1000.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_sdev_band12: {
      minimum: -1000.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_sdev_band13: {
      minimum: -1000.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    emissivity_sdev_band14: {
      minimum: -1000.0,
      maximum: 1000.0,
      'gee:estimated_range': false,
    },
    temperature: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    temperature_sdev: {
      minimum: 0.0,
      maximum: 65535.0,
      'gee:estimated_range': false,
    },
    ndvi: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    ndvi_sdev: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    elevation: {
      minimum: -500.0,
      maximum: 9000.0,
      'gee:estimated_range': false,
    },
    num_obs: {
      minimum: 0.0,
      maximum: 120.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.5067/COMMUNITY/ASTER_GED/AG100.003',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:terms_of_use': |||
    ASTER data and products distributed by the LP DAAC, with the exception of
    the ASTER Global Digital Elevation Model (GDEM) dataset (ASTGTM) version 2
    (v2), have no restrictions on data use, sale, or subsequent redistribution.
    For more information visit the
    [ASTER Policies](https://lpdaac.usgs.gov/data/data-citation-and-policies/) site.
  |||,
}
