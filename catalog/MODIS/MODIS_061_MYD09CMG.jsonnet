local id = 'MODIS/061/MYD09CMG';
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
  title: 'MYD09CMG.061 Aqua Surface Reflectance Daily L3 Global 0.05 Deg CMG',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD09CMG Version 6.1 product provides an estimate of the surface
    spectral reflectance of Aqua Moderate Resolution Imaging Spectroradiometer
    (MODIS) Bands 1 through 7, resampled to 5600 meter pixel resolution and
    corrected for atmospheric conditions such as gasses, aerosols, and Rayleigh
    scattering. The MYD09CMG data product provides 25 layers including MODIS
    bands 1 through 7; Brightness Temperature data from thermal bands 20, 21,
    31, and 32; along with Quality Assurance (QA) and observation bands.
    This product is based on a Climate Modeling Grid (CMG) for use in climate
    simulation models.

    This dataset has a striping issue originating from Band 5’s dead
    detector 20. The MYD09/Band 5 show the dead detector striping in band 5, but
    it has been properly flagged in the QA layer. The science team has been
    notified and the issue will be addressed in the Collection 7.
    More details can be found on
    [the known issue page](https://landweb.modaps.eosdis.nasa.gov/displayissue?id=939).

    Note that scale factors and offsets described in the MODIS documentation
    for MYD09CMG bands are already applied to assets ingested into Earth
    Engine.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/925/MOD09_User_Guide_V61.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/305/MOD09_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/61/MYD09CMG)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD09CMG.061',
    },
  ],
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'brightness_temperature',
    'ozone',
    'surface_reflectance',
    'aqua',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MODIS/MYD09CMG.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2565794001-LPCLOUD',
  ],
  extent: ee.extent_global('2002-07-04T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD09CMG.061',
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
