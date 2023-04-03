local id = 'MODIS/061/MYD21A1N';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD21A1D.libsonnet';

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
  title: 'MYD21A1N.061 Aqua Land Surface Temperature and 3-Band Emissivity Daily Global 1km',
  version: 'V061',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD21A1N dataset is produced daily from nighttime Level 2 Gridded (L2G)
    intermediate LST products at a spatial resolution of 1,000 meters. The L2G
    process maps the daily MOD21 swath granules onto a sinusoidal MODIS grid and
    stores all observations falling over a gridded cell for a given day. The
    MOD21A1 algorithm sorts through these observations for each cell and
    estimates the final LST value as an average from all observations that are
    cloud free and have good LST&E accuracies. The nighttime average is weighted
    by the observation coverage for that cell. Only observations having an
    observation coverage greater than a 15% threshold are considered. The
    MYD21A1N product contains the calculated LST as well as quality control, the
    three emissivity bands, view zenith angle, and time of observation.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/1398/MOD21_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1399/MOD21_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MYD21A1N)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD21A1N.061',
    },
  ],
  keywords: [
    'aqua',
    'daily',
    'emissivity',
    'global',
    'lst',
    'nasa',
    'surface_temperature',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD21A1N.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1621446702-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD21A1N.061',
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
