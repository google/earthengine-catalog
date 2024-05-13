local id = 'MODIS/061/MYD09A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MYD09A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD09A1.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD09A1.061 Aqua Surface Reflectance 8-Day Global 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD09A1 V6.1 product provides an estimate of the surface
    spectral reflectance of Aqua MODIS bands 1-7 at 500m resolution
    and corrected for atmospheric conditions such as gasses, aerosols,
    and Rayleigh scattering. Along with the seven reflectance bands
    is a quality layer and four observation bands. For each pixel,
    a value is selected from all the acquisitions within the 8-day
    composite on the basis of high observation coverage, low view angle,
    the absence of clouds or cloud shadow, and aerosol loading.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/306/MOD09_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/305/MOD09_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MYD09A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD09A1.061',
    },
  ] + version_config.version_links,
  keywords: [
    '8_day',
    'aqua',
    'global',
    'modis',
    'myd09a1',
    'nasa',
    'sr',
    'surface_reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD09A1.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C193529457-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD09A1.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
