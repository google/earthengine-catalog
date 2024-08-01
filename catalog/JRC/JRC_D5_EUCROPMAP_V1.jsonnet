local id = 'JRC/D5/EUCROPMAP/V1';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

// The CC-BY-4.0 license is mentioned on the copyright page
// https://ec.europa.eu/info/legal-notice_en#copyright-notice, linked off of
// https://publications.jrc.ec.europa.eu/repository/handle/JRC125312'
local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'EUCROPMAP',
  version: 'V1',
  // Currently we only have in the collection a single image for 2018,
  // with two images for 2022 - one for EU27, and another for Ukraine.
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    European crop type map based on Sentinel-1 and LUCAS Copernicus 2018 in-situ
    observations for 2018; and one based on Sentinel-2 and LUCAS Copernicus 2022 for 2022.

    Capitalizing on the unique
    [LUCAS 2018 Copernicus in-situ survey](JRC_LUCAS_HARMO_THLOC_V1),
    the 2018 dataset is the first continental crop type map with 10m
    pixel size for the EU based on S1A and S1B Synthetic Aperture Radar
    observations for the year 2018; the 2022 dataset is a continuation of
    the work and is based on optical S2 observations for the year 2022.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'crop',
    'eu',
    'jrc',
    'lucas',
    'sentinel1_derived',
  ],
  providers: [
    ee.producer_provider(
      'Joint Research Center (JRC)',
      'https://data.jrc.ec.europa.eu/dataset/15f86c84-eae1-4723-8e00-c1b35c8f56b9'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -16.171875, 34.313433, 36.386719, 72.182526,
      '2018-01-01T00:00:00Z', null),
  'sci:citation': |||
    d'Andrimont, R., Verhegghen, A., Lemoine, G., Kempeneers, P., Meroni, M.,
    & Van der Velde, M. (2021). From parcel to continental scale-A first
    European crop type map based on Sentinel-1 and LUCAS Copernicus in-situ
    observations. Remote sensing of environment, 266, 112708.
  |||,
'sci:publications': [
      {
        citation: |||
          d'Andrimont, R., Verhegghen, A., Lemoine, G., Kempeneers, P., Meroni, M.,
          & Van der Velde, M. (2021). From parcel to continental scale-A first
          European crop type map based on Sentinel-1 and LUCAS Copernicus in-situ
          observations. Remote sensing of environment, 266, 112708.
          [doi:10.1016/j.rse.2021.112708](https://doi.org/10.1016/j.rse.2021.112708).
        |||,
        doi: '10.1016/j.rse.2021.112708',
      },
      {
        citation: |||
          Ghassemi, B., Dujakovic, A., Żółtak, M., Immitzer, M., Atzberger, C. and Vuolo, F., 2022. Designing a European-wide crop type mapping approach based on machine learning algorithms using LUCAS field survey and Sentinel-2 data. Remote sensing, 14(3), p.541.
          [10.3390/rs14030541](https://doi.org/10.3390/rs14030541)
        |||,
        doi: '10.3390/rs14030541',
      },
    ],
  'gee:user_uploaded': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  summaries: {
    gsd: [
      10
    ],
    'gee:visualizations': [
      {
        display_name: 'Classification',
        lookat: {
          lat: 48,
          lon: 10,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              211
            ],
            max: [
              500
            ],
            bands: [
              'classification',
            ],
          },
        },
      },
    ],
    'eo:bands': [
      {
        name: 'classification',
        description: 'Main crop-specific land cover classification.',
        'gee:classes': [
          {
            value: 211,
            color: 'a57000',
            description: 'Common wheat',
          },
          {
            value: 212,
            color: '896054',
            description: 'Durum wheat',
          },
          {
            value: 213,
            color: 'e2007c',
            description: 'Barley',
          },
          {
            value: 214,
            color: 'aa007c',
            description: 'Rye',
          },
          {
            value: 215,
            color: 'a05989',
            description: 'Oats',
          },
          {
            value: 216,
            color: 'ffd300',
            description: 'Maize',
          },
          {
            value: 217,
            color: '00a8e2',
            description: 'Rice',
          },
          {
            value: 218,
            color: 'd69ebc',
            description: 'Triticale',
          },
          {
            value: 219,
            color: 'd69ebc',
            description: 'Other cereals',
          },
          {
            value: 221,
            color: 'dda50a',
            description: 'Potatoes',
          },
          {
            value: 222,
            color: 'a800e2',
            description: 'Sugar beet',
          },
          {
            value: 223,
            color: '00af49',
            description: 'Other root crops',
          },
          {
            value: 230,
            color: '00af49',
            description: 'Other non-permanent industrial crops',
          },
          {
            value: 231,
            color: 'ffff00',
            description: 'Sunflower',
          },
          {
            value: 232,
            color: 'd1ff00',
            description: 'Rapeseed and turnip rapeseed',
          },
          {
            value: 233,
            color: '267000',
            description: 'Soya',
          },
          {
            value: 240,
            color: 'f2a377',
            description: 'Dry pulses',
          },
          {
            value: 250,
            color: 'e8bfff',
            description: 'Fodder crops (cereals and leguminous)',
          },
          {
            value: 290,
            color: '696969',
            description: 'Bare arable land',
          },
          {
            value: 300,
            color: '93cc93',
            description: 'Woodland and Shrubland (incl. permanent crops)',
          },
          {
            value: 500,
            color: 'e8ffbf',
            description: 'Grasslands',
          },
        ]
      },
    ],
    'gee:schema': [
      {
        name: 'classification_class_names',
        description: 'Array of cropland classification names.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'classification_class_palette',
        description: 'Array of hex code color strings used for the classification palette.',
        type: ee_const.var_type.string_list,
      },
      {
        name: 'classification_class_values',
        description: 'Value of the cropland classification.',
        type: ee_const.var_type.int_list,
      },
    ],
  },
}

