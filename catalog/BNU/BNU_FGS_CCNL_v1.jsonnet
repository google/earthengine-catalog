local id = 'BNU/FGS/CCNL/v1';
local subdir = 'BNU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'CCNL: Consistent And Corrected Nighttime Light Dataset from DMSP-OLS (1992-2013)',
  version: 'v1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Consistent and Corrected Nighttime Lights (CCNL) dataset is
    a reprocessed version of the [Defense Meteorological Program (DMSP)
    Operational Line-Scan System (OLS) Version 4](NOAA_DMSP-OLS_NIGHTTIME_LIGHTS).
    A series of methods was used to mitigate the impact of inter-annual
    inconsistency, saturation, and blooming effects and to improve data quality.

    CCNL Version 1 spans the globe from 75N to 65S and has 1km pixel size.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'bnu',
    'dmsp',
    'eog',
    'imagery',
    'lights',
    'nighttime',
    'ols',
    'visible',
    'yearly',
  ],
  providers: [
    ee.producer_provider(
        'Beijng Normal University', 'https://doi.org/10.5281/zenodo.6644980'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -180, -65, 180, 75, '1992-01-01T00:00:00Z', '2014-01-01T00:00:00Z'),
  'sci:citation': |||
    Zhao,Chenchen, Cao,Xin, Chen,Xuehong, & Cui,Xihong. (2020). A Consistent
    and Corrected Nighttime Light dataset (CCNL 1992-2013) from DMSP-OLS data
    (Version 1.0) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.6644980
  |||,
  'gee:user_uploaded': true,
  'gee:terms_of_use': spdx.cc_by_4_0.id,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [1000],
    'gee:visualizations': [
      {
        display_name: 'Nighttime Lights',
        lookat: {
          lat: 31.4,
          lon: 30,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            bands: ['b1'],
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'Corrected nighttime light intensity.'
      },
    ],
  },
}
