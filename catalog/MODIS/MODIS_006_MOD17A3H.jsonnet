local id = 'MODIS/006/MOD17A3H';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MOD17A3H_versions.libsonnet';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD17A3H.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MOD17A3H.006: Terra Net Primary Production Yearly Global 500m [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD17A3H V6 product provides information about
    annual Net Primary Productivity (NPP) at 500m pixel resolution.
     Annual NPP is derived from the sum of the 45 8-day Net Photosynthesis
    (PSN) products (MOD17A2H) from the given year.  The PSN value
    is the difference of the GPP and the Maintenance Respiration
    (MR) (GPP-MR).

    This is a NASA version of this product. Another
    version is produced by the Numerical Terradynamic Simulation
    Group ([NTSG](https://www.ntsg.umt.edu)), University of Montana
    (UMT).  The NTSG version corrects the problem with cloud-contaminated
    MODIS LAI-FPAR inputs to the MOD17 algorithm, but its resolution
    is 1km. It is ingested into Earth Engine as MODIS/055/MOD17A3.

    For further details regarding the differences between the NTSG
    and NASA versions of this product, please consult [this document
    ](https://lpdaac.usgs.gov/documents/188/MOD17_NTSG_Note.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD17A3H.006',
    },
  ] + version_config.version_links,
  keywords: [
    'global',
    'gpp',
    'mod17a3',
    'modis',
    'nasa',
    'npp',
    'photosynthesis',
    'productivity',
    'psn',
    'terra',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD17A3H.006'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD17A3H.006',
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
