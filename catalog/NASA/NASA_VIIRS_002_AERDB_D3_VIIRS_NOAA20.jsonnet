local id = 'NASA/VIIRS/002/AERDB_D3_VIIRS_NOAA20';
local subdir = 'NASA';
local version = '2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/VIIRS_AERDB_D3_bands.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
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
  title: 'AERDB_D3_VIIRS_NOAA20.002: VIIRS/NOAA-20 Deep Blue Aerosol Optical Depth Daily L3 Global 1.0 Deg Grid',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Visible Infrared Imaging Radiometer Suite (VIIRS) Deep Blue Level-3
    Daily Global 1-Degree Gridded product (AERDB_D3_VIIRS_NOAA20) provides daily
    global gridded aerosol parameters derived from the NOAA-20 (JPSS-1) VIIRS
    sensor. Data are generated using the Deep Blue (DB) algorithm over land and
    the Satellite Aerosol for Land and Ocean (SOAR) algorithm over ocean.

    The product includes statistical summaries (mean, minimum, maximum, count,
    and standard deviation) of aerosol optical thickness (AOT) at 550 nm across
    land, ocean, and combined land/ocean scenes, along with Angstrom exponent
    retrievals, fine-mode fraction estimates over ocean, and aerosol type
    classifications. Data are projected on a regular 1.0 degree equal-angle
    global grid (EPSG:4326).

    Documentation:

    * [Product User Guide](https://atmosphere-imager.gsfc.nasa.gov/sites/default/files/ModAtmo/VIIRS_Deep_Blue_User_Guide_v1.1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://atmosphere-imager.gsfc.nasa.gov/sites/default/files/ModAtmo/VIIRS_Deep_Blue_ATBD_v1.0.pdf)

    * [Deep Blue Project](https://deepblue.gsfc.nasa.gov/)

    * [LAADS DAAC Product Page](https://ladsweb.modaps.eosdis.nasa.gov/missions-and-measurements/products/AERDB_D3_VIIRS_NOAA20)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002',
    },
  ],
  'gee:categories': ['atmosphere'],
  keywords: [
    'aerosol',
    'aot',
    'atmosphere',
    'daily',
    'nasa',
    'noaa',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA Atmosphere SIPS / LAADS DAAC', 'https://doi.org/10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-01-05T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'NOAA-20',
    ],
  },
  'sci:doi': '10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002',
  'sci:citation': |||
    Hsu, C., et al. (2019). VIIRS/NOAA-20 Deep Blue Aerosol Optical Depth Daily L3
    Global 1.0 Deg Grid. NASA Goddard Space Flight Center,
    [doi:10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002](https://doi.org/10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This dataset is freely available under the NASA Earth Science Open Data
    Policy. Users are requested to cite the dataset using the DOI:
    [https://doi.org/10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002](https://doi.org/10.5067/VIIRS/AERDB_D3_VIIRS_NOAA20.002).
  |||,
}
