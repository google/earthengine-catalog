local id = 'Tsinghua/FROM-GLC/GAIA/v10';
local subdir = 'Tsinghua';

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
  ],
  id: id,
  title: 'Tsinghua FROM-GLC Year of Change to Impervious Surface',
  'gee:type': ee_const.gee_type.image,
  description: |||
    This dataset contains annual change information of global impervious surface area from 1985 to
    2018 at a 30m resolution. Change from pervious to impervious was determined using a combined
    approach of supervised classification and temporal consistency checking. Impervious pixels are
    defined as above 50% impervious. The year of the transition (from pervious to impervious) can
    be identified from the pixel value, ranging from 34 (year: 1985) to 1 (year: 2018). For
    example, the impervious surface in 1990 can be revealed as the pixel value greater than 29
    (see the lookup table). This dataset is temporally consistent, following the conversion from
    pervious (e.g., non-urban) to impervious (e.g., urban) monotonically. For more information
    about the mapping approach and assessment, see
    [Annual maps of global artificial impervious area (GAIA) between 1985 and 2018
    (Gong et al. 2020)](https://doi.org/10.1016/j.rse.2019.111510).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'http://data.ess.tsinghua.edu.cn/fromglc2017v1.html',
    },
  ],
  keywords: [
    'built',
    'development',
    'impervious',
    'tsinghua',
    'urban',
  ],
  providers: [
    ee.producer_provider('Tsinghua University', 'http://data.ess.tsinghua.edu.cn/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1985-01-01T00:00:00Z', '2018-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'change_year_index',
        description: 'Year of the transition from from pervious to impervious. From 34 (year: 1985) to 1 (year: 2018)',
        'gee:classes': [
          {
            value: 1,
            color: '014352',
            description: '2018',
          },
          {
            value: 2,
            color: '1A492C',
            description: '2017',
          },
          {
            value: 3,
            color: '071EC4',
            description: '2016',
          },
          {
            value: 4,
            color: 'B5CA36',
            description: '2015',
          },
          {
            value: 5,
            color: '729EAC',
            description: '2014',
          },
          {
            value: 6,
            color: '8EA5DE',
            description: '2013',
          },
          {
            value: 7,
            color: '818991',
            description: '2012',
          },
          {
            value: 8,
            color: '62A3C3',
            description: '2011',
          },
          {
            value: 9,
            color: 'CCF4FE',
            description: '2010',
          },
          {
            value: 10,
            color: '74F0B9',
            description: '2009',
          },
          {
            value: 11,
            color: '32BC55',
            description: '2008',
          },
          {
            value: 12,
            color: 'C72144',
            description: '2007',
          },
          {
            value: 13,
            color: '56613B',
            description: '2006',
          },
          {
            value: 14,
            color: 'C14683',
            description: '2005',
          },
          {
            value: 15,
            color: 'C31C25',
            description: '2004',
          },
          {
            value: 16,
            color: '5F6253',
            description: '2003',
          },
          {
            value: 17,
            color: '11BF85',
            description: '2002',
          },
          {
            value: 18,
            color: 'A61B26',
            description: '2001',
          },
          {
            value: 19,
            color: '99FBC5',
            description: '2000',
          },
          {
            value: 20,
            color: '188AAA',
            description: '1999',
          },
          {
            value: 21,
            color: 'C2D7F1',
            description: '1998',
          },
          {
            value: 22,
            color: 'B7D9D8',
            description: '1997',
          },
          {
            value: 23,
            color: '856F96',
            description: '1996',
          },
          {
            value: 24,
            color: '109C6B',
            description: '1995',
          },
          {
            value: 25,
            color: '2DE3F4',
            description: '1994',
          },
          {
            value: 26,
            color: '9A777D',
            description: '1993',
          },
          {
            value: 27,
            color: '151796',
            description: '1992',
          },
          {
            value: 28,
            color: 'C033D8',
            description: '1991',
          },
          {
            value: 29,
            color: '510037',
            description: '1990',
          },
          {
            value: 30,
            color: '640C21',
            description: '1989',
          },
          {
            value: 31,
            color: '31A191',
            description: '1988',
          },
          {
            value: 32,
            color: '223AB0',
            description: '1987',
          },
          {
            value: 33,
            color: 'B692AC',
            description: '1986',
          },
          {
            value: 34,
            color: '2DE3F4',
            description: '1985',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Change year index',
        lookat: {
          lat: 25.8,
          lon: -37.62,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              34.0,
            ],
            palette: [
              '014352',
              '1A492C',
              '071EC4',
              'B5CA36',
              '729EAC',
              '8EA5DE',
              '818991',
              '62A3C3',
              'CCF4FE',
              '74F0B9',
              '32BC55',
              'C72144',
              '56613B',
              'C14683',
              'C31C25',
              '5F6253',
              '11BF85',
              'A61B26',
              '99FBC5',
              '188AAA',
              'C2D7F1',
              'B7D9D8',
              '856F96',
              '109C6B',
              '2DE3F4',
              '9A777D',
              '151796',
              'C033D8',
              '510037',
              '640C21',
              '31A191',
              '223AB0',
              'B692AC',
              '2DE3F4',
            ],
            bands: [
              'change_year_index',
            ],
          },
        },
      },
    ],
    change_year_index: {
      minimum: 1.0,
      maximum: 34.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    Gong, P., Li, X., Wang, J., Bai, Y., Chen, B., Hu, T., ... & Zhou, Y. (2020).
    Annual maps of global artificial impervious area (GAIA) between 1985 and 2018.
    Remote Sensing of Environment, 236, 111510.
  |||,
  'gee:terms_of_use': |||
    This work is licensed under a Creative Commons Attribution 4.0 International License.
    [https://creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/)
  |||,
}
