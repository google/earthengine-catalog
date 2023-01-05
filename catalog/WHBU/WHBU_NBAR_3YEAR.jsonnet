local id = 'WHBU/NBAR_3YEAR';
local subdir = 'WHBU';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
  ],
  id: id,
  title: 'MODIS 3-year Nadir BRDF-Adjusted Reflectance (NBAR) Mosaic',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The mosaics are created by using the MODIS 8-Day 500 meter
    BRDF-Albedo Quality product.  Data Quality flags are used to select
    the best observations from the MODIS 8-day 500 meter Nadir
    BRDF-Adjusted Reflectance imagery product.  This specific mosaic picks
    observations from the three highest quality categories over
    a 3-year period of MODIS data.

    The MODIS NBAR annual mosaics have been used by government
    agencies and NGOs in tropical countries as input to generate
    aboveground biomass/carbon maps. The Woods Hole Research Center has
    been using the dataset for country capacity building and technical
    training workshops in tropical countries.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.1088/1748-9326/3/4/045011',
    },
  ],
  keywords: [
    'albedo',
    'bu',
    'mcd43a4',
    'modis_derived',
    'nbar',
    'reflectance',
    'whrc',
  ],
  providers: [
    ee.producer_provider('Baccini, A. (Woods Hole Research Center), Sulla-Menashe, D. (Boston University)', 'https://doi.org/10.1088/1748-9326/3/4/045011'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -60.1, 180.0, 60.1, '2002-01-01T00:00:00Z', null),
  summaries: {
    gsd: [463],
    'eo:bands': [
      {
        name: 'Nadir_Reflectance_Band1',
        description: 'Best NBAR at local solar noon for band 1',
        center_wavelength: 0.645,
        'gee:wavelength': '620-670nm',
      },
      {
        name: 'Nadir_Reflectance_Band2',
        description: 'Best NBAR at local solar noon for band 2',
        center_wavelength: 0.8585,
        'gee:wavelength': '841-876nm',
      },
      {
        name: 'Nadir_Reflectance_Band3',
        description: 'Best NBAR at local solar noon for band 3',
        center_wavelength: 0.469,
        'gee:wavelength': '459-479nm',
      },
      {
        name: 'Nadir_Reflectance_Band4',
        description: 'Best NBAR at local solar noon for band 4',
        center_wavelength: 0.555,
        'gee:wavelength': '545-565nm',
      },
      {
        name: 'Nadir_Reflectance_Band5',
        description: 'Best NBAR at local solar noon for band 5',
        center_wavelength: 1.24,
        'gee:wavelength': '1230-1250nm',
      },
      {
        name: 'Nadir_Reflectance_Band6',
        description: 'Best NBAR at local solar noon for band 6',
        center_wavelength: 1.64,
        'gee:wavelength': '1628-1652nm',
      },
      {
        name: 'Nadir_Reflectance_Band7',
        description: 'Best NBAR at local solar noon for band 7',
        center_wavelength: 2.13,
        'gee:wavelength': '2105-2155nm',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'False Color',
        lookat: {
          lat: 15.3,
          lon: 50.08,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
              0.0,
              0.0,
            ],
            max: [
              5000.0,
              9000.0,
              7000.0,
            ],
            bands: [
              'Nadir_Reflectance_Band2',
              'Nadir_Reflectance_Band6',
              'Nadir_Reflectance_Band1',
            ],
          },
        },
      },
    ],
  },
  'sci:doi': '10.1088/1748-9326/3/4/045011',
  'sci:citation': |||
    Baccini, A., Laporte, N., Goetz, S. J., Sun, M., & Dong, H. (2008). A first map of tropical Africa's above-ground biomass derived from satellite imagery. Environmental Research Letters, 3(4), 045011. [doi:10.1088/1748-9326/3/4/045011](https://doi.org/10.1088/1748-9326/3/4/045011)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  'gee:is_derived': true,
}
