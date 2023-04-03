local id = 'NOAA/DMSP-OLS/CALIBRATED_LIGHTS_V4';
local subdir = 'NOAA';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'DMSP OLS: Global Radiance-Calibrated Nighttime Lights Version 4, Defense Meteorological Program Operational Linescan System',
  version: 'Version 4',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Defense Meteorological Program (DMSP) Operational Line-Scan System
    (OLS) has a unique capability to detect visible and near-infrared (VNIR)
    emission sources at night.

    This collection contains global nighttime lights images with no sensor
    saturation. The sensor is typically operated at a high-gain setting to
    enable the detection of moonlit clouds. However, with six bit quantization
    and limited dynamic range, the recorded data are saturated in the bright
    cores of urban centers. A limited set of observations at low lunar
    illumination were obtained where the gain of the detector was set
    significantly lower than its typical operational setting (sometimes by a
    factor of 100). Sparse data acquired at low-gain settings were combined
    with the operational data acquired at high-gain settings to produce the set
    of global nighttime lights images with no sensor saturation. Data from
    different satellites were merged and blended into the final product in order
    to gain maximum coverage. For more information, see this
    [readme](https://eogdata.mines.edu/dmsp/radcal_readme.txt)
    file from the provider.

    Image and data processing by NOAA's National Geophysical Data Center.
    DMSP data collected by US Air Force Weather Agency.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'calibrated',
    'dmsp',
    'eog',
    'imagery',
    'lights',
    'nighttime',
    'ols',
    'radiance',
    'visible',
    'yearly',
  ],
  providers: [
    ee.producer_provider('Earth Observation Group, Payne Institute for Public Policy, Colorado School of Mines', 'https://eogdata.mines.edu/dmsp/download_radcal.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -65.0, 180.0, 75.0,
                    '1996-03-16T00:00:00Z', '2011-07-31T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'avg_vis',
        description: 'Average digital band numbers from observations with cloud-free light detection.',
      },
      {
        name: 'cf_cvg',
        description: |||
          Cloud-free coverages, the total number of observations that
          went into each 30-arc second grid cell. This image can be used to identify
          areas with low numbers of observations where the quality is reduced.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Nighttime Lights',
        lookat: {
          lat: 49.1,
          lon: 7.82,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              3.0,
            ],
            max: [
              60.0,
            ],
            bands: [
              'avg_vis',
            ],
          },
        },
      },
    ],
    avg_vis: {
      minimum: 0.0,
      maximum: 6060.6,
      'gee:estimated_range': true,
    },
    cf_cvg: {
      minimum: 0.0,
      maximum: 175.0,
      'gee:estimated_range': true,
    },
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution.
  |||,
}
