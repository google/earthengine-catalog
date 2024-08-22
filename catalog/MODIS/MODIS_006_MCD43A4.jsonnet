local id = 'MODIS/006/MCD43A4';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD43A4_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD43A4.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD43A4.006 MODIS Nadir BRDF-Adjusted Reflectance Daily 500m [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD43A4 V6 Nadir Bidirectional Reflectance Distribution
    Function Adjusted Reflectance (NBAR) product provides 500 meter
    reflectance data of the MODIS \"land\" bands 1-7. These are adjusted
    using a bidirectional reflectance distribution function to model
    the values as if they were collected from a nadir view.  The data
    are produced daily based on a 16-day retrieval period, with the
    image's date occurring on the 9th day. This product combines data
    from both the Terra and Aqua spacecrafts, choosing the best representative
    pixel from the 16-day period.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/terra_aqua_modis/v006)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/97/MCD43_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MCD43A4)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD43A4.006',
    },
  ] + version_config.version_links,
  keywords: [
    'albedo',
    'brdf',
    'daily',
    'global',
    'modis',
    'nasa',
    'reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD43A4.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000412-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD43A4.006',
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
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
