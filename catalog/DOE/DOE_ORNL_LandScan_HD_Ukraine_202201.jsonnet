local id = 'DOE/ORNL/LandScan_HD/Ukraine_202201';
local subdir = 'DOE';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LandScan High Definition Data for Ukraine, January 2022',
  version: '202201',
  'gee:type': ee_const.gee_type.image,
  description: |||
    [LandScan High Definition (HD)](https://landscan.ornl.gov)
    provides gridded population estimates at 3
    arc-second (~100m) resolution. Values for each LandScan HD cell represent an
    ambient (i.e. 24 hour average) population count estimate.  In this way, the
    data capture the full potential activity space of people throughout the
    course of the day and night rather than just a residential location. The
    LandScan HD model incorporates current land use and infrastructure data from
    a variety of sources, applies facility occupancy estimates from ORNL's
    Population Density Tables (PDT) project, and leverages novel image
    processing algorithms developed at ORNL to rapidly map building
    structures and neighborhood areas using high-performance computing
    environments.

    The source for subnational population counts used in the development of this
    data comes from
    [State Statistics Service of Ukraine](https://ukrstat.org/en/operativ/operativ2021/ds/kn/arh_kn2021_e.html).

    These subnational estimates were adjusted to the country total population
    provided by the
    [CIA World Factbook](https://www.cia.gov/the-world-factbook/countries/ukraine/#people-and-society).
  |||,
  license: license.id,
  links:  ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://landscan.ornl.gov/sites/default/files/ukraine2022/LandScanHDUkraine.zip',
    },
    ee.link.license(license.reference),
  ],
  'gee:categories': ['population'],
  keywords: [
    'landscan',
    'population',
    'ukraine',
  ],
  providers: [
    ee.producer_provider(
        'Oak Ridge National Laboratory',
        'https://landscan.ornl.gov/ukraine-landscan-hd-data'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(22.125, 44.175, 40.225, 52.4,
                    '2022-01-01T00:00:00Z', '2022-02-01T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'population',
        description: '24 hour average population count estimate'
      },
    ],
    population: {
      minimum: 0.0,
      maximum: 1020.0,
      'gee:estimated_range': true,
    },
    'gee:visualizations': [
      {
        display_name: 'Population count',
        lookat: {
          lat: 48.2875,
          lon: 31.175,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              -0.0,
            ],
            max: [
              10.0,
            ],
            bands: [
              'population',
            ],
            palette:['lemonchiffon', 'khaki', 'orange','orangered', 'red', 'maroon'],
          },
        },
      },
    ],
  },
 'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/).'
  |||,
}
