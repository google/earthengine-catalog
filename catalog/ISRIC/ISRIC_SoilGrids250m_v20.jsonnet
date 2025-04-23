local id = 'ISRIC/SoilGrids250m/v20';
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
        name: 'wv0010_0-5cm',
        description: 'Volumetric Water Content at 10kPa (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0010_5-15cm',
        description: 'Volumetric Water Content at 10kPa (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0010_15-30cm',
        description: 'Volumetric Water Content at 10kPa (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0010_30-60cm',
        description: 'Volumetric Water Content at 10kPa (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0010_60-100cm',
        description: 'Volumetric Water Content at 10kPa (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0010_100-200cm',
        description: 'Volumetric Water Content at 10kPa (100-200cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0033_0-5cm',
        description: 'Volumetric Water Content at 33kPa (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0033_5-15cm',
        description: 'Volumetric Water Content at 33kPa (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0033_15-30cm',
        description: 'Volumetric Water Content at 33kPa (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0033_30-60cm',
        description: 'Volumetric Water Content at 33kPa (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0033_60-100cm',
        description: 'Volumetric Water Content at 33kPa (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv0033_100-200cm',
        description: 'Volumetric Water Content at 33kPa (100-200cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv1500_0-5cm',
        description: 'Volumetric Water Content at 1500kPa (0-5cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv1500_5-15cm',
        description: 'Volumetric Water Content at 1500kPa (5-15cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv1500_15-30cm',
        description: 'Volumetric Water Content at 1500kPa (15-30cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv1500_30-60cm',
        description: 'Volumetric Water Content at 1500kPa (30-60cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv1500_60-100cm',
        description: 'Volumetric Water Content at 1500kPa (60-100cm depth)',
        'gee:units': units.volumetric_content,
      },
      {
        name: 'wv1500_100-200cm',
        description: 'Volumetric Water Content at 1500kPa (100-200cm depth)',
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
          band_vis: {bands: ['wv0010_0-5cm']},
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
