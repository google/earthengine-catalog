local id = 'MODIS/061/MOD09CMG';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;
local template = import 'templates/MODIS_061_MOD09CMG.libsonnet';

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
  title: 'MOD09CMG.061 Terra Surface Reflectance Daily L3 Global 0.05 Deg CMG',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MOD09CMG Version 6.1 product provides an estimate of the surface
    spectral reflectance of Terra Moderate Resolution Imaging Spectroradiometer
    (MODIS) Bands 1 through 7, resampled to 5600 meter pixel resolution and
    corrected for atmospheric conditions such as gasses, aerosols, and Rayleigh
    scattering. The MOD09CMG data product provides 25 layers including MODIS
    bands 1 through 7; Brightness Temperature data from thermal bands 20, 21,
    31, and 32; along with Quality Assurance (QA) and observation bands.
    This product is based on a Climate Modeling Grid (CMG) for use in climate
    simulation models.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/925/MOD09_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/305/MOD09_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MOD09CMG)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MOD09CMG.061',
    },
  ],
  keywords: [
    'brightness_temperature',
    'ozone',
    'surface_reflectance',
    'terra',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MOD09CMG.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2565788876-LPCLOUD',
  ],
  extent: ee.extent_global('2000-02-24T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Terra',
    ],
  },
  'sci:doi': '10.5067/MODIS/MOD09CMG.061',
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
