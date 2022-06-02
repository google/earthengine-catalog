local id = 'NOAA/VIIRS/DNB/MONTHLY_V1/VCMSLCFG';
local subdir = 'NOAA/VIIRS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'VIIRS Stray Light Corrected Nighttime Day/Night Band Composites Version 1',
  version: 'Version 1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Monthly average radiance composite images using nighttime data from the
    Visible Infrared Imaging Radiometer Suite (VIIRS) Day/Night Band (DNB).

    As these data are composited monthly, there are many areas of the globe
    where it is impossible to get good quality data coverage for that month.
    This can be due to cloud cover, especially in the tropical regions, or due
    to solar illumination, as happens toward the poles in their respective
    summer months. Therefore it is recommended that users of these data utilize
    the 'cf_cvg' band and not assume a value of zero in the average radiance
    image means that no lights were observed.

    Cloud cover is determined using the VIIRS Cloud
    Mask product (VCM). In addition, data near the edges of the swath are not
    included in the composites (aggregation zones 29-32). Version 1 has NOT
    been filtered to screen out lights from aurora, fires, boats, and other
    temporal lights. This separation is under development and will be included
    in a later version of this time series. Also in development is a method to
    separate lights from background (non-light) values.

    This product is an alternative configuration of the VIIRS DNB using a
    procedure to correct for stray light. The correction procedure extends
    visible areas closer to the poles and improves dynamic range. It should be
    noted some artifacts are introduced due to the procedure used in twilight
    regions; see
    [reference paper](https://spie.org/Publications/Proceedings/Paper/10.1117/12.2023107)
    for more details. This product excludes data
    impacted by cloud cover.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'dnb',
    'eog',
    'lights',
    'monthly',
    'nighttime',
    'noaa',
    'stray-light',
    'viirs',
    'visible',
  ],
  providers: [
    ee.producer_provider('Earth Observation Group, Payne Institute for Public Policy, Colorado School of Mines', 'https://eogdata.mines.edu/download_dnb_composites.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -65.0, 180.0, 75.0, '2014-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      463.83,
    ],
    'eo:bands': [
      {
        name: 'avg_rad',
        description: 'Average DNB radiance values.',
        'gee:units': 'nanoWatts/cm2/sr',
      },
      {
        name: 'cf_cvg',
        description: |||
          Cloud-free coverages; the total number of observations that
          went into each pixel. This band can be used to identify areas with low
          numbers of observations where the quality is reduced.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Nighttime',
        lookat: {
          lat: 45.83,
          lon: 1.76,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              60.0,
            ],
            bands: [
              'avg_rad',
            ],
          },
        },
      },
    ],
    avg_rad: {
      minimum: -1.5,
      maximum: 193564.92,
      'gee:estimated_range': true,
    },
    cf_cvg: {
      minimum: 0.0,
      maximum: 84.0,
      'gee:estimated_range': true,
    },
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': |||
    Colorado School of Mines data, information, and products,
    regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use. The
    forgoing data is in the public domain and is being provided without
    restriction on use and distribution.
  |||,
}
