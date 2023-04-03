local id = 'MODIS/055/MOD17A3';
local successor_id = 'MODIS/006/MOD17A3HGF';
local subdir = 'MODIS';
local units = import 'units.libsonnet';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD17A3.055: Terra Net Primary Production Yearly Global 1km [deprecated]',
  version: 'V055',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD17A3 V055 product provides information about
    annual Gross and Net Primary Productivity (NPP) at 1km pixel resolution.
    Net Primary Productivity (NPP) defines the rate at which all plants
    in an ecosystem produce net useful chemical energy.  In other words,
    NPP is equal to the difference between the rate at which plants
    in an ecosystem produce useful chemical energy (or GPP), and the
    rate at which they expend some of that energy for respiration.

    The version 055 of the NPP product is produced by the Numerical
    Terradynamic Simulation Group ([NTSG](https://www.ntsg.umt.edu)),
    University of Montana (UMT).  It corrects the problem with cloud-contaminated
    MODIS LAI-FPAR inputs to the MOD17 algorithm. The original, uncorrected
    datasets constitute the version 4 NPP products. For further details
    regarding the differences between the NTSG and NASA versions of
    this product, please consult [this document](https://lpdaac.usgs.gov/documents/188/MOD17_NTSG_Note.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'global',
    'gpp',
    'mod17a3',
    'modis',
    'npp',
    'photosynthesis',
    'productivity',
    'psn',
    'terra',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mod17a3'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2014-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      1000.0,
    ],
    platform: [
      'Terra',
    ],
    instruments: [
      'MODIS',
    ],
    'eo:bands': [
      {
        name: 'Gpp',
        description: 'Annual gross primary productivity',
        'gee:units': 'kg*C/m^2',
        'gee:scale': 0.0001,
      },
      {
        name: 'Npp',
        description: 'Annual net primary productivity',
        'gee:units': 'kg*C/m^2',
        'gee:scale': 0.0001,
      },
      {
        name: 'Gpp_Npp_QC',
        description: |||
          Percentage of filled MOD15 LAI caused by cloud-contamination
          during a growing season (defined when daily minimum air temperatures
          are above -8°) in a year. A high value indicates a high
          frequency of cloud-contamination. For example, QA is high for
          tropical rainforests but low in arid areas.
        |||,
        'gee:units': units.percent,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'NPP',
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              18000.0,
            ],
            palette: [
              'bbe029',
              '0a9501',
              '074b03',
            ],
            bands: [
              'Npp',
            ],
          },
        },
      },
    ],
    Gpp: {
      minimum: 0.0,
      maximum: 65500.0,
      'gee:estimated_range': false,
    },
    Npp: {
      minimum: 0.0,
      maximum: 65500.0,
      'gee:estimated_range': false,
    },
    Gpp_Npp_QC: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
