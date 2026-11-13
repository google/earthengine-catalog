// Shared values for the Global Wetland Watch (GWW) datasets.
local ee = import 'earthengine.libsonnet';

{
  subdir: 'global-wetland-watch',

  // Global Wetland Watch is the producer and licensor. The partners (DHI,
  // UNEP-DHI and UNEP) are named in the catalog description.
  producer: ee.producer_provider(
    'Global Wetland Watch', 'https://www.globalwetlandwatch.org/'),

  // Wetland typology classes, with the corresponding IUCN Global Ecosystem
  // Typology (GET) functional groups where applicable. Used by the class bands
  // of results/annual/v1 and results/multiannual/v1.
  typology_classes: [
    {value: 1, color: 'f2d27c', description: 'Sandy shoreline (GET MT1.3 Sandy shorelines)'},
    {value: 2, color: 'c06b3e', description: 'Muddy shoreline (GET MT1.2 Muddy shorelines)'},
    {value: 3, color: '6f6f6f', description: 'Rocky shoreline (GET MT1.1 Rocky shorelines)'},
    {value: 4, color: 'e6d8a8', description: 'Salt marsh (GET MFT1.3 Coastal saltmarshes and reedbeds)'},
    {value: 5, color: '7fa65a', description: 'Intertidal forest and shrub (GET MFT1.2 Intertidal forests and shrublands)'},
    {value: 10, color: '1f5f3a', description: 'Permanent marsh (GET TF1.3 Permanent marshes)'},
    {value: 11, color: 'b5cf4a', description: 'Seasonal floodplain marsh (GET TF1.4 Seasonal floodplain marshes)'},
    {value: 12, color: '4e7a55', description: 'Forested wetland (GET TF1.1 Tropical flooded forests and peat forests; TF1.2 Subtropical/temperate forested wetlands)'},
    {value: 13, color: 'f1a6a6', description: 'Aquafarm (GET M4.2 Marine aquafarms; F3.4 Freshwater aquafarms)'},
    {value: 14, color: '7a5b2e', description: 'Bog (GET TF1.6 Boreal, temperate and montane peat bogs; not restricted to boreal, temperate and montane regions)'},
    {value: 15, color: 'b89a5a', description: 'Fen (GET TF1.7 Boreal and temperate fens; not restricted to boreal and temperate regions, also includes other groundwater-dependent wetlands)'},
    {value: 16, color: 'f0d35c', description: 'Aquatic and semi-aquatic cropland (GET F3.3 Rice paddies; includes rice paddies and other aquatic and semi-aquatic crops)'},
    {value: 21, color: '3fa9a6', description: 'Reservoir (GET F3.1 Large reservoirs)'},
    {value: 22, color: '7fe3e6', description: 'Canal, ditch and drain (GET F3.5 Canals, ditches and drains)'},
    {value: 23, color: '8f63a8', description: 'Salt and soda lake (GET F2.6 Permanent salt and soda lakes; F2.7 Ephemeral salt lakes)'},
    {value: 24, color: 'e8ddf0', description: 'Saltpan'},
    {value: 25, color: '5fa8d3', description: 'Lake (GET F2 Lakes)'},
    {value: 26, color: '4f66b2', description: 'Coastal river delta and estuary (GET MFT1.1 Coastal river deltas; FM1.2 Permanently open riverine estuaries and bays)'},
    {value: 27, color: '1f3f7a', description: 'Ocean'},
    {value: 28, color: '6a8fd9', description: 'River and stream (GET F1 Rivers and streams)'},
    {value: 29, color: 'c7dbf2', description: 'Floodplain (GET TF1.5 Episodic arid floodplains; not restricted to arid environments)'},
    {value: 30, color: '3b86b3', description: 'Lagoon'},
    {value: 31, color: 'bdbdbd', description: 'Unclassified water (wetland not yet assigned to a specific type)'},
  ],

  // Palette for visualizing the class bands with min 1 and max 31: entry i is
  // the color of class value i + 1. Unused values (6-9, 17-20) are white.
  typology_palette: [
    'f2d27c', 'c06b3e', '6f6f6f', 'e6d8a8', '7fa65a',  // 1-5
    'ffffff', 'ffffff', 'ffffff', 'ffffff',            // 6-9 (unused)
    '1f5f3a', 'b5cf4a', '4e7a55', 'f1a6a6', '7a5b2e',  // 10-14
    'b89a5a', 'f0d35c',                                // 15-16
    'ffffff', 'ffffff', 'ffffff', 'ffffff',            // 17-20 (unused)
    '3fa9a6', '7fe3e6', '8f63a8', 'e8ddf0', '5fa8d3',  // 21-25
    '4f66b2', '1f3f7a', '6a8fd9', 'c7dbf2', '3b86b3',  // 26-30
    'bdbdbd',                                          // 31
  ],

  citation: |||
    DHI, UNEP-DHI, UNEP (2026). Global Wetland Watch wetland typology,
    version 1.
  |||,
}
