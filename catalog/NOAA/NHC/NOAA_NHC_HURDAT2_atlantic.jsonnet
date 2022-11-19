local id = 'NOAA/NHC/HURDAT2/atlantic';
local subdir = 'NOAA/NHC';

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
    ee_const.ext_ver,
  ],
  id: id,
  title: 'NOAA NHC HURDAT2 Atlantic Hurricane Catalog',
  version: '2019-05-10',
  'gee:type': ee_const.gee_type.table,
  description: 'Hurricane best track database (HURDAT2).\n\nAtlantic basin 1851-2018.',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://www.nhc.noaa.gov/data/hurdat/hurdat2-1851-2018-051019.txt',
    },
  ],
  keywords: [
    'hurricane',
    'nhc',
    'noaa',
    'weather',
  ],
  providers: [
    ee.producer_provider('NOAA NHC', 'https://www.nhc.noaa.gov/data/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-109.5, 7.2, 63.0, 81.0,
                    '1851-06-25T00:00:00Z', '2018-11-04T12:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'seq',
        description: 'ATCF cyclone number for that year',
        type: ee_const.var_type.double,
      },
      {
        name: 'name',
        description: 'Hurricane name.  e.g. "ALEX"',
        type: ee_const.var_type.string,
      },
      {
        name: 'datetime',
        description: 'Observation time in UTC. Format is YYYY-MM-DDTHH:MM:SS.',
        type: ee_const.var_type.string,
      },
      {
        name: 'record_id',
        description: |||
          Single letter desinating a specific event in a hurricane track.  An empty string if no code.

          - C - Closest approach to a coast not followed by a landfall
          - G - Genesis
          - I - An intensity peak in terms of both pressure and wind
          - L - Landfall (center of system crossing a coastline)
          - P - Minimum in central pressure
          - R - Provides additional detail on the intensity of the cyclone when rapid changes are underway
          - S - Change of status of the system
          - T - Provides additional detail on the track (position) of the cyclone
          - W - Maximum sustained wind speed
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'status',
        description: |||
          Status of system:

          - DB - Disturbance (of any intensity)
          - ET - Unknown.  The only occurrence is in HARVEY.
          - EX - Extratropical cyclone (of any intensity)
          - HU - Tropical cyclone of hurricane intensity (> 64 knots)
          - LO - A low that is neither a tropical cyclone, a subtropical cyclone, nor an extratropical cyclone (of any intensity)
          - SD - Subtropical cyclone of subtropical depression intensity (< 34 knots)
          - SS - Subtropical cyclone of subtropical storm intensity (> 34 knots)
          - TD - Tropical cyclone of tropical depression intensity (< 34 knots)
          - TS - Tropical cyclone of tropical storm intensity (34-63 knots)
          - WV - Tropical Wave (of any intensity)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'max_wind_kts',
        description: 'Maximum wind speed',
        type: ee_const.var_type.double,
        units: 'knots',
      },
      {
        name: 'min_pressure',
        description: 'Minimum pressure',
        type: ee_const.var_type.double,
        units: 'millibars',
      },
      {
        name: 'numEntries',
        description: 'Number of points for a particular hurricane',
        type: ee_const.var_type.double,
      },
      {
        name: 'radii_ne_34kt',
        description: '34 kt wind radii maximum extent in northeastern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_se_34kt',
        description: '34 kt wind radii maximum extent in southeastern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_sw_34kt',
        description: '34 kt wind radii maximum extent in southwestern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_nw_34kt',
        description: '34 kt wind radii maximum extent in northwestern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_ne_50kt',
        description: '50 kt wind radii maximum extent in northeastern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_se_50kt',
        description: '50 kt wind radii maximum extent in southeastern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_sw_50kt',
        description: '50 kt wind radii maximum extent in southwestern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_nw_50kt',
        description: '50 kt wind radii maximum extent in northwestern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_ne_64kt',
        description: '64 kt wind radii maximum extent in northeastern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_se_64kt',
        description: '64 kt wind radii maximum extent in southeastern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_sw_64kt',
        description: '64 kt wind radii maximum extent in southwestern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'radii_nw_64kt',
        description: '64 kt wind radii maximum extent in northwestern quadrant',
        type: ee_const.var_type.double,
        units: 'nautical miles',
      },
      {
        name: 'basin',
        description: 'Ocean basin.  Always "AL" for Atlantic.',
        type: ee_const.var_type.string,
      },
      {
        name: 'id',
        description: |||
          Code for a particular hurricane.  "AL" followed by a 2 digit cyclone number followed by a
          4-digit year.  e.g. "AL162018"
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Year in which the hurricane occurred',
        type: ee_const.var_type.double,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Hurricane locations',
        lookat: {
          lat: 36.0,
          lon: -53.0,
          zoom: 3,
        },
        table_visualization: {
          color: 'black',
          point_size: 1,
        },
      },
      {
        display_name: 'Hurricane locations',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 36.0,
          lon: -53.0,
          zoom: 3,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 12000,
      thinning_strategy: 'GLOBALLY_CONSISTENT',
      thinning_ranking: ['id DESC'],
      z_order_ranking: ['seq ASC'],
      prerender_tiles: true,
    },
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use.
  |||,
}
