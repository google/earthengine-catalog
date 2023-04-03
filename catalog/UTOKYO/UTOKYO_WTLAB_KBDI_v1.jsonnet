local id = 'UTOKYO/WTLAB/KBDI/v1';
local subdir = 'UTOKYO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
  title: 'KBDI: Keetch-Byram Drought Index',
  version: '1',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Keetch-Byram Drought Index (KBDI) is a continuous reference scale for estimating the dryness of
    the soil and duff layers. The index increases for each day without rain (the amount of increase
    depends on the daily high temperature) and decreases when it rains. This system is based
    primarily on recent rainfall patterns. It is a measure of meteorological drought; it reflects
    water gain or loss within the soil.

    The scale ranges from 0 (no moisture deficit) to 800 (extreme drought). The range of the index
    is determined by assuming that there is 20 cm of moisture in a saturated soil that is readily
    available to the vegetation (Keetch and Byram, 1968). KBDI is world widely used for drought
    monitoring for national weather forecast, wildfire prevention and usefully especially in regions
    with rain-fed crops.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
  ],
  keywords: [
    'drought',
    'kbdi',
    'lst_derived',
    'rainfall',
    'utokyo',
    'wtlab',
  ],
  providers: [
    ee.producer_provider('Institute of Industrial Science, The University of Tokyo, Japan', 'http://wtlab.iis.u-tokyo.ac.jp/DMEWS/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(60.0, -60.0, 180.0, 60.0, '2007-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      4000.0,
    ],
    'eo:bands': [
      {
        name: 'KBDI',
        description: 'Keetch-Byram Drought Index',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'KBDI',
        lookat: {
          lat: 3.0,
          lon: 120.0,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            bands: [
              'KBDI',
            ],
            min: [
              0.0,
            ],
            max: [
              800.0,
            ],
            palette: [
              '0000ff',
              '33ccff',
              '339933',
              'ffff00',
              'cc9900',
              'cc6600',
              'ff0000',
            ],
          },
        },
      },
    ],
    KBDI: {
      minimum: 0.0,
      maximum: 800.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Wataru Takeuchi, Soni Darmawan, Rizatus Shofiyati, Mai Van Khiem, Kyaw San Oo, Uday Pimple
    and Suthy Heng, 2015. Near-real time meteorological drought monitoring and early warning
    system for croplands in Asia.
    36th Asian conference on remote sensing (ACRS): Manila, Philippines, Oct. 20, 2015.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
