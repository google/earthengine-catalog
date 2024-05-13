local id = 'MODIS/061/MYD10A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD10A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD10A1.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD10A1.061 Aqua Snow Cover Daily Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD10A1 V6 Snow Cover Daily Global 500m product
    contains snow cover, snow albedo, fractional snow cover, and quality
    assessment (QA) data. Snow cover data are based on a snow mapping
    algorithm that employs a Normalized Difference Snow Index (NDSI)
    and other criteria tests.

    [General documentation](https://doi.org/10.5067/MODIS/MYD10A1.061)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD10A1.061',
    },
  ] + version_config.version_links,
  keywords: [
    'albedo',
    'aqua',
    'daily',
    'geophysical',
    'global',
    'modis',
    'myd10a1',
    'nasa',
    'nsidc',
    'snow',
  ],
  providers: [
    ee.producer_provider('NASA NSIDC DAAC at CIRES',
    'https://doi.org/10.5067/MODIS/MYD10A1.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000001204-NSIDC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD10A1.061',
  'sci:citation': |||
    Hall, D. K., V. V. Salomonson, and G. A. Riggs. 2016. MODIS/Terra
    Snow Cover Daily L3 Global 500m Grid. Version 6. Boulder, Colorado
    USA: NASA National Snow and Ice Data Center Distributed Active
    Archive Center.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    You may download and use photographs, imagery, or text
    from the NSIDC web site, unless limitations for its use are specifically
    stated. For more information on usage and citing NSIDC datasets,
    please visit the
    [NSIDC 'Use and Copyright' page](https://nsidc.org/about/data-use-and-copyright).
  |||,
}
