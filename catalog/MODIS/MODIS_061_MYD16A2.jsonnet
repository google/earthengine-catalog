local id = 'MODIS/061/MYD16A2';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.proprietary;
local template = import 'templates/MODIS_006_MOD16A2.libsonnet';

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
  title: 'MYD16A2.061: Aqua Net Evapotranspiration 8-Day L4 Global 500m SIN Grid V061',
  version: '6.1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MYD16A2 Version 6.1 Evapotranspiration/Latent Heat Flux product is an
    8-day composite product at 500 meter pixel resolution. The algorithm used
    for the MOD16 data product collection is based on the logic of the
    Penman-Monteith equation, which includes inputs of daily meteorological
    reanalysis data along with MODIS remotely sensed data products such as
    vegetation property dynamics, albedo, and land cover.

    The pixel values for the ET, LE, PET and PLE layers are the sum for all days
    within the 8-day composite period.Note that the last 8-day period of each
    year is a 5 or 6-day composite period, depending on the year.

    The Version 6.1 Level-1B (L1B) products have been improved by undergoing
    various calibration changes that include: changes to the
    response-versus-scan angle (RVS) approach that affects reflectance bands
    for Aqua and Terra MODIS, corrections to adjust for the optical crosstalk
    in Terra MODIS infrared (IR) bands, and corrections to the Terra MODIS
    forward look-up table (LUT) update for the period 2012 - 2017.
    A polarization correction has been applied to the L1B Reflective Solar
    Bands (RSB). The product uses Climatology LAI/FPAR as back up to the
    operational LAI/FPAR.

    According to [the MODIS Science Team]
    (https://forum.earthdata.nasa.gov/viewtopic.php?p=15070#p15070),
    The MYD16A2 6.1 product will not have data prior to 2021. The MODIS Science
    team recommends using the gap-filled MYD16A2GF 6.1 product for data from
    2000 to 2021 -- and then also 2022 when the data are available.
    They recommend this as the gap-filled product is expected to be superior in
    product quality, especially over areas where otherwise the routine product
    performance would have been negatively impacted by cloudy or poor quality
    input observations. For the current year, there will not be a gap-filled
    product until early the following year (i.e. 2023 data should be available
    in early 2024). So, if a user needs MYD16A2GF 6.1 data for the year 2023
    (or the "current" year in the future), they recommend using the MYD16A2 6.1
    product, which is generated using the daily observation with climatology
    observation replacing for the cloudy or poor quality observations.

    Documentation:

    * [User's Guide](https://lpdaac.usgs.gov/documents/494/MOD16_User_Guide_V6.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/93/MOD16_ATBD.pdf)

    * [General Documentation](https://ladsweb.modaps.eosdis.nasa.gov/filespec/MODIS/6/MYD16A2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5067/MODIS/MYD16A2.061',
    },
  ],
  'gee:categories': ['water-vapor'],
  keywords: [
    '8_day',
    'evapotranspiration',
    'global',
    'modis',
    'nasa',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center',
    'https://doi.org/10.5067/MODIS/MYD16A2.061'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C2565794064-LPCLOUD',
  ],
  extent: ee.extent_global('2021-01-01T00:00:00Z', null),
  summaries: template.summaries {
    platform: [
      'Aqua',
    ],
    'gee:schema'+: [
      {
        name: 'num_tiles',
        description: 'The number of source tiles that were mosaicked to create this image.',
        type: 'INT',
      },
    ],
  },
  'sci:doi': '10.5067/MODIS/MYD16A2.061',
  'sci:citation': |||
    Please visit
    [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data)
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
