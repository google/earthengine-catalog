local id = 'CIESIN/GPWv4/population-density';
local successor_id = 'CIESIN/GPWv411/GPW_Population_Density';
local subdir = 'CIESIN';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
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
  title: 'GPWv4: Gridded Population of the World Version 4, Population Density [deprecated]',
  version: 'v4',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Gridded Population of World Version 4 (GPWv4) models the distribution
    of global human population for the years 2000, 2005, 2010, 2015, and 2020
    on 30 arc-second (approximately 1km) grid cells. Population is distributed
    to cells using proportional allocation of population from census and
    administrative units. Population input data are collected at the most
    detailed spatial resolution available from the results of the 2010 round of
    censuses, which occurred between 2005 and 2014. The input data are
    extrapolated to produce population estimates for each modeled year.

    These population density grids contain estimates of the number of persons
    per square kilometer consistent with national censuses and population
    registers. There is one image for each modeled year.

    [General Documentation](https://sedac.ciesin.columbia.edu/data/set/gpw-v4-population-count-rev11/docs)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
    {
      rel: 'cite-as',
      href: 'https://doi.org/10.7927/H4NP22DQ',
    },
  ],
  keywords: [
    'ciesin',
    'gpw',
    'population',
  ],
  providers: [
    ee.producer_provider('CIESIN', 'https://sedac.ciesin.columbia.edu/data/collection/gpw-v4'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1418756598-SEDAC',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'population-density',
        description: 'The estimated number of persons per square kilometer.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Population Density',
        lookat: {
          lat: 19.81,
          lon: 79.1,
          zoom: 3,
        },
        image_visualization: {
          band_vis: {
            min: [
              200.0,
            ],
            max: [
              1500.0,
            ],
            palette: [
              'ffffff',
              'ffcdc6',
              'ff0000',
              '950000',
            ],
            bands: [
              'population-density',
            ],
          },
        },
      },
    ],
    'population-density': {
      minimum: 0.0,
      maximum: 3962319.25,
      'gee:estimated_range': true,
    },
  },
  'sci:doi': '10.7927/H4NP22DQ',
  'sci:citation': |||
    Center for International Earth Science Information Network - CIESIN -
    Columbia University. 2016. Gridded Population of the World, Version 4
    (GPWv4): Population Density. Palisades, NY: NASA Socioeconomic Data and
    Applications Center (SEDAC). [https://doi.org/10.7927/H4NP22DQ](https://doi.org/10.7927/H4NP22DQ).
    Accessed DAY MONTH YEAR.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 5,
  },
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution 4.0 International License.',
}
