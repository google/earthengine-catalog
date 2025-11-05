# local id = 'GOOGLE/Research/oya-historical-nowcast/v1';
local id = 'projects/global-precipitation-nowcast/assets/precip_nowcast_12hr';
# projects_global_precipitation_nowcast_assets_precip_nowcast_12hr
local subdir = 'global-precipitation-nowcast';
local version = '1';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0; # TODO(b/415992925)

local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

# nowcast every 3 hours , the bands, bands per threshold
# W
{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Global Precipitation Nowcast V' + version,
  version: version,
  'gee:status':'beta',
  'gee:type': ee_const.gee_type.image_collection,
  # TODO(b/415993443)
  description: |||
    TODO
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    ee.link.license(spdx.odbl_1_0.reference),
  ],
  'gee:categories': ['climate'],
  keywords: [
    'global',
    'precipitation',
    'nowcast',
    'climate',
    'weather',
  ],
  providers: [
    ee.producer_provider('Google Research - Oya',
                         'https://blog.google/intl/en-africa/products/explore-get-answers/nowcasting-on-search-is-bringing-ai-powered-weather-forecasts-to-users-across-africa/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2020-01-01T07:00:00Z', '2025-04-30T23:30:00Z'),
  summaries: {
    gsd: [
      4,
    ],
    'gee:schema': [
      {
        name: 'forecast_target_time',
        description: |||
          The initialization time of the forecast. This is the same for all
          forecast hours within a single model run.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'forecast_seconds',
        description: |||
          The valid time for this specific forecast. Calculated as
          forecast_target_time + forecast_hour.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'ingestion_time_utc',
        description: |||
          The time when this forecast data became available in Earth Engine.
        |||,
        type: ee_const.var_type.double,
      }, #TODO(b/415995692)
      {
        name: 'timestamp',
        description: |||
          TODO
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'inference_home_type',
        description: |||
          TODO
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'job_start_utc',
        description: |||
          TODO
        |||,
        type: ee_const.var_type.double,
      },
    ],
    'eo:bands': [
      {
        name: "precip_200_um",
        description: |||
          Precipitation at a threshold of 200 $mu$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_400_um",
        description: |||
          Precipitation at a threshold of 300 $mu$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_1000_um",
        description: |||
          Precipitation at a threshold of 1 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_1600_um",
        description: |||
          Precipitation at a threshold of 1.6 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_2400_um",
        description: |||
          Precipitation at a threshold of 2.4 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_4000_um",
        description: |||
          Precipitation at a threshold of 4.0 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_5000_um",
        description: |||
          Precipitation at a threshold of 5.0 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_7000_um",
        description: |||
          Precipitation at a threshold of 7.0 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_10000_um",
        description: |||
          Precipitation at a threshold of 10 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_15000_um",
        description: |||
          Precipitation at a threshold of 15 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_25000_um",
        description: |||
          Precipitation at a threshold of 25 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_30000_um",
        description: |||
          Precipitation at a threshold of 30 $m$meters.
        |||,
        'gee:units': units.meter,
      },
      {
        name: "precip_type",
        description: |||
          bit Mask that indicates the type of precipitation, either rain, snowfall or hail.
        |||,
      },
          ],
    'gee:visualizations': [
      {
        display_name: 'Precipitation',
        lookat: {
          lat: 52.48,
          lon: 71.72,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0
            ],
            max: [
              50,
            ],
            palette: [
              '46EF00',  # brightest green
              '36BD01',  # bright green
              '1F7B00',  # green
              '145A01',  # dark green
              '0E4200',  # darkest green
              'FEFD03',  # yellow
              'F8CD02',  # dark yellow
              'FA8400',  # orange
              'd60024',  # red
              'd60024',  # red
              'd60024',  # red
              'd60024',  # red
            ],
            bands: [
              'precip_200_um',
              'precip_400_um',
              'precip_1000_um',
              'precip_1600_um',
              'precip_2400_um',
              'precip_4000_um',
              'precip_5000_um',
              'precip_7000_um',
              'precip_10000_um',
              'precip_15000_um',
              'precip_25000_um',
              'precip_30000_um',
            ],
          },
        },
      },
    ],
  },
  # TODO(b/415997850)
  'sci:citation': |||
    TODO
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license) + '\n\n' + |||
    TODO
  |||,
  'gee:user_uploaded': false,

}