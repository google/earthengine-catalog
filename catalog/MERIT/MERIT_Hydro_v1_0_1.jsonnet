local id = 'MERIT/Hydro/v1_0_1';
local subdir = 'MERIT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

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
  title: 'MERIT Hydro: Global Hydrography Datasets',
  version: '1.0.1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    MERIT Hydro is a new global flow direction map at 3 arc-second resolution (~90
    m at the equator) derived from the version 1.0.3 of the MERIT DEM elevation data
    and water body datasets (G1WBM, GSWO and OpenStreetMap).

    MERIT Hydro contains the output of a new algorithm that
    extracts river networks near-automatically by separating actual inland basins from
    noise caused by the errors in input elevation data. After a minimum
    amount of hand-editing, the constructed hydrography map shows good agreement with
    existing quality-controlled river network datasets in terms of flow accumulation
    area and river basin shape (see Figure 9a in the paper). The location of river
    streamlines was realistically aligned with existing satellite-based global
    river channel data (see Figure 10a in the paper). Relative error
    in the drainage area was smaller than 0.05 for 90% of GRDC gauges, confirming
    the accuracy of the delineated global river networks. Discrepancies in flow accumulation
    area were found mostly in arid river basins containing depressions that are occasionally
    connected at high water levels and thus resulting in uncertain watershed boundaries.

    MERIT Hydro improves on existing global hydrography datasets in terms of spatial
    coverage (between 90N and 60S) and representation of small streams, mainly due
    to increased availability of high-quality baseline geospatial datasets.

    [You can use this web app to visualize MERIT Hydro data.](https://meritdataset.users.earthengine.app/view/merit-hydro-visualization-and-interactive-map)
    [The app's source code is available.](https://github.com/google/earthengine-community/blob/master/datasets/scripts/Hydro_Visualization.js)

    Known Problems:

    * River width (Update from GWD-LR v1): Width algorithm was updated to consider
      sub-pixel water fraction. Now, 30 m water map is used for width calculation at
      90 m resolution. Currently river width is calculated for each channel separately
      in braided/anabranching sections. Merged river width should be calculated.
    * Water body map: There are some inconsistencies between the DEM land sea mask and
      wate body data (such as new islands along the coast). The quality of OpenStreeetMap
      water body layer is not uniform in all areas.
    * Channel bifurcations: Channel bifurcation is not well represented in the current
      version. Each pixel is assumed to have only one downstream direction. Secondary
      (or multiple) downstream direction should be considered, to represent complex
      river networks in the delta regions, floodplains, and braided rivers.
    * Underground rivers/tunnels: Major underground rivers/tunnels should be implemented
      to improve large-scale water balance.
    * River/lake separation: Rivers and lakes need to be separated better for some applications.
    * Below-sea-level areas: The areas below sea level in coastal regions are not well
      represented in adjusted elevation data.
    * Flow direction over glaciers: Flow direction over glaciers is not well represented,
      because the elevation of glacier centerline is higher than glacier edge.
    * Supplementary data: It would be better to add location of GRDC gauging stations, water
      falls, reservoirs, etc.

    Data Sources:

    * [U-Tokyo MERIT DEM](http://hydro.iis.u-tokyo.ac.jp/~yamadai/MERIT_DEM/index.html)
    * [U-Tokyo G1WBM water body data](http://hydro.iis.u-tokyo.ac.jp/~yamadai/G3WBM/index.html)
    * [OpenStreetMap water body layer](http://hydro.iis.u-tokyo.ac.jp/~yamadai/OSM_water/index.html)
    * [EC-JRC Global Surface Water Occurrence](http://hydro.iis.u-tokyo.ac.jp/~yamadai/G3WBM/index.html)
    * [U-Maryland Landsat forest cover data](https://glad.earthengine.app/view/global-forest-change)
  |||,
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
      92.77,
    ],
    'eo:bands': [
      {
        name: 'elv',
        description: 'Elevation',
        'gee:units': units.meter,
      },
      {
        name: 'dir',
        description: |||
          Flow Direction (Local Drainage Direction)

          * 1: east
          * 2: southeast
          * 4: south
          * 8: southwest
          * 16: west
          * 32: northwest
          * 64: north
          * 128: northeast
          * 0: river mouth
          * -1: inland depression
        |||,
      },
      {
        name: 'wth',
        description: |||
          River channel width at the channel centerlines. River channel width is
          calculated by the method described in [Yamazaki et al. 2012, WRR], with some
          improvements/changes on the algorithm.
        |||,
      },
      {
        name: 'wat',
        description: 'Land and permanent water\n\n* 0: Land\n* 1: permanent water',
      },
      {
        name: 'upa',
        description: 'Upstream drainage area (flow accumulation area)',
        'gee:units': units.square_km,
      },
      {
        name: 'upg',
        description: 'Upstream drainage pixel (flow accumulation grid).',
        'gee:units': 'Number of upstream pixels',
      },
      {
        name: 'hnd',
        description: |||
          Hydrologically adjusted elevations, also know as "hand" (height above
          the nearest drainage). The elevations are adjusted to
          satisfy the condition "downstream is not higher than its upstream" while
          minimizing the required modifications from the original DEM.  The elevation
          above EGM96 geoid is represented in meters, and the vertical increment is set to
          10cm. For detailed method, see [Yamazaki et al., 2012, WRR].
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'viswth',
        description: 'Visualization of the river channel width.',
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
            bands: [
              'viswth',
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
    [doi:10.1029/2019WR024873](https://doi.org/10.1029/2019WR024873)
  |||,
  'gee:terms_of_use': |||
    Citation to the paper is adequate if you simply use MERIT Hydro. If you
    asked for help for additional handling/editing of the dataset, or if your research
    outcome highly depends on the product, the developer would request co-authorship.

    MERIT Hydro is licensed under a Creative Commons "CC-BY-NC 4.0" or Open
    Data Commons "Open Database License (ODbL 1.0)".  With a dual license, you can
    choose an appropriate license for you.

    To view a copy of these license, please visit:

    * [CC-BY-NC 4.0 license](https://creativecommons.org/licenses/by-nc/4.0/):
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
