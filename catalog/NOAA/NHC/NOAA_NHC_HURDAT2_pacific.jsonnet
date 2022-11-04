local id = 'NOAA/NHC/HURDAT2/pacific';
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
  title: 'NOAA NHC HURDAT2 Pacific Hurricane Catalog',
  version: '2019-07-15',
  'gee:type': ee_const.gee_type.table,
  description: 'Hurricane best track database (HURDAT2).\n\nPacific basin 1949-2018.',
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    {
      rel: ee_const.rel.source,
      href: 'https://www.nhc.noaa.gov/data/hurdat/hurdat2-nepac-1949-2018-071519.txt',
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
  extent: ee.extent(-180.0, 0.4, 180.0, 63.1,
                    '1949-06-11T00:00:00Z', '2018-11-09T00:00:00Z'),
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
        description: 'Ocean basin.  Always one of:\n\n- CP - North Central Pacific\n- EP - Northeast Pacific',
        type: ee_const.var_type.string,
      },
      {
        name: 'id',
        description: |||
          Code for a particular hurricane.  Basic code followed by a 2 digit cyclone number followed by a
          4-digit year.  e.g. "CP011993"
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
          lat: 30.0,
          lon: -150.0,
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
          lat: 30.0,
          lon: -150.0,
          zoom: 3,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 6000,
      thinning_strategy: 'GLOBALLY_CONSISTENT',
      thinning_ranking: ['id DESC'],
      z_order_ranking: ['seq ASC'],
      prerender_tiles: true,
    },
    seq: {
      minimum: 1.0,
      maximum: 31.0,
      'gee:estimated_range': true,
    },
    max_wind_kts: {
      minimum: 10.0,
      maximum: 185.0,
      'gee:estimated_range': true,
    },
    min_pressure: {
      minimum: 872.0,
      maximum: 1024.0,
      'gee:estimated_range': true,
    },
    numEntries: {
      minimum: 1.0,
      maximum: 133.0,
      'gee:estimated_range': true,
    },
    radii_ne_34kt: {
      minimum: 0.0,
      maximum: 780.0,
      'gee:estimated_range': true,
    },
    radii_se_34kt: {
      minimum: 0.0,
      maximum: 600.0,
      'gee:estimated_range': true,
    },
    radii_sw_34kt: {
      minimum: 0.0,
      maximum: 660.0,
      'gee:estimated_range': true,
    },
    radii_nw_34kt: {
      minimum: 0.0,
      maximum: 600.0,
      'gee:estimated_range': true,
    },
    radii_ne_50kt: {
      minimum: 0.0,
      maximum: 360.0,
      'gee:estimated_range': true,
    },
    radii_se_50kt: {
      minimum: 0.0,
      maximum: 300.0,
      'gee:estimated_range': true,
    },
    radii_sw_50kt: {
      minimum: 0.0,
      maximum: 330.0,
      'gee:estimated_range': true,
    },
    radii_nw_50kt: {
      minimum: 0.0,
      maximum: 360.0,
      'gee:estimated_range': true,
    },
    radii_ne_64kt: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    radii_se_64kt: {
      minimum: 0.0,
      maximum: 250.0,
      'gee:estimated_range': true,
    },
    radii_sw_64kt: {
      minimum: 0.0,
      maximum: 180.0,
      'gee:estimated_range': true,
    },
    radii_nw_64kt: {
      minimum: 0.0,
      maximum: 300.0,
      'gee:estimated_range': true,
    },
    year: {
      minimum: 1949.0,
      maximum: 2018.0,
      'gee:estimated_range': false,
    },
  },
  'gee:terms_of_use': |||
    NOAA data, information, and products, regardless of the method of delivery,
    are not subject to copyright and carry no restrictions on their subsequent
    use by the public. Once obtained, they may be put to any lawful use.
  |||,
}
