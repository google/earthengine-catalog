local id = 'NASA/VIIRS/002/VNP19A2_GRANULES';
local subdir = 'NASA';
local version = '2';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local template = import 'templates/NASA_VIIRS_002_MAIAC_GRANULES.libsonnet';

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
  title: 'VNP19A2.002: VIIRS/NPP MAIAC Aerosol Optical Depth Daily L2G Global 750m SIN Grid',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The VNP19A2 Version 2 data product is a Suomi National Polar-orbiting
    Partnership (Suomi NPP) Visible Infrared Imaging Radiometer Suite (VIIRS)
    Multi-Angle Implementation of Atmospheric Correction (MAIAC) Land and Ocean
    Aerosol Optical Depth (AOD) gridded Level 2 (L2G) product produced daily at
    750 m resolution on a Sinusoidal grid.

    Each daily source HDF-EOS5 file contains multiple orbit overpasses. In Earth
    Engine, each individual orbit is ingested as a separate image asset with the
    orbit start and end timestamps preserved in `system:time_start` and
    `system:time_end`.

    The product provides aerosol optical depth at 0.47 &mu;m and 0.55 &mu;m,
    AOD uncertainty, fine-mode fraction and Angstrom exponent (470-860 nm) over
    water, smoke injection height, quality assurance flags, and viewing geometry
    angles at 3.75 km resolution.

    Documentation:

    * [VNP19 User's Guide](https://lpdaac.usgs.gov/documents/2268/VNP19_User_Guide_V1.pdf)

    * [VIIRS Land Product Quality Assessment](https://viirsland.gsfc.nasa.gov/Val_overview.html)

    * [LP DAAC Product Page](https://doi.org/10.5067/VIIRS/VNP19A2.002)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/VIIRS/VNP19A2.002',
    },
  ],
  'gee:categories': ['atmosphere'],
  keywords: [
    'aerosol',
    'aod',
    'atmosphere',
    'daily',
    'global',
    'maiac',
    'nasa',
    'noaa',
    'npp',
    'usgs',
    'viirs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/VIIRS/VNP19A2.002'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2872634741-LPCLOUD',
  ],
  extent: ee.extent_global('2012-01-19T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Suomi NPP',
    ],
  },
  'sci:doi': '10.5067/VIIRS/VNP19A2.002',
  'sci:citation': |||
    Lyapustin, A. (2023). VIIRS/NPP Aerosol Optical Depth and Aerosol Particle
    Size Parameters Daily L2G Global 750m SIN Grid V002 [Data set]. NASA EOSDIS
    Land Processes Distributed Active Archive Center.
    [doi:10.5067/VIIRS/VNP19A2.002](https://doi.org/10.5067/VIIRS/VNP19A2.002)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    LP DAAC NASA data are freely accessible; however, when an author
    publishes these data or works based on the data, it is requested that the
    author cite the datasets within the text of the publication and include a
    reference to them in the reference list.
  |||,
}
