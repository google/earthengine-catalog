local id = 'Oxford/MAP/IGBP_Fractional_Landcover_5km_Annual';
local subdir = 'Oxford';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_nc_sa_4_0;

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
  title: 'Oxford MAP: Malaria Atlas Project Fractional International Geosphere-Biosphere Programme Landcover',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The underlying dataset for this landcover product is the IGBP layer found
    within the MODIS annual landcover product (MCD12Q1). This data was
    converted from its categorical format, which has a ≈500 meter resolution,
    to a fractional product indicating the integer percentage (0-100) of the
    output pixel covered by each of the 17 landcover classes (1 per band).

    This dataset was produced by Harry Gibson and Daniel Weiss of the
    Malaria Atlas Project (Big Data Institute, University of Oxford,
    United Kingdom, [http://www.map.ox.ac.uk/]
    (http://www.map.ox.ac.uk/)).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'igbp',
    'landcover',
    'map',
    'oxford',
  ],
  providers: [
    ee.producer_provider('Oxford Malaria Atlas Project', 'https://www.bdi.ox.ac.uk/research/malaria-atlas-project'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2001-01-01T00:00:00Z', '2013-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      5000.0,
    ],
    'eo:bands': [
      {
        name: 'Overall_Class',
        description: 'Dominant class of each resulting pixel',
        'gee:classes': [
          {
            color: '032f7e',
            description: 'Water',
            value: 0,
          },
          {
            value: 1,
            color: '02740b',
            description: 'Evergreen_Needleleaf_Fores',
          },
          {
            value: 2,
            color: '02740b',
            description: 'Evergreen_Broadleaf_Forest',
          },
          {
            value: 3,
            color: '8cf502',
            description: 'Deciduous_Needleleaf_Forest',
          },
          {
            value: 4,
            color: '8cf502',
            description: 'Deciduous_Broadleaf_Forest',
          },
          {
            value: 5,
            color: 'a4da01',
            description: 'Mixed_Forest',
          },
          {
            value: 6,
            color: 'ffbd05',
            description: 'Closed_Shrublands',
          },
          {
            value: 7,
            color: 'ffbd05',
            description: 'Open_Shrublands',
          },
          {
            value: 8,
            color: '7a5a02',
            description: 'Woody_Savannas',
          },
          {
            value: 9,
            color: 'f0ff0f',
            description: 'Savannas',
          },
          {
            value: 10,
            color: '869b36',
            description: 'Grasslands',
          },
          {
            value: 11,
            color: '6091b4',
            description: 'Permanent_Wetlands',
          },
          {
            value: 12,
            color: 'ff4e4e',
            description: 'Croplands',
          },
          {
            value: 13,
            color: '999999',
            description: 'Urban_and_Built-up',
          },
          {
            value: 14,
            color: 'ff4e4e',
            description: 'Cropland_Natural_Vegetation_Mosaic',
          },
          {
            value: 15,
            color: 'ffffff',
            description: 'Snow_and_Ice',
          },
          {
            value: 16,
            color: 'feffc0',
            description: 'Barren_Or_Sparsely_Vegetated',
          },
          {
            value: 17,
            color: '020202',
            description: 'Unclassified',
          },
        ],
      },
      {
        name: 'Water',
        description: 'Percentage of water',
        'gee:units': '%',
      },
      {
        name: 'Evergreen_Needleleaf_Forest',
        description: 'Percentage of evergreen needleleaf forest',
        'gee:units': '%',
      },
      {
        name: 'Evergreen_Broadleaf_Forest',
        description: 'Percentage of evergreen broadleaf forest',
        'gee:units': '%',
      },
      {
        name: 'Deciduous_Needleleaf_Forest',
        description: 'Percentage of deciduous needleleaf forest',
        'gee:units': '%',
      },
      {
        name: 'Deciduous_Broadleaf_Forest',
        description: 'Percentage of deciduous broadleaf forest',
        'gee:units': '%',
      },
      {
        name: 'Mixed_Forest',
        description: 'Percentage of mixed forest',
        'gee:units': '%',
      },
      {
        name: 'Closed_Shrublands',
        description: 'Percentage of closed shrublands',
        'gee:units': '%',
      },
      {
        name: 'Open_Shrublands',
        description: 'Percentage of open shrublands',
        'gee:units': '%',
      },
      {
        name: 'Woody_Savannas',
        description: 'Percentage of woody savannas',
        'gee:units': '%',
      },
      {
        name: 'Savannas',
        description: 'Percentage of savannas',
        'gee:units': '%',
      },
      {
        name: 'Grasslands',
        description: 'Percentage of grasslands',
        'gee:units': '%',
      },
      {
        name: 'Permanent_Wetlands',
        description: 'Percentage of permanent wetlands',
        'gee:units': '%',
      },
      {
        name: 'Croplands',
        description: 'Percentage of croplands',
        'gee:units': '%',
      },
      {
        name: 'Urban_And_Built_Up',
        description: 'Percentage of urban and built up',
        'gee:units': '%',
      },
      {
        name: 'Cropland_Natural_Vegetation_Mosaic',
        description: 'Percentage of cropland natural vegetation mosaic',
        'gee:units': '%',
      },
      {
        name: 'Snow_And_Ice',
        description: 'Percentage of snow and ice',
        'gee:units': '%',
      },
      {
        name: 'Barren_Or_Sparsely_Populated',
        description: 'Percentage of barren or sparsely populated',
        'gee:units': '%',
      },
      {
        name: 'Unclassified',
        description: 'Percentage of unclassified',
        'gee:units': '%',
      },
      {
        name: 'No_Data',
        description: 'Percentage of no data',
        'gee:units': '%',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Landcover',
        lookat: {
          lat: 26.4,
          lon: -88.6,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              19.0,
            ],
            palette: [
              '032f7e',
              '02740b',
              '02740b',
              '8cf502',
              '8cf502',
              'a4da01',
              'ffbd05',
              'ffbd05',
              '7a5a02',
              'f0ff0f',
              '869b36',
              '6091b4',
              '999999',
              'ff4e4e',
              'ff4e4e',
              'ffffff',
              'feffc0',
              '020202',
              '020202',
            ],
            bands: [
              'Overall_Class',
            ],
          },
        },
      },
    ],
    Overall_Class: {
      minimum: 0.0,
      maximum: 17.0,
      'gee:estimated_range': false,
    },
    Water: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Evergreen_Needleleaf_Forest: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Evergreen_Broadleaf_Forest: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Deciduous_Needleleaf_Forest: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Deciduous_Broadleaf_Forest: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Mixed_Forest: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Closed_Shrublands: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Open_Shrublands: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Woody_Savannas: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Savannas: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Grasslands: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Permanent_Wetlands: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Croplands: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Urban_And_Built_Up: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Cropland_Natural_Vegetation_Mosaic: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Snow_And_Ice: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Barren_Or_Sparsely_Populated: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    Unclassified: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    No_Data: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
  },
  'sci:citation': |||
    Weiss, D.J., P.M. Atkinson, S. Bhatt, B. Mappin, S.I. Hay & P.W. Gething
    (2014) An effective approach for gap-filling continental scale remotely
    sensed time-series. ISPRS Journal of Photogrammetry and Remote Sensing,
    98, 106-118.
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    This work is licensed under a Creative Commons
    Attribution-NonCommercial-ShareAlike 4.0 International License.
  |||,
  'gee:unusual_terms_of_use': true,
}
