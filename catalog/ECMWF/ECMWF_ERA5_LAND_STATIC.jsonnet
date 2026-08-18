local id = 'ECMWF/ERA5_LAND/STATIC';
local subdir = 'ECMWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local era5_land = import 'templates/ECMWF_ERA5_LAND.libsonnet';

local license = spdx.proprietary;

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
  title: 'ERA5-Land Static - ECMWF Climate Reanalysis',
  'gee:type': ee_const.gee_type.image,
  description: era5_land.description + |||
    This dataset contains the static variables of ERA5-Land.
    These variables do not vary in time.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['climate'],
  keywords: era5_land.keywords,
  providers: [
    ee.producer_provider(
      'Copernicus Climate Data Store',
      'https://cds.climate.copernicus.eu/datasets/reanalysis-era5-land'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1950-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      11132.0,
    ],
    'eo:bands': [
      {
        name: 'glacier_mask',
        description: |||
          Fraction of the grid box covered by ice (glacier or ice cap).
          The values vary between 0 and 1 but do not vary in time.
        |||,
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'lake_cover',
        description: |||
          Fraction of the grid box that is occupied
          by lake (inland water). The values vary between 0 and 1 but
          do not vary in time.
        |||,
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'high_vegetation_cover',
        description: |||
          Fraction of the grid box that is covered
          with vegetation that is classified as "high". The values vary
          between 0 and 1 but do not vary in time. "High vegetation"
          consists of evergreen trees, deciduous trees, mixed
          forest/woodland, and interrupted forest.
        |||,
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'low_vegetation_cover',
        description: |||
          Fraction of the grid box that is covered
          with vegetation that is classified as "low". The values vary
          between 0 and 1 but do not vary in time. "Low vegetation"
          consists of crops and mixed farming, irrigated crops, short
          grass, tall grass, tundra, semidesert, bogs and marshes,
          evergreen shrubs, deciduous shrubs, and water and land
          mixtures.
        |||,
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'lake_total_depth',
        description: |||
          Total depth of the lake (both the water
          and ice part). This parameter does not vary in time.
        |||,
        'gee:units': units.meter,
      },
      {
        name: 'land_sea_mask',
        description: |||
          Fraction of the grid box that is land.
          The values vary between 0 and 1 but do not vary in time.
        |||,
        'gee:units': units.unspecified_fraction,
      },
      {
        name: 'soil_type',
        description: |||
          Texture (or classification) of soil used
          by the land surface scheme of the ECMWF Integrated Forecasting
          System (IFS) to predict the water holding capacity of soil in
          soil moisture and runoff calculations. It is derived from the
          root zone data (30-100 cm below the surface) of the FAO/UNESCO
          Digital Soil Map of the World, DSMW (FAO, 2003).
        |||,
        'gee:classes': [
          {value: 0, description: 'Non-land point'},
          {value: 1, description: 'Coarse'},
          {value: 2, description: 'Medium'},
          {value: 3, description: 'Medium fine'},
          {value: 4, description: 'Fine'},
          {value: 5, description: 'Very fine'},
          {value: 6, description: 'Organic'},
          {value: 7, description: 'Tropical organic'},
        ],
        'gee:units': units.dimensionless,
      },
      {
        name: 'type_of_high_vegetation',
        description: |||
          Indicates the types of high vegetation recognised
          by the ECMWF Integrated Forecasting System. Vegetation types
          are used to calculate the surface energy balance and snow
          albedo. This parameter does not vary in time.
        |||,
        'gee:classes': [
          {
            value: 0,
            description: 'None (including oceanic/inland water location)',
          },
          {value: 3, description: 'Evergreen needleleaf trees'},
          {value: 4, description: 'Deciduous needleleaf trees'},
          {value: 5, description: 'Deciduous broadleaf trees'},
          {value: 6, description: 'Evergreen broadleaf trees'},
          {value: 18, description: 'Mixed forest/woodland'},
          {value: 19, description: 'Interrupted forest'},
        ],
        'gee:units': units.dimensionless,
      },
      {
        name: 'type_of_low_vegetation',
        description: |||
          Indicates the types of low vegetation recognised
          by the ECMWF Integrated Forecasting System. Vegetation types
          are used to calculate the surface energy balance and snow
          albedo. This parameter does not vary in time.
        |||,
        'gee:classes': [
          {
            value: 0,
            description: 'None (including oceanic/inland water location)',
          },
          {value: 1, description: 'Crops, mixed farming'},
          {value: 2, description: 'Grass'},
          {value: 7, description: 'Tall grass'},
          {value: 9, description: 'Tundra'},
          {value: 10, description: 'Irrigated crops'},
          {value: 11, description: 'Semidesert'},
          {value: 13, description: 'Bogs and marshes'},
          {value: 16, description: 'Evergreen shrubs'},
          {value: 17, description: 'Deciduous shrubs'},
          {value: 20, description: 'Water and land mixtures'},
        ],
        'gee:units': units.dimensionless,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Soil Type',
        lookat: {
          lat: 21.2,
          lon: 22.2,
          zoom: 1,
        },
        image_visualization: {
          band_vis: {
            min: [
              1.0,
            ],
            max: [
              7.0,
            ],
            palette: [
              'e8d9a8', // 1 Coarse
              'd2b48c', // 2 Medium
              'b8935f', // 3 Medium fine
              '8b5a2b', // 4 Fine
              '6b4423', // 5 Very fine
              '3e2c1c', // 6 Organic
              '26140b'  // 7 Tropical organic
            ],
            bands: [
              'soil_type',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': era5_land.citation,
  'gee:terms_of_use': era5_land.terms_of_use,
}
