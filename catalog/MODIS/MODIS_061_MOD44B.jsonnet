local id = 'MODIS/061/MOD44B';
local subdir = 'MODIS';

local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD44B_versions.libsonnet';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD44B.libsonnet';

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
  title: 'MOD44B.061 Terra Vegetation Continuous Fields Yearly Global 250m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: template.description + |||

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1494/MOD44B_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/113/MOD44B_ATBD.pdf)

    * [General Documentation](https://lpdaac.usgs.gov/products/mod44bv061/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: template.keywords,
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD44B.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2565805839-LPCLOUD',
  ],
  extent: ee.extent_global('2000-03-05T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:citation': template.sci_citation,
  'gee:interval': template.gee_interval,
  'gee:terms_of_use': template.gee_terms_of_use,
}
