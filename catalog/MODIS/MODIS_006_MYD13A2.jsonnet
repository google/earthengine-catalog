local id = 'MODIS/006/MYD13A2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD13A2_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD13A2.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD13A2.006 Aqua Vegetation Indices 16-Day Global 1km [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD13A2 V6 product provides two Vegetation Indices (VI): the Normalized
    Difference Vegetation Index (NDVI) and the Enhanced Vegetation Index (EVI).
    The NDVI is referred to as the continuity index to the existing National
    Oceanic and Atmospheric Administration-Advanced Very High Resolution
    Radiometer (NOAA-AVHRR) derived NDVI. The EVI has improved sensitivity over
    high biomass regions.

    The algorithm for this product chooses the best available
    pixel value from all the acquisitions from the 16-day period. The criteria
    used are low clouds, low view angle, and the highest NDVI/EVI value.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/103/MOD13_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/104/MOD13_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MYD13A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD13A2.006',
    },
  ] + version_config.version_links,
  keywords: [
    '16_day',
    'aqua',
    'evi',
    'global',
    'modis',
    'myd13a2',
    'nasa',
    'ndvi',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD13A2.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C194001218-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD13A2.006',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
