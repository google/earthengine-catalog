local id = 'MODIS/061/MCD43A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD43A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local template = import 'templates/MODIS_006_MCD43A1.libsonnet';

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD43A1.061 MODIS BRDF-Albedo Model Parameters Daily 500m',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MCD43A1 V6.1 Bidirectional Reflectance Distribution
    Function and Albedo (BRDF/Albedo) Model Parameters dataset is
    a 500 meter daily 16-day product. The Julian date represents
    the 9th day of the 16-day retrieval period, and consequently
    the observations are weighted to estimate the BRDF/Albedo for
    that day. The MCD43A1 algorithm, as is with all combined products,
    chooses the best representative pixel from a pool that includes
    all the acquisitions from both the Terra and Aqua sensors from
    the retrieval period.

    The MCD43A1 provides the three model
    weighting parameters (isotropic, volumetric, and geometric) for
    each of the MODIS bands 1 through 7 and the visible (vis), near
    infrared (nir), and shortwave bands used to derive the Albedo
    and BRDF products (MCD43A3 and MCD43A4). The Mandatory Quality
    layers for each of the 10 bands are supplied as well.

    Documentation:

    * [User's Guide](https://www.umb.edu/spectralmass/v006/)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/97/MCD43_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MCD43A1)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MCD43A1.061',
    },
  ] + version_config.version_links,
  keywords: [
    'albedo',
    'brdf',
    'daily',
    'global',
    'mcd43a1',
    'modis',
    'nasa',
    'reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MCD43A1.061'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1620265504-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MCD43A1.061',
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
