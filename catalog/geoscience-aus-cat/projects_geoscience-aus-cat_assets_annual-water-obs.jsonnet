local id = 'projects/geoscience-aus-cat/assets/annual-water-obs';
local subdir = 'geoscience-aus-cat';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local version = '3.1.6';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  version: version,
  title: 'DEA Water Observations Statistics ' + version,
  'gee:type': ee_const.gee_type.image,
  description: |||
    These are the statistics generated from the DEA Water Observations (Water Observations from Space) suite of products, which gives summaries of how often surface water was observed by the Landsat satellites per calendar year.
    Water Observations Statistics provides information on how many times the Landsat satellites were able to clearly see an area, how many times those observations were wet, and what that means for the percentage of time that water was observed in the landscape.

    This product is part of the [Digital Earth Australia Program](https://www.dea.ga.gov.au/)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1016/j.rse.2015.11.003',
      type: ee_const.media_type.html,
    },
    {
      rel: ee_const.rel.source,
      href: 'https://data.dea.ga.gov.au/?prefix=derivative/ga_ls_wo_fq_cyear_3/',
    },
  ],
  keywords: [
    'australia',
    'ga',
    'landsat_derived',
    'water',
  ],
  providers: [
    ee.producer_provider(
      'Geoscience Australia',
      'https://cmi.ga.gov.au/data-products/dea/686/dea-water-observations-statistics-landsat'),
    // ee.processor_provider('NGIS', 'https://ngis.com.au/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
    108.81, -44.41, 157.82, -9.13,
    '1987-01-01T00:00:00Z', null),
  summaries: {
    gsd: [25],
    'eo:bands': [
      {
        name: 'B01',
        description: |||
          Clear count: how many times an area could be clearly seen, i.e., not affected by clouds, shadows, or other satellite observation problems.
        |||,
        'gee:units': units.count,
      },
      {
        name: 'B02',
        description: |||
          Wet count: how many times water was detected in observations that were clear.
        |||,
        'gee:units': units.count,
      },
      {
        name: 'B03',
        description: |||
          Water frequency: what percentage of clear observations were detected as wet.
        |||,
        'gee:units': units.percent,
      },
    ],
    B01: {minimum: -32768, maximum: 32767, 'gee:estimated_range': true},
    B02: {minimum: -32768, maximum: 32767, 'gee:estimated_range': true},
    B03: {minimum: 0, maximum: 1, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Wet count',
        lookat: {lon: 133.88, lat: -23.70, zoom: 5},
        image_visualization: {band_vis: {bands: ['B02']}},
      },
    ],
  },
  'sci:doi': '10.1016/j.rse.2015.11.003',
  'sci:citation': |||
    Mueller, N., Lewis, A., Roberts, D., Ring, S., Melrose, R., Sixsmith, J., Lymburner, L., McIntyre, A., Tan, P., Curnow, S., & Ip, A. (2016). Water observations from space: Mapping surface water from 25 years of Landsat imagery across Australia. Remote Sensing of Environment, 174, 341-352
    [doi:10.1016/j.rse.2015.11.003](https://doi.org/10.1016/j.rse.2015.11.003)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
