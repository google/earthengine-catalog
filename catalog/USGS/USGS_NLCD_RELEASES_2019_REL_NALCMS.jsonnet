local id = 'USGS/NLCD_RELEASES/2019_REL/NALCMS';
local subdir = 'USGS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc0_1_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  // TODO(schwehr): Remove skip_indexing when the preview image is ready.
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
  // TODO(schwehr): help with title, version, and column width in description please
  title: '2020 Land Cover of North America at 30 meters',
  version: '1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The 2020 North American Land Cover 30-meter dataset was produced as part of the 
    North American Land Change Monitoring System (NALCMS), a trilateral effort between 
    Natural Resources Canada, the United States Geological Survey, and three Mexican 
    organizations including the National Institute of Statistics and Geography 
    (Instituto Nacional de Estadística y Geografía), National Commission for the Knowledge 
    and Use of the Biodiversity (Comisión Nacional Para el Conocimiento y Uso de la 
    Biodiversidad), and the National Forestry Commission of Mexico (Comisión Nacional Forestal). 
    The collaboration is facilitated by the Commission for Environmental Cooperation, an 
    international organization created by the Canada, Mexico, and United States governments 
    under the North American Agreement on Environmental Cooperation to promote environmental 
    collaboration between the three countries.

    The general objective of NALCMS is to devise, through collective effort, a harmonized 
    multi-scale land cover monitoring approach which ensures high accuracy and consistency 
    in monitoring land cover changes at the North American scale and which meets each country’s 
    specific requirements.  

    This 30-meter dataset of North American Land Cover reflects land cover information for 2020 
    from Mexico and Canada, 2019 over the conterminous United States and 2021 over Alaska. 
    Each country developed its own classification method to identify Land Cover classes and 
    then provided an input layer to produce a continental Land Cover map across North America. 
    Canada, Mexico, and the United States developed their own 30-meter land cover products; 
    see specific sections on data generation below.

    The main inputs for image classification were 30-meter Landsat 8 Collection 2 Level 1 data in the 
    three countries (Canada, the United States and Mexico). Image selection processes and reduction to 
    specific spectral bands varied among the countries due to study-site-specific requirements. 
    While Canada selected most images from the year 2020 with a few from 2019 and 2021, the Conterminous 
    United States employed mainly images from 2019, while Alaska land cover maps are mainly based on the 
    use of images from 2021. The land cover map for Mexico was based on land cover change detection 
    between 2015 and 2020 Mexico Landsat 8 mosaics.

    In order to generate a seamless and consistent land cover map of North America, national maps were 
    generated for Canada by the CCRS; for Mexico by CONABIO, INEGI, and CONAFOR; and for the United States 
    by the USGS. Each country chose their own approaches, ancillary data, and land cover mapping methodologies
    to create national datasets. This North America dataset was produced by combining the national land cover datasets. 
    The integration of the three national products merged four Land Cover map sections, Alaska, Canada, 
    the conterminous United States and Mexico.

    See also:

    * Natural Resources Canada has North American Land Cover information available online at 
      (https://open.canada.ca/data/en/dataset/ee1580ab-a23d-4f86-a09b-79763677eb47)
 
    * The National Commission for the Knowledge and Use of Biodiversity has North American Land Cover 
    information available online at (https://www.biodiversidad.gob.mx/monitoreo/cobertura-suelo)

    * The U.S. Geological Survey has North American Land Cover information available online at (www.mrlc.gov)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'land_surface',
    'land_use',
    'land_cover',
    'reflectance',
    'landsat',
    'remote_sensing',
    'north_america',
  ],
  providers: [
    ee.producer_provider(
      'The Commission for Environmental Cooperation (CEC)',
      'http://www.cec.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      175, 14, -50, 84,
      '2019-01-01T00:00:00Z',
      '2021-12-31T00:00:00Z'),
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [30],
    'eo:bands': [
      {
        name: 'landcover',
        description: |||'Land cover classification grid cell value. Values are categorized into the following: 1 = Temperate or sub-polar needleleaf forest, 2 = Sub-polar taiga needleleaf forest, 3 = Tropical or sub-tropical broadleaf evergreen forest, 4 = Tropical or sub-tropical broadleaf deciduous forest, 5 = Temperate or sub-polar broadleaf deciduous forest, 6 = Mixed forest, 7 = Tropical or sub-tropical shrubland, 8 = Temperate or sub-polar shrubland, 9 = Tropical or sub-tropical grassland, 10 = Temperate or sub-polar grassland, 11 = Sub-polar or polar shrubland-lichen-moss, 12 = Sub-polar or polar grassland-lichen-moss, 13 = Sub-polar or polar barren-lichen-moss, 14 = Wetland, 15 = Cropland, 16 = Barren lands, 17 = Urban and built-up, 18 = Water, 19 = Snow and ice.'|||,
        'gee:units': units_class,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'landcover',
        lookat: {
          lat: 38,
          lon: -114,
          zoom: 6,
        },
        image_visualization: {
          band_vis: {
            min: [
              0,
            ],
            max: [
              100,
            ],
            palette: [
              '000000',
              'f9e8b7',
              'f7e3ac',
              'f0dfa3',
              'eedf9c',
              'eada91',
              'e8d687',
              'e0d281',
              'ddd077',
              'd6cc6d',
              'd3c667',
              'd0c55e',
              'cfc555',
              'c6bd4f',
              'c4ba46',
              'bdb83a',
              'bbb534',
              'b7b02c',
              'b0ad1f',
              'adac17',
              'aaaa0a',
              'a3a700',
              '9fa700',
              '9aa700',
              '92a700',
              '8fa700',
              '87a700',
              '85a700',
              '82aa00',
              '7aaa00',
              '77aa00',
              '70aa00',
              '6caa00',
              '67aa00',
              '5fa700',
              '57a700',
              '52a700',
              '4fa700',
              '4aa700',
              '42a700',
              '3ca700',
              '37a700',
              '37a300',
              '36a000',
              '369f00',
              '349d00',
              '339900',
              '339900',
              '2f9200',
              '2d9100',
              '2d8f00',
              '2c8a00',
              '2c8800',
              '2c8500',
              '2c8400',
              '2b8200',
              '297d00',
              '297a00',
              '297900',
              '277700',
              '247400',
              '247000',
              '29700f',
              '2c6d1c',
              '2d6d24',
              '336d2d',
              '366c39',
              '376c44',
              '396a4a',
              '396a55',
              '3a6a5f',
              '3a696a',
              '396774',
              '3a6782',
              '39668a',
              '376292',
              '34629f',
              '2f62ac',
              '2c5fb7',
              '245ec4',
              '1e5ed0',
              '115cdd',
              '005ae0',
              '0057dd',
              '0152d6',
              '0151d0',
              '014fcc',
              '014ac4',
              '0147bd',
              '0144b8',
              '0142b0',
              '0141ac',
              '013da7',
              '013aa0',
              '01399d',
              '013693',
              '013491',
              '012f8a',
              '012d85',
              '012c82',
              '01297a'
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
    landcover: {
      minimum: 1,
      maximum: 19,
      'gee:estimated_range': false,
    },
  },
  // TODO(schwehr): this will not be published on ScienceBase. I'm having a hard time finding a good citation/DOI to use for this area. Open to suggestions. Can it be left off?
  'sci:citation': |||
    Rigge, M.B., Bunde, B., Postma, K., Shi, H., 2022, Rangeland Condition
    Monitoring Assessment and Projection (RCMAP) Fractional Component
    Time-Series Across the Western U.S. 1985-2021: U.S. Geological Survey data
    release.
    [doi:10.5066/P9ODAZHC](https://doi.org/10.5066/P9ODAZHC)
  |||,
  'sci:doi': '10.5066/P9ODAZHC',
  // TODO(schwehr): Update terms_of_use to pull from script. Okay to go with this same one for the nalcms?
  'gee:terms_of_use': |||
    This work was authored as part of the Contributor's official duties as an
    Employee of the United States Government and is therefore a work of the
    United States Government. In accordance with 17 U.S.C. 105, no copyright
    protection is available for such works under U.S. Law. This is an Open
    Access article that has been identified as being free of known restrictions
    under copyright law, including all related and neighboring rights
    (https://creativecommons.org/publicdomain/mark/1.0/). You can copy, modify,
    distribute and perform the work, even for commercial purposes, all without
    asking permission.
  |||,
}
