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
  title: 'MapSpace Global Residential/Non_Residential Landuse Model',
  'gee:type': ee_const.gee_type.image_collection,
  description: ||| 
    Global residential/non-residential landuse classification generated based on spatial distribution and semantic attributes of Points of Interest(POI) data.
      
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
    'landuse',
    'residential',
    'points_of_interest',
    'non_residential',
    'mapspace',
    'ornl'
  ],
  providers: [
    ee.producer_provider('ORNL', 'https://mapspace.ornl.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2024-11-01T00:00:00Z', '2025-11-01T00:00:00Z'),
  summaries: {

    gsd: [500],
    platform: ['ORNL'],
 
    'eo:bands': [
      {
      name: 'label',
      description: 'landuse class labels',
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
      description: 'probability of being residential landuse',
      
      
    },
        {
      name:'non-residential',
      description: 'probability of being non-residential landuse',
   
      
    },
        {
      name:'open-space',
      description:'probability of being open space landuse',
    
      
    },
    ],
    'gee:visualizations': [{
      display_name: 'Residential/Non-Residential Landuse Model',
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
  Fan, J., & Thakur, G. (2023). Towards POI-based large-scale land use modeling: spatial scale, semantic granularity and geographic context. International Journal of Digital Earth, 16(1), 430–445. [https://doi.org/10.1080/17538947.2023.2174607](https://doi.org/10.1080/17538947.2023.2174607)
  Fan, Junchuan & Thakur, Gautam (2024), Three-class Global POI-based land use map, Dataset, [https://doi.org/10.17605/OSF.IO/395ZF](https://doi.org/10.17605/OSF.IO/395ZF)
|||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:user_uploaded': true,
}
