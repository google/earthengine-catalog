local id = 'ISRIC/SoilGrids250m/v2_0';
local subdir = 'ISRIC';
local version = 'v1';
local latest_id = id;

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: "SoilGrids250m 2.0 - Volumetric Water Content",
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Volumetric Water Content at 10kPa, 33kPa, and 1500kPa suction in
    10^-3 cm^3/cm^3 (0.1 v% or 1 mm/m) at 6 standard depths (0-5cm, 5-15cm,
    15-30cm, 30-60cm, 60-100cm, 100-200cm). Predictions were derived using a
    digital soil mapping approach based on Quantile Random Forest, drawing on a
    global compilation of soil profile data and environmental layers.
    This dataset includes predictions for three different suction levels,
    providing insights into soil water availability.

    The dataset is organized into three main assets: `/wv0010`, `/wv0033`,
    and `/wv1500`. Each of these assets contains bands representing soil
    properties at different depths and quantiles. The band names follow the
    pattern `val_<depth>_<quantile>`, where `depth` represents a soil depth
    range (e.g., 0-5cm, 5-15cm, 15-30cm, 30-60cm, 60-100cm, 100-200cm) and
    `quantile` represents a statistical measure (e.g., mean, Q0.05, Q0.5,
    Q0.95).

    The uncertainty band is not yet included. It is possible to calculate
    the uncertainty from the ratio between the inter-quantile range
    (90% prediction interval width) and the median: (Q0.95-Q0.05)/Q0.50.

    Documentation:

    * [Scientific Paper](https://www.sciencedirect.com/science/article/pii/S2095633922000636?via%3Dihub)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://www.isric.org/explore/soilgrids',
    },
  ],
  'gee:categories': ['soil'],
  keywords: [
    'soil',
    'soil_moisture',
    'water'
  ],
  providers: [
    ee.producer_provider('ISRIC - World Soil Information', 'https://www.isric.org/explore/soilgrids'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180, -56, 180, 84, '1905-04-01T00:00:00Z', '2016-07-05T00:00:00Z'),
  summaries: {
    gsd:[250],
    'eo:bands': [
      {
        name: 'val_0_5cm_mean',
        description: 'Mean Volumetric Water Content (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_0_5cm_Q0_05',
        description: 'Q0.05 Volumetric Water Content (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_0_5cm_Q0_5',
        description: 'Q0.5 Volumetric Water Content (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_0_5cm_Q0_95',
        description: 'Q0.95 Volumetric Water Content (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_5_15cm_mean',
        description: 'Mean Volumetric Water Content (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_5_15cm_Q0_05',
        description: 'Q0.05 Volumetric Water Content (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_5_15cm_Q0_5',
        description: 'Q0.5 Volumetric Water Content (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_5_15cm_Q0_95',
        description: 'Q0.95 Volumetric Water Content (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_15_30cm_mean',
        description: 'Mean Volumetric Water Content (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_15_30cm_Q0_05',
        description: 'Q0.05 Volumetric Water Content (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_15_30cm_Q0_5',
        description: 'Q0.5 Volumetric Water Content (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_15_30cm_Q0_95',
        description: 'Q0.95 Volumetric Water Content (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_30_60cm_mean',
        description: 'Mean Volumetric Water Content (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_30_60cm_Q0_05',
        description: 'Q0.05 Volumetric Water Content (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_30_60cm_Q0_5',
        description: 'Q0.5 Volumetric Water Content (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_30_60cm_Q0_95',
        description: 'Q0.95 Volumetric Water Content (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_60_100cm_mean',
        description: 'Mean Volumetric Water Content (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_60_100cm_Q0_05',
        description: 'Q0.05 Volumetric Water Content (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_60_100cm_Q0_5',
        description: 'Q0.5 Volumetric Water Content (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_60_100cm_Q0_95',
        description: 'Q0.95 Volumetric Water Content (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_100_200cm_mean',
        description: 'Mean Volumetric Water Content (100-200cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_100_200cm_Q0_05',
        description: 'Q0.05 Volumetric Water Content (100-200cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_100_200cm_Q0_5',
        description: 'Q0.5 Volumetric Water Content (100-200cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'val_100_200cm_Q0_95',
        description: 'Q0.95 Volumetric Water Content (100-200cm depth)',
        'gee:units': units.volumetric_content,
      },
    ],
    'gee:visualizations': [
      {
        display_name: "Volumetric Water Content",
        lookat: {
          lon : -105.25,
          lat : 52.5,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {bands: ['val_0_5cm_mean']},
        },
      },
    ],
  },
  'sci:citation': |||
    Global mapping of volumetric water retention at 100, 330 and 15000 cm
    suction using the WoSIS database
    Turek M.E., Poggio L., Batjes N.H., Armindo R.A., de Jong van Lier Q.,
    de Sousa L., Heuvelink G.B.M. (2023)
    International Soil and Water Conservation Research, 11 (2), pp. 225-239.
  |||,
  'sci:doi': '10.1016/j.iswcr.2022.08.001',
  'gee:terms_of_use': ee.gee_terms_of_use(license)
}
