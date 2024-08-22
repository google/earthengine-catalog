local versions = import 'versions.libsonnet';
local version_table = import 'NOAA_CDR_AVHRR_AOT_versions.libsonnet';

local id = 'NOAA/CDR/AVHRR/AOT/V3';
local subdir = 'NOAA';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'NOAA CDR AVHRR AOT: Daily Aerosol Optical Thickness Over Global Oceans, ' + version + ' [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The NOAA Climate Data Record (CDR) of Aerosol Optical Thickness (AOT) is a
    collection of global daily 0.1 degree derived data from the PATMOS-x AVHRR
    level-2b channel 1 (0.63 micron) orbital clear-sky radiance. The aerosol
    product is generated from AVHRR imagery in cloud-free conditions during
    daytime over oceans.

    Due to the relatively large uncertainties associated with surface
    reflectance over water glint area and land surface as well as limited
    AVHRR retrieval channels, this dataset only includes retrieval over
    non-glint water surface (specifically at the anti-solar side of the orbit
    with viewing angle more than 40 degree away from the specular ray). For
    more details, see the [Algorithm Description](https://www.ncei.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/AlgorithmDescription_01B-04.pdf).

    Image and data processing by NOAA's National Climatic Data Center.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.7289/V5BZ642P',
    },
  ] + version_config.version_links,
  keywords: [
    'aerosol',
    'aot',
    'atmospheric',
    'avhrr',
    'cdr',
    'daily',
    'noaa',
    'optical',
    'pollution',
  ],
  providers: [
    ee.producer_provider('NOAA', 'https://www.ncdc.noaa.gov/cdr/atmospheric/avhrr-aerosol-optical-thickness'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1981-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      {
        name: 'aot',
        description: |||
          Atmosphere optical thickness; the degree to which aerosols
          prevent the transmission of light by absorption or scattering of light.
          A value of 0.01 corresponds to an extremely clean atmosphere, and a
          value of 0.4 would correspond to a very hazy condition. An average
          aerosol optical depth for the U.S. is 0.1 to 0.15.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Aerosol Optical Thickness',
        lookat: {
          lat: -88.6,
          lon: 26.4,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.5,
            ],
            palette: [
              '800080',
              '0000ff',
              '00ffff',
              '008000',
              'ffff00',
              'ff0000',
            ],
            bands: [
              'aot',
            ],
          },
        },
      },
    ],
    aot: {
      minimum: -0.19,
      maximum: 4.95,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7289/V5BZ642P',
  'sci:citation': |||
    Zhao, Xuepeng; and NOAA CDR Program (2017): NOAA Climate Data Record (CDR)
    of AVHRR Daily and Monthly Aerosol Optical Thickness (AOT) over Global
    Oceans, Version 3.0. [indicate subset used]. NOAA National Centers for
    Environmental Information. [doi:10.7289/V5BZ642P](https://doi.org/10.7289/V5BZ642P)
    [date accessed].
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The NOAA CDR Program's official distribution point for CDRs is NOAA's
    National Climatic Data Center which provides sustained, open access and
    active data management of the CDR packages and related information in
    keeping with the United States' open data policies and practices as
    described in the President's Memorandum on \"Open Data Policy\" and pursuant
    to the Executive Order of May 9, 2013, \"Making Open and Machine Readable
    the New Default for Government Information\". In line with these policies,
    the CDR data sets are nonproprietary, publicly available, and no
    restrictions are placed upon their use. For more information, see the
    [Fair Use of NOAA's CDR Data Sets, Algorithms and Documentation](https://www1.ncdc.noaa.gov/pub/data/sds/cdr/CDRs/Aerosol_Optical_Thickness/UseAgreement_01B-04.pdf)
    pdf.
  |||,
}
