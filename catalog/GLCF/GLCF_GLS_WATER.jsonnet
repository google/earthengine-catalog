local id = 'GLCF/GLS_WATER';
local subdir = 'GLCF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

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
  title: 'GLCF: Landsat Global Inland Water',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Global Inland Water dataset shows inland surface water bodies, including
    fresh and saline lakes, rivers, and reservoirs.

    From the GLS 2000 epoch, 3,650,723 km2 of inland water were identified,
    around three quarters of which were in North America and Asia. Boreal
    forests and tundra hold the largest portion of inland water, about 40% of
    the global total. The data exhibits strong linear correlation with both the
    MODIS dataset as well as 30-m resolution datasets over the United States
    and Canada. Residual errors were due primarily to the seasonality of water
    cover, snow and ice, and residual clouds.

    The dataset contains one or more image for each available Landsat WRS2
    path/row.

    Documentation:

    * [User's guide](https://lpdaac.usgs.gov/documents/1371/GFCC_User_Guide_V1.pdf)

    * [Algorithm Theoretical Basis Document (ATBD)](https://lpdaac.usgs.gov/documents/1370/GFCC_ATBD.pdf)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'glcf',
    'landsat_derived',
    'nasa',
    'umd',
    'water',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://doi.org/10.5067/MEASURES/GFCC/GFCC30WC.001'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1398831362-LPDAAC_ECS',
  ],
  extent: ee.extent_global('2000-01-01T00:00:00Z', '2000-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'path',
        description: 'Path',
        type: ee_const.var_type.double,
      },
      {
        name: 'pathrow',
        description: 'Path and row',
        type: ee_const.var_type.string,
      },
      {
        name: 'row',
        description: 'Row',
        type: ee_const.var_type.double,
      },
      {
        name: 'water_class_names',
        description: 'Water class names',
        type: ee_const.var_type.double,
      },
      {
        name: 'water_class_palette',
        description: 'Water class palette',
        type: ee_const.var_type.double,
      },
      {
        // Always [1,2,4,200,201]
        name: 'water_class_values',
        description: 'Water class values',
        type: ee_const.var_type.int_list,
      },
    ],
    gsd: [
      30.0,
    ],
    platform: [
      'Landsat-5',
      'Landsat-7',
    ],
    instruments: [
      'TM',
      'ETM+',
    ],
    'eo:bands': [
      {
        name: 'water',
        description: 'Water classification',
        'gee:classes': [
          {
            value: 1,
            color: 'FAFAFA',
            description: 'Land',
          },
          {
            value: 2,
            color: '00C5FF',
            description: 'Water',
          },
          {
            value: 4,
            color: 'DF73FF',
            description: 'Snow/ice',
          },
          {
            value: 200,
            color: '828282',
            description: 'Cloud shadow',
          },
          {
            value: 201,
            color: 'CCCCCC',
            description: 'Cloud',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Water',
        lookat: {
          lat: -85.122,
          lon: 44.871,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              4.0,
            ],
            palette: [
              'FAFAFA',
              '00C5FF',
              'DF73FF',
              '828282',
              'CCCCCC',
            ],
            bands: [
              'water',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Data Citation: Global Inland Water, {Year, ...}, Global Land Cover
    Facility, [www.landcover.org](www.landcover.org).
  |||,
  'sci:publications': [
    {
      citation: |||
        Paper/Methods Citation: Feng, Min, Joseph O. Sexton, Saurabh Channan,
        and John R. Townshend. 2015. [A Global, High-Resolution (30-M) Inland Water
        Body Dataset for 2000: First Results of a Topographic-Spectral
        Classification Algorithm](https://www.tandfonline.com/doi/pdf/10.1080/17538947.2015.1026420).
        International Journal of Digital Earth.
        [doi:10.1080/17538947.2015.1026420](https://doi.org/10.1080/17538947.2015.1026420).
      |||,
      doi: '10.1080/17538947.2015.1026420',
    },
  ],
  'gee:terms_of_use': |||
    Intellectual property rights to this dataset belong to University of
    Maryland, Department of Geographical Sciences and NASA. Usage is free if
    acklowedgement is made.
  |||,
}
