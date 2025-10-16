local id = 'MERIT/DEM/v1_0_3';
local subdir = 'MERIT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

// Alternative license: cc_by_nc_4_0
local license = spdx.odbl_1_0;

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
  title: 'MERIT DEM: Multi-Error-Removed Improved-Terrain DEM',
  version: '1.0.3',
  'gee:type': ee_const.gee_type.image,
  description: |||
    MERIT DEM a high accuracy global DEM at 3 arc second resolution (~90 m at
    the equator) produced by eliminating major error components from existing DEMs
    (NASA SRTM3 DEM, JAXA AW3D DEM, Viewfinder Panoramas DEM).

    MERIT DEM separates absolute bias, stripe noise, speckle
    noise and tree height bias using multiple satellite datasets and filtering techniques.
    After the error removal, land areas mapped with 2 m or better vertical accuracy
    were increased from 39% to 58%. Significant improvements were found in flat regions
    where height errors larger than topography variability, and landscapes such as
    river networks and hill-valley structures became clearly represented.

    'MERIT DEM was developed by processing the following products as baseline data:

    * [NASA SRTM3 DEM v2.1](https://dds.cr.usgs.gov/srtm/version2_1/SRTM3)
    * [JAXA AW3D - 30 m DEM v1](https://www.eorc.jaxa.jp/ALOS/en/aw3d30/index.htm)
    * [Viewfinder Panoramas DEM](https://www.viewfinderpanoramas.org/dem3.html)

    In addition to the above baseline dems, these products were used as supplementary data:

    * [NASA-NSIDC ICESat/GLAS GLA14 data](https://nsidc.org/data/gla14)
    * [U-Maryland Landsat forest cover data](https://glad.earthengine.app/view/global-forest-change)
    * [NASA Global Forest height data](https://www.nasa.gov/topics/earth/features/forest-height-map.html)
    * [JAMSTEC/U-Tokyo G3WBM water body data](https://hydro.iis.u-tokyo.ac.jp/~yamadai/G3WBM/index.html)
  |||,
  // Choice of ODbL-1.0 or CC-BY-NC-4.0
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(
      'https://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_DEM/index.html'),
  ],
  'gee:categories': ['elevation-topography'],
  keywords: [
    'dem',
    'elevation',
    'merit',
    'topography',
  ],
  providers: [
    ee.producer_provider('Dai Yamazaki (University of Tokyo)', 'https://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_DEM/index.html'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.0, 180.0, 90.0,
                    '1987-01-01T00:00:00Z', '2017-01-01T00:00:00Z'),
  summaries: {
    'eo:bands': [
      {
        name: 'dem',
        description: 'Elevation in meters, referenced to EGM96 geoid model.',
        gsd: 92.77,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Elevation',
        lookat: {
          lat: 23.052,
          lon: 90.301,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              -3.0,
            ],
            max: [
              18.0,
            ],
            palette: [
              '000000',
              '478fcd',
              '86c58e',
              'afc35e',
              '8f7131',
              'b78d4f',
              'e2b8a6',
              'ffffff',
            ],
            bands: [
              'dem',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Yamazaki D., D. Ikeshima, R. Tawatari, T. Yamaguchi, F. O'Loughlin, J.C. Neal,
    C.C. Sampson, S. Kanae & P.D. Bates. A high accuracy map of global
    terrain elevations.  Geophysical Research Letters, vol.44, pp.5844-5853, 2017.

    [doi:10.1002/2017GL072874](https://doi.org/10.1002/2017GL072874)
  |||,
  'gee:terms_of_use': |||
    Citation to the paper is adequate if you simply use MERIT DEM. If you
    asked for help for additional handling/editing of the dataset, or if your research
    outcome highly depends on the product, the developer would request co-authorship.

    MERIT DEM is licensed under a Creative Commons "CC-BY-NC 4.0" or
    Open Data Commons "Open Database License (ODbL 1.0)". With a dual license, you
    can choose an appropriate license for you.

    To view a copy of these license, please visit:

    * [CC-BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/): Non-Commercial Use with less restriction.
    * [ODbL 1.0 license](https://opendatacommons.org/licenses/odbl/summary/): Commercial Use is OK, but the derived data based on MERIT
    DEM should be made publicly available under the same ODbL license.  For
    example, if you create a flood hazard map using MERIT DEM and you would like to
    provide a COMMERCIAL service based on that, you have to make the hazard map
    PUBLICLY AVAILABLE under OdBL license.

    Note that the above license terms are applied to the "derived data" based
    on MERIT DEM, while they are not applied to "produced work / artwork" created
    with MERIT DEM (such as figures in a journal paper). The users may have a
    copyright of the artwork and may assign any license, when the produced work
    is not considered as "derived data".

    By downloading and using the data the user agrees to the terms and
    conditions of one of these licenses. Notwithstanding this free license, we ask
    users to refrain from redistributing the data in whole in its original format
    on other websites without the explicit written permission from the authors.

    The copyright of MERIT DEM is held by the developers, 2018, all rights reserved.
  |||,
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
