local id = 'MERIT/Hydro_reduced/v1_0_1';
local subdir = 'MERIT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_nc_4_0;

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MERIT Hydro: Supplementary Visualization Layers',
  version: '1.0.1',
  'gee:type': ee_const.gee_type.image,
  description: 'Supplementary visualization layers for [MERIT Hydro](MERIT_Hydro_v1_0_1)',
  // Choice of ODbL-1.0 or CC-BY-NC-4.0
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'http://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_Hydro/index.html'),
  ],
  keywords: [
    'dem',
    'elevation',
    'flow_direction',
    'hand',
    'hydrography',
    'hydrosheds',
    'merit',
    'river_width',
    'upstream_drainage_area',
  ],
  providers: [
    ee.producer_provider('Dai Yamazaki (University of Tokyo)', 'http://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_Hydro/index.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1987-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      556.6,
    ],
    'eo:bands': [
      {
        name: 'wth',
        description: |||
          River channel width at the channel centerlines. River channel width is
          calculated by the method described in [Yamazaki et al. 2012, WRR], with some
          improvements/changes on the algorithm. This band was upscaled to 18 arc seconds
          from the original 3 arc seconds for better visualization at global scale.
        |||,
      },
      {
        name: 'upa',
        description: |||
          Upstream drainage area (flow accumulation area). This band was upscaled
          to 18 arc seconds from the original 3 arc seconds for better visualization
          at global scale.
        |||,
        'gee:units': 'km^2',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'River width',
        lookat: {
          lat: 23.052,
          lon: 90.301,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              400.0,
            ],
            bands: [
              'wth',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Yamazaki D., D. Ikeshima, J. Sosa, P.D. Bates, G.H. Allen, T.M. Pavelsky.
    MERIT Hydro: A high-resolution global hydrography map based on latest
    topography datasets
    Water Resources Research, vol.55, pp.5053-5073, 2019,
    [doi:10.1029/2019WR024873](https://doi.org/10.1029/2019WR024873]
  |||,
  'gee:terms_of_use': |||
    Citation to the paper is adequate if you simply use MERIT Hydro. If you
    asked for help for additional handling/editing of the dataset, or if your research
    outcome highly depends on the product, the developer would request co-authorship.

    MERIT Hydro is licensed under a Creative Commons "CC-BY-NC 4.0" or Open
    Data Commons "Open Database License (ODbL 1.0)".  With a dual license, you can
    choose an appropriate license for you.

    To view a copy of these license, please visit:

    * [CC-BY-NC 4.0 license](http://creativecommons.org/licenses/by-nc/4.0/):
    Non-Commercial Use with less restriction.
    * [ODbL 1.0 license](https://opendatacommons.org/licenses/odbl/summary/):
    Commectial Use is OK, but the derived data based on MERIT Hydro should be made
    publicly available under the same ODbL license.  For example, if you create a
    flood hazard map using MERIT Hydro and you would like to provide a COMMERCIAL
    service based on that, you have to make the hazard map PUBLICLY AVAILABLE under
    OdBL license.

    Note that the above license terms are applied to the "derived data" based
    on MERIT Hydro, while they are not applied to "produced work / artwork" created
    with MERIT Hydro (such as figures in a journal paper). The users may have a
    copyright of the artwork and may assign any license, when the produced work
    is not considered as "derived data".

    By downloading and using the data the user agrees to the terms and
    conditions of the license. Notwithstanding this free license, we ask users to
    refrain from redistributing the data in whole in its original format on other
    websites without the explicit written permission from the authors.

    The copyright of MERIT Hydro is held by the developers, 2019, all rights reserved.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
