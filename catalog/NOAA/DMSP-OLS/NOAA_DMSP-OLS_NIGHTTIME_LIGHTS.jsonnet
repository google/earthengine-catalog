local id = 'NOAA/DMSP-OLS/NIGHTTIME_LIGHTS';
local subdir = 'NOAA/DMSP-OLS';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'DMSP OLS: Nighttime Lights Time Series Version 4, Defense Meteorological Program Operational Linescan System',
  version: 'Version 4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Defense Meteorological Program (DMSP) Operational Line-Scan System
    (OLS) has a unique capability to detect visible and near-infrared (VNIR)
    emission sources at night.

    Version 4 of the DMSP-OLS Nighttime Lights Time Series consists of
    cloud-free composites made using all the available archived DMSP-OLS smooth
    resolution data for calendar years. In cases where two satellites were
    collecting data, two composites were produced.

    Image and data processing by NOAA's National Geophysical Data Center.
    DMSP data collected by US Air Force Weather Agency.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'dmsp',
    'eog',
    'imagery',
    'lights',
    'nighttime',
    'ols',
    'visible',
    'yearly',
  ],
  providers: [
    ee.producer_provider('Earth Observation Group, Payne Institute for Public Policy, Colorado School of Mines', 'https://eogdata.mines.edu/dmsp/downloadV4composites.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -65.0, 180.0, 75.0,
                    '1992-01-01T00:00:00Z', '2014-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'avg_vis',
        description: 'The average of the visible band digital number values with no further filtering.',
      },
      {
        name: 'stable_lights',
        description: |||
          The cleaned up avg_vis contains the lights from cities,
          towns, and other sites with persistent lighting, including gas flares.
          Ephemeral events, such as fires, have been discarded. The background noise
          was identified and replaced with values of zero.
        |||,
      },
      {
        name: 'cf_cvg',
        description: |||
          Cloud-free coverages tally the total number of observations
          that went into each 30-arc second grid cell. This band can be used to
          identify areas with low numbers of observations where the quality is
          reduced.
        |||,
      },
      {
        name: 'avg_lights_x_pct',
        description: |||
          The average visible band digital number (DN) of cloud-free
          light detections multiplied by the percent frequency of light detection.
          The inclusion of the percent frequency of detection term normalizes the
          resulting digital values for variations in the persistence of lighting.
          For instance, the value for a light only detected half the time is
          discounted by 50%. Note that this product contains detections from fires
          and a variable amount of background noise.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Nighttime Lights',
        lookat: {
          lat: 49.1,
          lon: 7.82,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              3.0,
            ],
            max: [
              60.0,
            ],
            bands: [
              'avg_vis',
            ],
          },
        },
      },
    ],
    avg_vis: {
      minimum: 0.0,
      maximum: 63.0,
      'gee:estimated_range': true,
    },
    stable_lights: {
      minimum: 0.0,
      maximum: 63.0,
      'gee:estimated_range': true,
    },
    cf_cvg: {
      minimum: 0.0,
      maximum: 126.0,
      'gee:estimated_range': true,
    },
    avg_lights_x_pct: {
      minimum: 0.0,
      maximum: 63.0,
      'gee:estimated_range': true,
    },
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution.
  |||,
}
