local id = 'USGS/NLCD_RELEASES/2020_REL/NALCMS/2020';
local subdir = 'USGS';
local version = '1';

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
  title: 'Land Cover of North America at 30 meters, 2020',
  version: '1',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The 2020 North American Land Cover 30-meter dataset was produced as part of
    the North American Land Change Monitoring System (NALCMS), a trilateral
    effort between Natural Resources Canada, the United States Geological
    Survey, and three Mexican organizations including the National Institute of
    Statistics and Geography (Instituto Nacional de Estadística y Geografía),
    National Commission for the Knowledge and Use of the Biodiversity (Comisión
    Nacional Para el Conocimiento y Uso de la Biodiversidad), and the National
    Forestry Commission of Mexico (Comisión Nacional Forestal).  The
    collaboration is facilitated by the Commission for Environmental
    Cooperation, an international organization created by the Canada, Mexico,
    and United States governments under the North American Agreement on
    Environmental Cooperation to promote environmental collaboration between the
    three countries.

    The general objective of NALCMS is to devise, through collective effort, a
    harmonized multi-scale land cover monitoring approach which ensures high
    accuracy and consistency in monitoring land cover changes at the North
    American scale and which meets each country's specific requirements.

    This 30-meter dataset of North American Land Cover reflects land cover
    information for 2020 from Mexico and Canada, 2019 over the conterminous
    United States and 2021 over Alaska.  Each country developed its own
    classification method to identify Land Cover classes and then provided an
    input layer to produce a continental Land Cover map across North America.
    Canada, Mexico, and the United States developed their own 30-meter land
    cover products; see specific sections on data generation below.

    The main inputs for image classification were 30-meter Landsat 8 Collection
    2 Level 1 data in the three countries (Canada, the United States and
    Mexico). Image selection processes and reduction to specific spectral bands
    varied among the countries due to study-site-specific requirements.  While
    Canada selected most images from the year 2020 with a few from 2019 and
    2021, the Conterminous United States employed mainly images from 2019, while
    Alaska land cover maps are mainly based on the use of images from 2021. The
    land cover map for Mexico was based on land cover change detection between
    2015 and 2020 Mexico Landsat 8 mosaics.

    In order to generate a seamless and consistent land cover map of North
    America, national maps were generated for Canada by the CCRS; for Mexico by
    CONABIO, INEGI, and CONAFOR; and for the United States by the USGS. Each
    country chose their own approaches, ancillary data, and land cover mapping
    methodologies to create national datasets. This North America dataset was
    produced by combining the national land cover datasets.  The integration of
    the three national products merged four Land Cover map sections, Alaska,
    Canada, the conterminous United States and Mexico.

    See also:

    * Natural Resources Canada has North American Land Cover information
      available online at
      [https://open.canada.ca/data/en/dataset/ee1580ab-a23d-4f86-a09b-79763677eb47](
      https://open.canada.ca/data/en/dataset/ee1580ab-a23d-4f86-a09b-79763677eb47)

    * The National Commission for the Knowledge and Use of Biodiversity has
      North American Land Cover information available online at
      [https://www.biodiversidad.gob.mx/monitoreo/cobertura-suelo](https://www.biodiversidad.gob.mx/monitoreo/cobertura-suelo)

    * The U.S. Geological Survey has North American Land Cover information
      available online at [www.mrlc.gov](https://www.mrlc.gov)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    // 'land_cover',
    // 'land_surface',
    // 'land_use',
    'landcover',
    'landsat',
    'nlcd',
    // 'north_america',
    'reflectance',
    // 'remote_sensing',
  ],
  providers: [
    ee.producer_provider(
      'The Commission for Environmental Cooperation (CEC)',
      'http://www.cec.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -175, 14, -50, 84,
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
        description: |||
          Land cover classification grid cell value. Values are categorized into the following.
          [Product Legend](https://www.mrlc.gov/sites/default/files/inline-images/2005_nalcms_large_0.jpg).
          The classes in the 2020 product legend are given below.
        |||,
        'gee:classes': [
          {
            value: 1,
            color: '033e00',
            description: |||
              Temperate or sub-polar needleleaf forest. Forests generally taller
              than three meters and more than 20 percent of total vegetation
              cover. This type occurs across the northern United States, Canada,
              and mountainous zones of Mexico. The tree crown cover contains at
              least 75 percent of needleleaved species.
            |||,
          },
          {
            value: 2,
            color: '939b71',
            description: |||
              Sub-polar taiga needleleaf forest. Forest and woodlands with trees
              generally taller than three meters and more than 5 percent of
              total vegetation cover with shrubs and lichens commonly present in
              the understory. The tree crown cover contains at least 75 percent
              of needleleaved species. This type occurs across Alaska and
              northern Canada and may consist of treed muskeg or
              wetlands. Forest canopies are variable and often sparse, with
              generally greater tree cover in the southern latitude parts of the
              zone than the north.
            |||,
          },
          {
            value: 3,
            color: '196d12',
            description: |||
              Tropical or sub-tropical broadleaf evergreen forest. Forests
              generally taller than five meters and more than 20 percent of
              total vegetation cover.  These occur in the southern United States
              and Mexico. These forests have greater than 75 percent of tree
              crown cover represented by evergreen species.
            |||,
          },
          {
            value: 4,
            color: '1fab01',
            description: |||
              Tropical or sub-tropical broadleaf deciduous forest. Forests
              generally taller than five meters and more than 20 percent of
              total vegetation cover.  These occur in the southern United States
              and Mexico. These forests have greater than 75 percent of tree
              crown cover represented by deciduous species.
            |||,
          },
          {
            value: 5,
            color: '5b725c',
            description: |||
              Temperate or sub-polar broadleaf deciduous forest. Forests
              generally taller than three meters and more than 20 percent of
              total vegetation cover. These occur in the northern United States,
              Canada and mountainous zones of Mexico.  These forests have
              greater than 75 percent of tree crown cover represented by
              deciduous species.
            |||,
          },
          {
            value: 6,
            color: '6b7d2c',
            description: |||
              Mixed forest. Forests generally taller than three meters and more
              than 20 percent of total vegetation cover. Neither needleleaf nor
              broadleaf tree species occupy more than 75 percent of total tree
              cover but are co-dominant.
            |||,
          },
          {
            value: 7,
            color: 'b29d29',
            description: |||
              Tropical or sub-tropical shrubland. Areas dominated by woody
              perennial plants with persistent woody stems less than five meters
              tall and typically greater than 20 percent of total
              vegetation. This class occurs across the southern United States
              and Mexico.
            |||,
          },
          {
            value: 8,
            color: 'b48833',
            description: |||
              Temperate or sub-polar shrubland. Areas dominated by woody
              perennial plants with persistent woody stems less than three
              meters tall and typically greater than 20 percent of total
              vegetation. This class occurs across the northern United States,
              Canada and highlands of Mexico.
            |||,
          },
          {
            value: 9,
            color: 'e9da5d',
            description: |||
              Tropical or sub-tropical grassland. Areas dominated by graminoid
              or herbaceous vegetation generally accounting for greater than 80
              percent of total vegetation cover. These areas are not subject to
              intensive management such as tilling but can be utilized for
              grazing. This class occurs across the southern United States and
              Mexico.
            |||,
          },
          {
            value: 10,
            color: 'e0cd88',
            description: |||
              Temperate or sub-polar grassland. Areas dominated by graminoid or
              herbaceous vegetation, generally accounting for greater than 80
              percent of total vegetation cover. These areas are not subject to
              intensive management such as tilling but can be utilized for
              grazing. This class occurs across Canada, United States and
              highlands of Mexico.
            |||,
          },
          {
            value: 11,
            color: 'a07451',
            description: |||
              Sub-polar or polar shrubland-lichen-moss. Areas dominated by dwarf
              shrubs with lichen and moss typically accounting for at least 20
              percent of total vegetation cover. This class occurs across
              northern Canada and Alaska.
            |||,
          },
          {
            value: 12,
            color: 'bad292',
            description: |||
              Sub-polar or polar grassland-lichen-moss. Areas dominated by
              grassland with lichen and moss typically accounting for at least
              20 percent of total vegetation cover. This class occurs across
              northern Canada and Alaska.
            |||,
          },
          {
            value: 13,
            color: '3f8970',
            description: |||
              Sub-polar or polar barren-lichen-moss. Areas dominated by a
              mixture of bare areas with lichen and moss that typically account
              for at least 20 percent of total vegetation cover. This class
              occurs across northern Canada.
            |||,
          },
          {
            value: 14,
            color: '6ca289',
            description: |||
              Wetland. Areas dominated by perennial herbaceous and woody wetland
              vegetation which is influenced by the water table at or near
              surface over extensive periods of time. This includes marshes,
              swamps, bogs, mangroves, etc., either coastal or inland where
              water is present for a substantial period annually.
            |||,
          },
          {
            value: 15,
            color: 'e6ad6a',
            description: |||
              Cropland. Areas dominated by intensively managed crops. These
              areas typically require human activities for their
              maintenance. This includes areas used for the production of annual
              crops, such as corn, soybeans, wheat, maize, vegetables, tobacco,
              cotton, etc.; perennial grasses for grazing; and woody crops such
              as orchards and vineyards. Crop vegetation accounts for greater
              than 20 percent of total vegetation. This class does not represent
              natural grasslands used for light to moderate grazing.
            |||,
          },
          {
            value: 16,
            color: 'a9abae',
            description: |||
              Barren lands. Areas characterized by bare rock, gravel, sand,
              silt, clay, or other earthen material, with little or no "green"
              vegetation present regardless of its inherent ability to support
              life. Generally, vegetation accounts for less than 10 percent of
              total cover.
            |||,
          },
          {
            value: 17,
            color: 'db2126',
            description: |||
              Urban and built-up. Areas that contain at least 30 percent or
              greater urban constructed materials for human activities (cities,
              towns, transportation etc.)
            |||,
          },
          {
            value: 18,
            color: '4c73a1',
            description: |||
              Water. Areas of open water, generally with less than 25 percent
              cover of non-water cover types. This class refers to areas that
              are consistently covered by water.
            |||,
          },
          {
            value: 19,
            color: 'fff7fe',
            description: |||
              Snow and ice. Areas characterized by a perennial cover of ice
              and/or snow, generally greater than 25 percent of total cover.
            |||,
          },
        ],
      }
    ],
    landcover: {
      minimum: 1,
      maximum: 19,
      'gee:estimated_range': false,
    },
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
  },
  'sci:citation': |||
    North American Land Change Monitoring System download webpage.
    [www.cec.org/north-american-land-change-monitoring-system](http://www.cec.org/north-american-land-change-monitoring-system/)
  |||,
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
