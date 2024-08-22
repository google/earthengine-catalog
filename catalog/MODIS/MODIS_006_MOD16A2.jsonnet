local id = 'MODIS/006/MOD16A2';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD16A2_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD16A2.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD16A2.006: Terra Net Evapotranspiration 8-Day Global 500m [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD16A2 Version 6 Evapotranspiration/Latent Heat Flux product is an
    8-day composite product produced at 500 meter pixel resolution. The
    algorithm used for the MOD16 data product collection is based on the logic
    of the Penman-Monteith equation, which includes inputs of daily
    meteorological reanalysis data along with MODIS remotely sensed data
    products such as vegetation property dynamics, albedo, and land cover.

    The pixel values for the two Evapotranspiration layers (ET & PET) are the
    sum of all eight days within the composite period. The pixel values for
    the two Latent Heat layers (LE & PLE) are the average of all eight days
    within the composite period. Note that the last 8-day period of each year
    is a 5 or 6-day composite period, depending on the year.

    According to
    [the \"Layers\" section of the dataset docs](https://lpdaac.usgs.gov/products/mod16a2v006),
    the class assignment in fill values 32761 through 32767 might be inaccurate.
    They are not included in the EE assets.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/494/MOD16_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/93/MOD16_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MOD16A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD16A2.006',
    },
  ] + version_config.version_links,
  keywords: [
    '8_day',
    'evapotranspiration',
    'global',
    'mod16a2',
    'modis',
    'nasa',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD16A2.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1000000524-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD16A2.006',
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
