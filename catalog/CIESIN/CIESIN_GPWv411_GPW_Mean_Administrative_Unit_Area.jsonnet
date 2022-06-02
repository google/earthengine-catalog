local id = 'CIESIN/GPWv411/GPW_Mean_Administrative_Unit_Area';
local subdir = 'CIESIN';

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
  title: 'GPWv411: Mean Administrative Unit Area (Gridded Population of the World Version 4.11)',
  version: 'v4.11',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The Gridded Population of World Version 4 (GPWv4), Revision 11 models the distribution
    of global human population for the years 2000, 2005, 2010, 2015, and 2020
    on 30 arc-second (approximately 1km) grid cells. Population is distributed
    to cells using proportional allocation of population from census and
    administrative units. Population input data are collected at the most
    detailed spatial resolution available from the results of the 2010 round of
    censuses, which occurred between 2005 and 2014. The input data are
    extrapolated to produce population estimates for each modeled year.

    The mean area of the input unit(s) from which population count and density grids are created.

    [General documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-admin-unit-center-points-population-estimates-rev11/docs)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.7927/H42Z13KG',
    },
  ],
  keywords: [
    'ciesin',
    'gpw',
    'nasa',
    'population',
  ],
  providers: [
    ee.producer_provider('NASA SEDAC at the Center for International Earth Science Information Network', 'https://doi.org/10.7927/H42Z13KG'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1596819702-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'mean_administrative_unit_area',
        description: |||
          Displays a quantitative surface that indicates the size of the
          input units in square kilometers from which population count and
          density grids are derived.
        |||,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Mean Administrative Unit Area',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              40000.0,
            ],
            palette: [
              'e7cdff',
              'd5a2ee',
              'c480e5',
              'b561dd',
              'a042ce',
              '4d0072',
            ],
            bands: [
              'mean_administrative_unit_area',
            ],
          },
        },
      },
    ],
    mean_administrative_unit_area: {
      minimum: 0.0,
      maximum: 767642.0,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H42Z13KG',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2016. Gridded Population of the World, Version 4
    (GPWv4): Mean Administrative Unit Area, Revision 11.
    Palisades, NY: NASA Socioeconomic Data and Applications Center
    (SEDAC). [https://doi.org/10.7927/H42Z13KG](https://doi.org/10.7927/H42Z13KG).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution 4.0 International License.',
  'gee:user_uploaded': true,
}
