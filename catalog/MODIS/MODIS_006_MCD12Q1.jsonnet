local id = 'MODIS/006/MCD12Q1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD12Q1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD12Q1.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD12Q1.006 MODIS Land Cover Type Yearly Global 500m [deprecated]',
  'gee:status': 'deprecated',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD12Q1 V6 product provides global land cover types at yearly intervals
    (2001-2016) derived from six different classification schemes. It is derived
    using supervised classifications of MODIS Terra and Aqua reflectance data.
    The supervised classifications then undergo additional post-processing that
    incorporate prior knowledge and ancillary information to further refine
    specific classes.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/101/MCD12_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/86/MCD12_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MCD12Q1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD12Q1.006',
    },
  ] + version_config.version_links,
  keywords: [
    'landcover',
    'modis',
    'nasa',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD12Q1.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C186286578-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD12Q1.006',
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
