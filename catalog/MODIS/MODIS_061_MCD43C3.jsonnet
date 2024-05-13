local id = 'MODIS/061/MCD43C3';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD43C3_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MCD43C3.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD43C3.061 BRDF/Albedo Daily L3 0.05 Deg CMG',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD43C3 Version 6.1
    Bidirectional Reflectance Distribution Function and Albedo (BRDF/Albedo) Albedo
    dataset is produced daily using 16 days of Terra and Aqua MODIS data in a 0.05
    degree (5,600 meters at the equator) Climate Modeling Grid (CMG). Data are
    temporally weighted to the ninth day of the retrieval period which is reflected
    in the Julian date in the file name. This CMG product covers the entire globe
    for use in climate simulation models.

    MCD43C3 provides black-sky albedo (directional hemispherical reflectance)
    and white-sky albedo (bihemispherical reflectance) at local solar noon.
    Black-sky albedo and white-sky albedo values are available as a separate layer
    for MODIS spectral bands 1 through 7 as well as the visible, near infrared
    (NIR), and shortwave bands. Along with the 20 albedo layers are ancillary
    layers for quality, local solar noon, percent finer resolution inputs, snow
    cover, and uncertainty.

    See
    [dataset user guide](https://www.umb.edu/spectralmass/terra_aqua_modis/v006/mcd43c3)
    for more information.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD43C3.061',
    },
  ] + version_config.version_links,
  keywords: [
    'albedo',
    'black_sky',
    'brdf',
    'daily',
    'global',
    'modis',
    'nasa',
    'usgs',
    'white_sky',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD43C3.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
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
