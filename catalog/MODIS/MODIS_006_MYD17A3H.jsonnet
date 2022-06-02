local id = 'MODIS/006/MYD17A3H';
local successor_id = 'MODIS/006/MYD17A3HGF';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD17A3H.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD17A3H.006: Aqua Net Primary Production Yearly Global 500m [deprecated]',
  version: 'V006',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD17A3H V6 product provides information about
    annual Net Primary Productivity (NPP) at 500m pixel resolution.
     Annual NPP is derived from the sum of the 45 8-day Net Photosynthesis
    (PSN) products (MYD17A2H) from the given year.  The PSN value
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
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.5067/MODIS/MYD17A3H.006',
    },
  ],
  keywords: [
    'aqua',
    'global',
    'gpp',
    'modis',
    'myd17a3',
    'nasa',
    'npp',
    'photosynthesis',
    'productivity',
    'psn',
    'usgs',
    'yearly',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD17A3H.006'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1631984536-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2002-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD17A3H.006',
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
