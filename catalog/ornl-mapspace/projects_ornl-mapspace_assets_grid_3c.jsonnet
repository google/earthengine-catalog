local id = 'projects/ornl-mapspace/assets/grid_3c';
local subdir = 'ornl-mapspace';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc0_1_0;
local basename = std.strReplace(id, '/', '_');

local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local units = import 'units.libsonnet';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'MapSpace Global Residential/Non_Residential Land Use Model',
  'gee:type': ee_const.gee_type.image_collection,
  description: ||| 
    Global residential/non-residential land use classification generated based on spatial distribution and semantic attributes of Points of Interest (POI) data.
      
    Please refer to the [journal article](https://doi.org/10.1080/17538947.2023.2174607) for technical details about the methodology used to generate the dataset. 

    See [Office Website of MapSpace Program](
    https://mapspace.ornl.gov) for
    more details.
  |||,

  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),

  ],
  keywords: [
    'land_use',
    'points_of_interest',
    'ornl'
  ],
  providers: [
    ee.producer_provider('ORNL', 'https://doi.org/10.17605/OSF.IO/395ZF'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2024-11-01T00:00:00Z', '2025-11-01T00:00:00Z'),
  summaries: {

    gsd: [500],
 
    'eo:bands': [
      {
      name: 'classification',
      description: 'Land use class labels',
      'gee:classes': [
          {
            value: 10,
            color: '3eca76',
            description: 'Residential',
          },
                    {
            value: 20,
            color: 'cf6aa6',
            description: 'Non-Residential',
          },
                    {
            value: 30,
            color: 'e6e5d8',
            description: 'Open Space',
          },
      ],
    }, 
    {
      name: 'residential',
      description: 'Probability of being residential land use',     
    },
        {
      name:'non-residential',
      description: 'Probability of being non-residential land use',    
    },
    {
      name:'open-space',
      description:'Probability of being open space land use',
    },
    ],
    'gee:visualizations': [{
      display_name: 'Residential/Non-Residential Land Use Model',
      lookat: {lon: -88.25, lat: 37.06, zoom: 8},
      image_visualization: {
        band_vis: {
          min: [10],
          max: [30],
          palette: [
              '313695',
              '74add1',
              'fed976',
                    ],
          bands: ['label'],
        },
      },
    }],
  },
  
  
  'sci:citation': ||| 
  Fan, Junchuan & Thakur, Gautam (2024), Three-class Global POI-based land use map, Dataset, [https://doi.org/10.17605/OSF.IO/395ZF](https://doi.org/10.17605/OSF.IO/395ZF)
|||,
  'sci:publications': ||| 
  Fan, J., & Thakur, G. (2023). Towards POI-based large-scale land use modeling: spatial scale, semantic granularity and geographic context. International Journal of Digital Earth, 16(1), 430–445. [https://doi.org/10.1080/17538947.2023.2174607](https://doi.org/10.1080/17538947.2023.2174607)
|||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
