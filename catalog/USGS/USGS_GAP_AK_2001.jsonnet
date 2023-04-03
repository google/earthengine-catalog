local id = 'USGS/GAP/AK/2001';
local subdir = 'USGS';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'USGS GAP Alaska 2001',
  version: '2001',
  'gee:type': ee_const.gee_type.image,
  description: |||
    The GAP/LANDFIRE National Terrestrial Ecosystems data represents a detailed
    vegetation and land cover classification for the Conterminous U.S., Alaska,
    Hawaii, and Puerto Rico.GAP/LF 2011 Ecosystems for the Conterminous U.S. is
    an update of the National Gap Analysis Program Land Cover Data - Version 2.2.
    Alaska ecosystems have been updated by LANDFIRE to 2012 conditions (LANDFIRE 2012).
    Hawaii and Puerto Rico data represent the 2001 time-frame (Gon et al. 2006, Gould et al. 2008).
    The classification scheme used for the Alaska and the lower 48 states is based
    on NatureServe's Ecological System Classification (Comer et al. 2003), while
    Puerto Rico and Hawaii's map legend are based on island specific classification
    systems (Gon et al. 2006, Gould et al. 2008).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
  ],
  keywords: [
    'gap',
    'landcover',
    'landfire',
    'usgs',
    'vegetation',
  ],
  providers: [
    ee.producer_provider('USGS', 'https://gapanalysis.usgs.gov/gaplandcover/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, 49.09, 180.0, 71.84,
                    '2001-01-01T00:00:00Z', '2002-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      30.0,
    ],
    'eo:bands': [
      {
        name: 'landcover',
        description: 'Landcover class descriptions',
        'gee:classes': [
          {
            value: 1,
            description: 'Alaskan Pacific Maritime Periglacial Woodland and Shrubland',
          },
          {
            value: 2,
            description: 'Alaskan Pacific Maritime Sitka Spruce Beach Ridge',
          },
          {
            value: 3,
            description: 'Alaskan Pacific Maritime Sitka Spruce Forest',
          },
          {
            value: 4,
            description: 'Alaskan Pacific Maritime Western Hemlock Forest',
          },
          {
            value: 5,
            description: 'North Pacific Hypermaritime Western Red-cedar-Western Hemlock Forest',
          },
          {
            value: 6,
            description: 'North Pacific Mesic Western Hemlock-Yellow-cedar Forest',
          },
          {
            value: 7,
            description: 'Alaska Sub-boreal Mountain Hemlock-White Spruce Forest',
          },
          {
            value: 8,
            description: 'Alaskan Pacific Maritime Mountain Hemlock Forest',
          },
          {
            value: 9,
            description: 'Alaskan Pacific Maritime Subalpine Mountain Hemlock Woodland',
          },
          {
            value: 10,
            description: 'North Pacific Maritime Mesic Subalpine Parkland',
          },
          {
            value: 11,
            description: 'Alaskan Pacific Maritime Floodplain Forest and Shrubland',
          },
          {
            value: 12,
            description: 'Alaskan Pacific Maritime Poorly Drained Conifer Woodland',
          },
          {
            value: 13,
            description: 'North Pacific Shrub Swamp',
          },
          {
            value: 14,
            description: 'Alaska Sub-boreal White Spruce-Hardwood Forest',
          },
          {
            value: 15,
            description: 'Alaska Sub-boreal White-Lutz Spruce Forest and Woodland',
          },
          {
            value: 16,
            description: 'Aleutian Kenai Birch-Cottonwood-Poplar Forest',
          },
          {
            value: 17,
            description: 'Western North American Boreal Black Spruce Wet-Mesic Slope Woodland',
          },
          {
            value: 18,
            description: 'Western North American Boreal Mesic Birch-Aspen Forest',
          },
          {
            value: 19,
            description: 'Western North American Boreal Mesic Black Spruce Forest',
          },
          {
            value: 20,
            description: 'Western North American Boreal White Spruce Forest',
          },
          {
            value: 21,
            description: 'Western North American Boreal White Spruce-Hardwood Forest',
          },
          {
            value: 22,
            description: 'Western North American Boreal Spruce-Lichen Woodland',
          },
          {
            value: 23,
            description: 'Western North American Boreal Subalpine Balsam Poplar-Aspen Woodland',
          },
          {
            value: 24,
            description: 'Western North American Boreal Treeline White Spruce Woodland',
          },
          {
            value: 25,
            description: 'Western North American Boreal Deciduous Shrub Swamp',
          },
          {
            value: 26,
            description: 'Western North American Boreal Wet Black Spruce-Tussock Woodland',
          },
          {
            value: 27,
            description: 'Aleutian Floodplain Forest and Shrubland',
          },
          {
            value: 28,
            description: 'Western North American Boreal Lowland Large River Floodplain Forest and Shrubland',
          },
          {
            value: 29,
            description: 'Western North American Boreal Montane Floodplain Forest and Shrubland',
          },
          {
            value: 30,
            description: 'Western North American Boreal Riparian Stringer Forest and Shrubland',
          },
          {
            value: 31,
            description: 'Alaskan Pacific Maritime Avalanche Slope Shrubland',
          },
          {
            value: 32,
            description: 'Alaskan Pacific Maritime Mesic Herbaceous Meadow',
          },
          {
            value: 33,
            description: 'Alaskan Pacific Maritime Subalpine Alder-Salmonberry Shrubland',
          },
          {
            value: 34,
            description: 'Aleutian Mesic Alder-Salmonberry Shrubland',
          },
          {
            value: 35,
            description: 'Aleutian Mesic Herbaceous Meadow',
          },
          {
            value: 36,
            description: 'Aleutian Oval-leaf Blueberry Shrubland',
          },
          {
            value: 37,
            description: 'Alaska Arctic Active Inland Dune',
          },
          {
            value: 38,
            description: 'Alaska Arctic Mesic Herbaceous Meadow',
          },
          {
            value: 39,
            description: 'Alaska Sub-boreal Avalanche Slope Shrubland',
          },
          {
            value: 40,
            description: 'Alaska Sub-boreal Mesic Subalpine Alder Shrubland',
          },
          {
            value: 41,
            description: 'Aleutian Mesic-Wet Willow Shrubland',
          },
          {
            value: 42,
            description: 'Western North American Boreal Active Inland Dune',
          },
          {
            value: 43,
            description: 'Western North American Boreal Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 44,
            description: 'Western North American Boreal Dry Aspen-Steppe Bluff',
          },
          {
            value: 45,
            description: 'Western North American Boreal Dry Grassland',
          },
          {
            value: 46,
            description: 'Western North American Boreal Mesic Scrub Birch-Willow Shrubland',
          },
          {
            value: 47,
            description: 'Western North American Sub-boreal Mesic Bluejoint Meadow',
          },
          {
            value: 48,
            description: 'Aleutian American Dunegrass Grassland',
          },
          {
            value: 49,
            description: 'Aleutian Marine Beach and Beach Meadow',
          },
          {
            value: 50,
            description: 'Aleutian Rocky Headland and Sea Cliff',
          },
          {
            value: 51,
            description: 'Alaska Arctic Marine Beach and Beach Meadow',
          },
          {
            value: 52,
            description: 'Alaska Arctic Dwarf-Shrub-Sphagnum Peatland',
          },
          {
            value: 53,
            description: 'Alaska Arctic Wet Sedge-Sphagnum Peatland',
          },
          {
            value: 54,
            description: 'Western North American Boreal Black Spruce Dwarf-Tree Peatland',
          },
          {
            value: 55,
            description: 'Western North American Boreal Black Spruce-Tamarack Fen',
          },
          {
            value: 56,
            description: 'Western North American Boreal Herbaceous Fen',
          },
          {
            value: 57,
            description: 'Western North American Boreal Low Shrub Peatland',
          },
          {
            value: 58,
            description: 'Western North American Boreal Sedge-Dwarf-Shrub Bog',
          },
          {
            value: 59,
            description: 'Alaskan Pacific Maritime Dwarf-shrub-Sphagnum Peatland',
          },
          {
            value: 60,
            description: 'Alaskan Pacific Maritime Mountain Hemlock Peatland',
          },
          {
            value: 61,
            description: 'Alaskan Pacific Maritime Shore Pine Peatland',
          },
          {
            value: 62,
            description: 'Alaskan Pacific Maritime Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 63,
            description: 'Alaskan Pacific Maritime Wet Low Shrubland',
          },
          {
            value: 64,
            description: 'Aleutian Nonvascular Peatland',
          },
          {
            value: 65,
            description: 'Aleutian Shrub-Sedge Peatland',
          },
          {
            value: 66,
            description: 'Aleutian Wet Meadow and Herbaceous Peatland',
          },
          {
            value: 67,
            description: 'Aleutian Floodplain Wetland',
          },
          {
            value: 68,
            description: 'Aleutian Freshwater Marsh',
          },
          {
            value: 69,
            description: 'Aleutian Shrub and Herbaceous Meadow Floodplain',
          },
          {
            value: 70,
            description: 'Western North American Boreal Freshwater Emergent Marsh',
          },
          {
            value: 71,
            description: 'Western North American Boreal Shrub and Herbaceous Floodplain Wetland',
          },
          {
            value: 72,
            description: 'Western North American Boreal Wet Meadow',
          },
          {
            value: 73,
            description: 'Alaskan Pacific Maritime Alpine Floodplain',
          },
          {
            value: 74,
            description: 'Alaskan Pacific Maritime Alpine Wet Meadow',
          },
          {
            value: 75,
            description: 'Alaskan Pacific Maritime Coastal Meadow and Slough-Levee',
          },
          {
            value: 76,
            description: 'Alaskan Pacific Maritime Fen and Wet Meadow',
          },
          {
            value: 77,
            description: 'Alaskan Pacific Maritime Subalpine Copperbush Shrubland',
          },
          {
            value: 78,
            description: 'Temperate Pacific Freshwater Emergent Marsh',
          },
          {
            value: 79,
            description: 'Alaska Arctic Coastal Brackish Meadow',
          },
          {
            value: 80,
            description: 'Alaska Arctic Coastal Sedge-Dwarf-Shrubland',
          },
          {
            value: 81,
            description: 'Alaska Arctic Tidal Flat',
          },
          {
            value: 82,
            description: 'Alaska Arctic Tidal Marsh',
          },
          {
            value: 83,
            description: 'Aleutian Tidal Marsh',
          },
          {
            value: 84,
            description: 'Temperate Pacific Tidal Salt and Brackish Marsh',
          },
          {
            value: 85,
            description: 'Alaska Sub-boreal and Maritime Alpine Mesic Herbaceous Meadow',
          },
          {
            value: 86,
            description: 'Alaskan Pacific Maritime Alpine Dwarf-Shrubland',
          },
          {
            value: 87,
            description: 'Alaskan Pacific Maritime Alpine Sparse Shrub and Fell-field',
          },
          {
            value: 88,
            description: 'Aleutian Crowberry-Herbaceous Heath',
          },
          {
            value: 89,
            description: 'Aleutian Mixed Dwarf-Shrub-Herbaceous Shrubland',
          },
          {
            value: 90,
            description: 'Aleutian Sparse Heath and Fell-Field',
          },
          {
            value: 91,
            description: 'Alaska Arctic Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 92,
            description: 'Alaska Arctic Acidic Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 93,
            description: 'Alaska Arctic Acidic Sparse Tundra',
          },
          {
            value: 94,
            description: 'Alaska Arctic Dwarf-Shrubland',
          },
          {
            value: 95,
            description: 'Alaska Arctic Floodplain',
          },
          {
            value: 96,
            description: 'Alaska Arctic Large River Floodplain',
          },
          {
            value: 97,
            description: 'Alaska Arctic Lichen Tundra',
          },
          {
            value: 98,
            description: 'Alaska Arctic Mesic Alder Shrubland',
          },
          {
            value: 99,
            description: 'Alaska Arctic Mesic Sedge-Dryas Tundra',
          },
          {
            value: 100,
            description: 'Alaska Arctic Mesic Sedge-Willow Tundra',
          },
          {
            value: 101,
            description: 'Alaska Arctic Mesic-Wet Willow Shrubland',
          },
          {
            value: 102,
            description: 'Alaska Arctic Non-Acidic Dryas Dwarf-Shrubland',
          },
          {
            value: 103,
            description: 'Alaska Arctic Non-Acidic Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 104,
            description: 'Alaska Arctic Non-Acidic Sparse Tundra',
          },
          {
            value: 105,
            description: 'Alaska Arctic Permafrost Plateau Dwarf-Shrub Lichen Tundra',
          },
          {
            value: 107,
            description: 'Alaska Arctic Scrub Birch-Ericaceous Shrubland',
          },
          {
            value: 108,
            description: 'Western North American Boreal Alpine Dryas Dwarf-Shrubland',
          },
          {
            value: 109,
            description: 'Western North American Boreal Alpine Dwarf-Shrub Summit',
          },
          {
            value: 110,
            description: 'Western North American Boreal Alpine Dwarf-Shrub-Lichen Shrubland',
          },
          {
            value: 111,
            description: 'Western North American Boreal Alpine Ericaceous Dwarf-Shrubland',
          },
          {
            value: 112,
            description: 'Western North American Boreal Alpine Floodplain',
          },
          {
            value: 113,
            description: 'Alaska Arctic Pendantgrass Freshwater Marsh',
          },
          {
            value: 114,
            description: 'Alaska Arctic Polygonal Ground Shrub-Tussock Tundra',
          },
          {
            value: 115,
            description: 'Alaska Arctic Polygonal Ground Tussock Tundra',
          },
          {
            value: 116,
            description: 'Alaska Arctic Polygonal Ground Wet Sedge Tundra',
          },
          {
            value: 117,
            description: 'Alaska Arctic Sedge Freshwater Marsh',
          },
          {
            value: 118,
            description: 'Alaska Arctic Shrub-Tussock Tundra',
          },
          {
            value: 119,
            description: 'Alaska Arctic Tussock Tundra',
          },
          {
            value: 120,
            description: 'Alaska Arctic Tussock-Lichen Tundra',
          },
          {
            value: 121,
            description: 'Alaska Arctic Wet Sedge Meadow',
          },
          {
            value: 122,
            description: 'Western North American Boreal Low Shrub-Tussock Tundra',
          },
          {
            value: 123,
            description: 'Western North American Boreal Tussock Tundra',
          },
          {
            value: 124,
            description: 'Temperate Pacific Intertidal Mudflat',
          },
          {
            value: 125,
            description: 'North Pacific Maritime Eelgrass Bed',
          },
          {
            value: 126,
            description: 'Alaska Arctic Freshwater Aquatic Bed',
          },
          {
            value: 127,
            description: 'Temperate Pacific Freshwater Aquatic Bed',
          },
          {
            value: 128,
            description: 'Western North American Boreal Freshwater Aquatic Bed',
          },
          {
            value: 129,
            description: 'Aleutian Volcanic Rock and Talus',
          },
          {
            value: 130,
            description: 'Alaska Arctic Bedrock and Talus',
          },
          {
            value: 131,
            description: 'Western North American Boreal Alpine Talus and Bedrock',
          },
          {
            value: 132,
            description: 'North Pacific Alpine and Subalpine Bedrock and Scree',
          },
          {
            value: 133,
            description: 'Snow/Ice',
          },
          {
            value: 134,
            description: 'Undifferentiated Barren Land',
          },
          {
            value: 135,
            description: 'Cultivated Cropland',
          },
          {
            value: 136,
            description: 'Pasture/Hay',
          },
          {
            value: 137,
            description: 'Developed, High Intensity',
          },
          {
            value: 138,
            description: 'Developed, Low Intensity',
          },
          {
            value: 139,
            description: 'Developed, Medium Intensity',
          },
          {
            value: 140,
            description: 'Developed, Open Space',
          },
          {
            value: 141,
            description: 'Recently Burned-Tree Cover',
          },
          {
            value: 142,
            description: 'Open Water (Brackish/Salt)',
          },
          {
            value: 143,
            description: 'Open Water (Fresh)',
          },
        ],
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'GAP Alaska',
        lookat: {
          lat: 63.68,
          lon: -151.97,
          zoom: 4,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              143.0,
            ],
            bands: [
              'landcover',
            ],
          },
        },
      },
    ],
    landcover: {
      minimum: 1.0,
      maximum: 143.0,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs) is available.
  |||,
}
