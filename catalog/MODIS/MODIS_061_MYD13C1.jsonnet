local id = 'MODIS/061/MYD13C1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD13C1.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';

local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD13C1.061: Aqua Vegetation Indices 16-Day L3 Global 0.05 Deg CMG',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Aqua Moderate Resolution Imaging Spectroradiometer (MODIS) Vegetation Indices 16-Day (MYD13C1) Version 6.1 product provides a Vegetation Index (VI) value at a per pixel basis. There are two primary vegetation layers. The first is the Normalized Difference Vegetation Index (NDVI), which maintains continuity with the existing National Oceanic and Atmospheric Administration-Advanced Very High Resolution Radiometer (NOAA-AVHRR) derived NDVI. The second vegetation layer is the Enhanced Vegetation Index (EVI), which has improved sensitivity over high biomass regions.
    The Climate Modeling Grid (CMG) consists of 3,600 rows and 7,200 columns of 5,600 meter (m) pixels. Global MYD13C1 data are cloud-free spatial composites of the gridded 16-day 1 kilometer MYD13A2 data, and are provided as a Level 3 product projected on a 0.05 degree (5,600 m) geographic CMG. The MYD13C1 has data fields for NDVI, EVI, VI QA, reflectance data, angular information, and spatial statistics such as mean, standard deviation, and number of used input pixels at the 0.05 degree CMG resolution. 
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD13C1.061',
    },
  ],
  keywords: [
    'global',
    'nasa',
    'aqua',
    'usgs',
    'vegetation',
    '16_day',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD13C1.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2565794051-LPCLOUD',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD13C1.061',
  'sci:citation': |||
    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
    for information on citing LP DAAC datasets.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC
    have no restrictions on subsequent use, sale, or redistribution.
  |||,
}
