local id = 'JRC/LUCAS/THLOC/V1/2022';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LUCAS THLOC (Points with attributes, 2022) V1',
  version: 'V1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The
    [Land Use/Cover Area frame Survey (LUCAS)](https://ec.europa.eu/eurostat/web/lucas)
    in the European Union (EU) was set up to provide statistical information.
    It represents a triennial in-situ landcover and land-use data-collection
    exercise that extends over the whole of the EU's territory. LUCAS collects
    information on land cover and land use, agro-environmental variables, soil,
    and grassland. The surveys also provide spatial information to analyse the
    mutual influences between agriculture, environment, and countryside, such as
    irrigation and land management.

    The dataset presented here is the 2022 version of the LUCAS
    surveys. Each point's location is using
    the fields 'POINT_LAT' and 'POINT_LON', that is, the LUCAS theoretical
    location (THLOC), as prescribed by the LUCAS grid.  For more information
    please see Citations.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.license(license.reference),
  ],
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'eu',
    'jrc',
    'landcover',
    'landuse',
    'lucas',
  ],
  providers: [
    ee.producer_provider(
      'Joint Research Center, Unit D5',
      'https://ec.europa.eu/eurostat/web/lucas/database/2022'
    ),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-13.359375,
                    34.307144,
                    34.804688,
                    71.187754,
                    '2022-01-01T00:00:00Z',
                    '2022-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'POINT_ID',
        description: |||
          Theoretical point position in LAEA: First 4 digits are X_LAEA and other 4 digits are Y_LAEA.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_NUTS0',
        description: 'Country (NUTS 2021 classification).',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_NUTS1',
        description: |||
          Sub country division (NUTS 2021 classification).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_NUTS2',
        description: 'Region (NUTS 2021 classification).',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_NUTS3',
        description: 'Province (NUTS 2021 classification).',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_ALTITUDE',
        description: 'Point altitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_SOIL',
        description: 'SOIL 2022 sample.',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_EX_ANTE',
        description: 'Ex-Ante point.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_EXTENSION',
        description: 'PI extension point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_COPERNICUS',
        description: 'COPERNICUS 2022 sample',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_EROSION',
        description: 'GULLY EROSION point',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_SOIL_BULK_0_10',
        description: 'SOIL_BULK_0_10 point',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_SOIL_BULK_10_20',
        description: 'SOIL_BULK_10_20 point',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_SOIL_BULK_20_30',
        description: 'SOIL_BULK_20_30 point',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_SOIL_BIO',
        description: 'SOIL BIO point',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_LF',
        description: 'LANSCAPE FEATURES 2022 sample',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_DATE',
        description: 'Date.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_OBS_TYPE',
        description: |||
          Type of Observation.

          Values:

          * 1 Field survey, point visible, <= 100 m
          * 2 Field survey, point visible, >100 m to point
          * 3 Photo-interpretation in the field
          * 4 Point not visible. PI not possible
          * 5 Out of national territory
          * 6 Out of EU
          * 7 Photo-interpretation in the office
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GPS_PROJ',
        description: |||
          GPS coordinate system.

          Values:

          * WGS84
          * Problem with Signal
          * N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GPS_ALTITUDE',
        description: 'GPS elevation (meters).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_PREC',
        description: 'GPS precision (meters).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_OBS_DIST',
        description: 'GPS distance to point.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_OBS_DIRECT',
        description: |||
          Direction of observation.

          Values:

          * 1 On the point
          * 2 To North
          * 3 To East
          * 4 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_PARCEL_AREA_HA',
        description: |||
          Parcel area (ha).

          Values:

          * 1 area < 0.1
          * 2 0.1 <= area < 0.5
          * 3 0.5 <= area < 1
          * 4 1 <= area < 10
          * 5 area >= 10
          * 6 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC1',
        description: |||
          LC1 land cover 1. Land cover code (C3 doc).
          In case of PI, in addition to the detailed classification, also an aggregated classification can be used.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC1_SPEC',
        description: |||
          LC1 crop species. List of detailed crop species (C3 doc, codes B00), and an option “Assessment not possible” for PI (observation type 3 or 7).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC1_PERC',
        description: 'LC1 Crop-coverage (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LC2',
        description: |||
          LC2 land cover 2. Land cover code (C3 doc).
          In case of PI, in addition to the detailed classification, also an aggregated classification can be used.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC2_SPEC',
        description: |||
          LC2 crop species. List of detailed crop species (C3 doc, codes B00), and an option “Assessment not possible” for PI (observation type 3 or 7).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC2_PERC',
        description: 'LC2 Crop-coverage (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_TREE_HEIGHT_SURVEY',
        description: |||
          Height of trees (CXX, D10, E10)/crops (B70,B80) at survey.

          Values:

          * 1 < 5 m
          * 2 >= 5 m
          * 3 N.R.
          * 4 Assessment not possible
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_TREE_HEIGHT_MATURITY',
        description: |||
          Height of trees (CXX, D10, E10)/crops (B70,B80) at maturity.

          Values:

          * 1 < 5 m
          * 2 >= 5 m
          * 3 N.R.
          * 4 Assessment not possible
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_FEATURE_WIDTH',
        description: |||
          Width of feature.

          Values:

          * 1 < 20 m
          * 2 >= 20 m
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU1',
        description: |||
          LU1 land use 1. Land use code (C3 doc).
          In case of PI, in addition to the detailed classification, also an aggregated classification can be used.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU1_TYPE',
        description: |||
          LU1 land use type. List of detailed crop species (C3 doc, codes U22Xn and U315n), and an option “Assessment not possible” for PI (observation type 3 or 7).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU1_PERC',
        description: 'LU1 coverage (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LU2',
        description: |||
          LU2 land use 2. Land use code (C3 doc).
          In case of PI, in addition to the detailed classification, also an aggregated classification can be used.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU2_TYPE',
        description: |||
          LU2 land use type. List of detailed crop species (C3 doc, codes U22Xn, U315n), and an option “Assessment not possible” for PI (observation type 3 or 7).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU2_PERC',
        description: 'LU2 coverage (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GRAZING',
        description: |||
          Signs of grazing in the field (for points with LC in BXX, CXX, DXX, EXX,FXX,HXX).

          Values:

          * 1 Visible signs of grazing
          * 2 No signs of grazing
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SPECIAL_STATUS',
        description: |||
          Special status.

          Values:

          * 1 Protected
          * 2 Hunting
          * 3 Protected and Hunting
          * 4 No special status
          * 5 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC_LU_SPECIAL_REMARK',
        description: |||
          Special remarks on land cover/ land use.

          Values:

          * 1 Crop not recognizable - Field harvested (no re-visit)
          * 2 Crop not recognizable - Tilled and/or sowed (To be re-visited)
          * 3 Clear cut
          * 4 Burnt area
          * 5 Fire break
          * 6 Nursery
          * 7 Dump site
          * 8 Currently dry (river bed / lake)
          * 9 Currently flooded
          * 10 No remark
          * 11 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC1',
        description: 'Coniferous forest trees (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC2',
        description: 'Broadleaved forest trees (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC3',
        description: 'Shrubs (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC4',
        description: 'Herbaceous plants (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC5',
        description: 'Lichens and mosses (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC6',
        description: 'Consolidated (bare) surface (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC7',
        description: 'Unconsolidated (bare) surface (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_WM',
        description: |||
          Presence of water management.

          Values:

          * 1 Irrigation
          * 2 Potential irrigation
          * 3 Drainage
          * 4 Irrigation and drainage
          * 5 No visible water management
          * 6 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_WM_TYPE',
        description: |||
          Type of irrigation.

          Values:

          * 1 Gravity
          * 2 Pressure: Sprinkler irrigation
          * 3 Pressure: Micro-irrigation
          * 4 Gravity/Pressure
          * 5 Other/not identifiable
          * 6 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_WM_SOURCE',
        description: |||
          Source of irrigation.

          Values:

          * 1 Well
          * 2 Pond/Lake/Reservoir
          * 3 Stream/Canal/Ditch
          * 4 Lagoon/Wastewater
          * 5 Other/not identifiable
          * 6 N.R
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_WM_DELIVERY',
        description: |||
          Delivery System.

          Values:

          * 1 Canal
          * 2 Ditch
          * 3 Pipeline
          * 4 Other/not identifiable
          * 5 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_STD_TAKEN',
        description: |||
          Standard soil sample taken?

          Values:

          * 1 Yes
          * 2 Not possible
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_HEDGE',
        description: |||
          Presence of hedgerows.

          Values:

          * 1 Yes
          * 2 No
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_STONES_PERC',
        description: |||
          Stones on the surface (% related to the area of the circular sampling zone of 2-m radius, possible values 0-100).

          Values:

          * 0-25%
          * 25-50%
          * 50-75%
          * 75-100%
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_STONE_WALLS',
        description: |||
          Presence of stone walls.

          Values:

          * 1 No
          * 2 Stone wall, not maintained
          * 3 Stone wall, well maintained
          * 4 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_GRASS_MARGINS',
        description: |||
          Presence of grass margins.

          Values:

          * 1 No
          * 2 Grass margins <= 1m
          * 3 Grass margins > 1m
          * 4 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_CPRN_LC1N',
        description: |||
          Extension of LC to the North (in m).

          Source: C1(Instructions), p.233, sec.9.1.12
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRNC_LC1E',
        description: |||
          Extension of LC to the East (in m).

          Source: C1(Instructions), p.233, sec.9.1.12
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRNC_LC1S',
        description: |||
          Extension of LC to the South (in m).

          Source: C1(Instructions), p.233, sec.9.1.12
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRNC_LC1W',
        description: |||
          Extension of LC to the West (in m).

          Source: C1(Instructions), p.233, sec.9.1.12
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRN_URBAN',
        description: |||
          Point in urban area?

          Values:

          * 1 Yes
          * 2 No
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_TREES_SECONDARY',
        description: |||
          Trees with secondary crops or grazing 2 (within the extended + homogenous plot).

          Values:

          * 1 Cultivated trees with secondary crops, meadow or pasture (X06)
          * 2 Forest trees with grazed grassland, heathland and/or woodland flora (X09)
          * 3 N.R.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BIO_TAKEN',
        description: |||
          Biodiversity sample taken?

          Values:

          * 1 Yes
          * 2 Not possible
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_TAKEN',
        description: |||
          Bulk (0-10 cm) sample taken?

          Values:

          * 1 Yes
          * 2 Not possible
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_TAKEN',
        description: |||
          Bulk (10-20 cm) sample taken?

          Values:

          * 1 Yes
          * 2 Not possible
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_TAKEN',
        description: |||
          Bulk (20-30 cm) sample taken?

          Values:

          * 1 Yes
          * 2 Not possible
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_P',
        description: '0-10 cores taken: Point.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_N',
        description: '0-10 cores taken: North.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_E',
        description: '0-10 cores taken: East.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_S',
        description: '0-10 cores taken: South.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_W',
        description: '0-10 cores taken: West.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_P',
        description: '10-20 cores taken: Point.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_N',
        description: '10-20 cores taken: North.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_E',
        description: '10-20 cores taken: East.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_S',
        description: '10-20 cores taken: South.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_W',
        description: '10-20 cores taken: West.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_P',
        description: '20-30 cores taken: Point.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_N',
        description: '20-30 cores taken: North.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_E',
        description: '20-30 cores taken: East.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_S',
        description: '20-30 cores taken: South.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_W',
        description: '20-30 cores taken: West.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_MST_W_G',
        description: 'Bulk 0-10 moist weight (g)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_DRY_W_G',
        description: 'Bulk 0-10 dried weight (g)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_MST_W_G',
        description: 'Bulk 10-20 moist weight (g)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_DRY_W_G',
        description: 'Bulk 10-20 dried weight (g)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_MST_W_G',
        description: 'Bulk 20-30 moist weight (g)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_DRY_W_G',
        description: 'Bulk 20-30 dried weight (g)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CALC_DIST',
        description: 'GPS calculated distance to point.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRN_LC',
        description: 'Copernicus LC.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_CPRN_CANDO',
        description: |||
          Can you do the Copernicus survey?

          Values:

          * 1 Yes
          * 2 No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_HOMPLOT_FILLS_EXTWIN',
        description: |||
          Homogenous plot fills extended window.

          Values:

          * Yes
          * No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_REASON_DIRCHANGE',
        description: |||
          Reason for changing direction of observation.

          Values:

          * 1 Border between ...
          * 2 Linear Feature ...
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_REASON_BORDER_FROM',
        description: |||
          Border from. C1 - Annex 9.2.1 / 9.2.2 code list. If observation type is not 3 or 7, only 3rd level codes can be selected. If observation type is 3 or 7, codes in any level codes can be selected.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_REASON_BORDER_TO',
        description: |||
          Border to. C1 - Annex 9.2.1 / 9.2.2 code list. If observation type is not 3 or 7, only 3rd level codes can be selected. If observation type is 3 or 7, codes in any level codes can be selected.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_REASON_LF',
        description: |||
          Linear feature. C1 - Annex 9.2.7 code list.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_PHOTO_POOR',
        description: |||
          Poor Ortho-photo conditions ?

          Values:

          * 1 Outdated
          * 2 Detail quality issue
          * 3 Outdated and Detail quality issue
          * 4 No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_PHOTO_ADD_SOURCES',
        description: |||
          LC/LU assessment by using additional sources.

          Values:

          * 1 for LC
          * 2 for LU
          * 3 for LC/LU
          * 4 Not Used
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_PHOTO_SOURCES_USED',
        description: |||
          Additional sources used.

          Values:

          * 1 Google Earth /Google Maps
          * 2 Previous Campaign information
          * 3 Other additional sources
          * 4 No other suitable sources available
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_PHOTO_LOW_DETAIL',
        description: |||
          Only assessment on lower detail level possible.

          Values:

          * 1 for LC
          * 2 for LU
          * 3 for LC/LU
          * 4 No restriction, full assessment possible
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_INSPIRE_ARTIF',
        description: 'Artificial constructions (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_ARABLE',
        description: 'Arable land (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PERCON',
        description: 'Permanent woody and shrubby crops (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_WETCON',
        description: 'Wetlands and marshes (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_ORGCON',
        description: 'Organic deposits (peatland) (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_CHECON',
        description: 'Chemical deposits (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_INTCON',
        description: 'Intertidal flats (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_FRECON',
        description: 'Fresh water course (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_FRECON1',
        description: 'Fresh water bodies (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_SALCON',
        description: 'Salt or brackish water (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_UNVEGETATED',
        description: 'Unvegetated Area (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_GRASS_HEDGE',
        description: |||
          Presence of combined grass margin + hedgegrow.

          Values:

          * 1 Yes
          * 2 No
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_STAND_VEGET',
        description: |||
          Presence of soil surface covers: standing vegetation.

          Values:

          * 1 Yes
          * 2 No
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_BY_VEGET',
        description: |||
          Percentage of surface cover by standing vegetation.

          Values:

          * 1 0-25%
          * 2 25-50%
          * 3 50-75%
          * 4 75-100%
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_CROP_RESID',
        description: |||
          Presence of soil surface covers: crop residues.

          Values:

          * 1 Yes
          * 2 No
          * 3 N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LM_CROP_RESID_PERC',
        description: |||
          Percentage of surface cover by crop residues.

          Values:

          * 1 0-25%
          * 2 25-50%
          * 3 50-75%
          * 4 75-100%
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GULLY_SIGNS',
        description: |||
          Can you see signs of gully erosion?

          Values:

          * 1 Yes
          * 2 No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GULLY_TYPE',
        description: |||
          What type of gully do you observe?

          Values:

          * 1 Ephemeral gully (affects only the topsoil, <0.5 m deep)
          * 2 Permanent gullies (affects both topsoil and subsoil, 0.5-30 m deep)
          * 3 Badlands (i.e. gullied landscape areas)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GULLY_DIRECTION',
        description: |||
          Direction from point.

          Values:

          * North
          * East
          * South
          * West
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GULLY_LEN',
        description: |||
          Mean length (L) in meters.

          Values:

          * <1
          * 1-10
          * 10-50
          * 50-100
          * > 100
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GULLY_WID',
        description: |||
          Mean width (W) in meters.

          Values:

          * <1
          * 1-5
          * 5-10
          * 10-20
          * >20
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_GULLY_DEP',
        description: |||
          Mean depth (D) in meters.

          Values:

          * <0.3
          * 0.3-1
          * 1-5
          * 5-10
          * >10
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_WM_RECLAIM_SIGNS',
        description: |||
          Signs of use of reclaimed water.

          Values:

          * 1 Yes
          * 2 No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_CANDO',
        description: 'Can you do the soil assessement?',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_SOIL_LITTER_TAKEN',
        description: |||
          Only for soil samples in woodland sites: Litter sample taken? (CXX).

          Values:

          * 1 Yes
          * 2 Not possible
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LF_PICANDO',
        description: |||
          Landscape feature survey possible?

          Values:

          * 1 Yes (PI office)
          * 2 No (PI office)
          * N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LF_SUCANDO',
        description: |||
          Landscape feature survey possible?

          Values:

          * 1 Yes (field assessment)
          * 2 No (field assessment)
          * N.R.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LF_OFFPI_CONFIRMED',
        description: |||
          Office PI confirmed? (after the PI assessment).

          Values:

          * 1 Yes, office PI is confirmed
          * 2 No, field situation different, edit sub-points. (default value)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LF_AFTER_EDIT',
        description: |||
          After editing.

          Values:

          * 1 Confirm changes (default value)
          * 2 Close without changes
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LF_PHOTO_OUTDATED',
        description: |||
          Orthophoto outdated within the quadrant?

          Values:

          * 1 Yes
          * 2 No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LF_ADDIT_WALKING',
        description: |||
          Additional walking needed in the field?

          Values:

          * 1 Yes
          * 2 No
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_A1',
        description: 'PI linear feature 1 in transect A1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_A1',
        description: 'PI linear feature 2 in transect A1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_A1',
        description: 'Field linear feature 1 in transect A1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_A1',
        description: 'Field linear feature 2 in transect A1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_A3',
        description: 'PI linear feature 1 in transect A3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_A3',
        description: 'PI linear feature 2 in transect A3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_A3',
        description: 'Field linear feature 1 in transect A3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_A3',
        description: 'Field linear feature 2 in transect A3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_A5',
        description: 'PI linear feature 1 in transect A5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_A5',
        description: 'PI linear feature 2 in transect A5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_A5',
        description: 'Field linear feature 1 in transect A5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_A5',
        description: 'Field linear feature 2 in transect A5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_A7',
        description: 'PI linear feature 1 in transect A7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_A7',
        description: 'PI linear feature 2 in transect A7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_A7',
        description: 'Field linear feature 1 in transect A7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_A7',
        description: 'Field linear feature 2 in transect A7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_A9',
        description: 'PI linear feature 1 in transect A9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_A9',
        description: 'PI linear feature 2 in transect A9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_A9',
        description: 'Field linear feature 1 in transect A9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_A9',
        description: 'Field linear feature 2 in transect A9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_B2',
        description: 'PI linear feature 1 in transect B2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_B2',
        description: 'PI linear feature 2 in transect B2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_B2',
        description: 'Field linear feature 1 in transect B2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_B2',
        description: 'Field linear feature 2 in transect B2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_B4',
        description: 'PI linear feature 1 in transect B4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_B4',
        description: 'PI linear feature 2 in transect B4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_B4',
        description: 'Field linear feature 1 in transect B4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_B4',
        description: 'Field linear feature 2 in transect B4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_B6',
        description: 'PI linear feature 1 in transect B6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_B6',
        description: 'PI linear feature 2 in transect B6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_B6',
        description: 'Field linear feature 1 in transect B6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_B6',
        description: 'Field linear feature 2 in transect B6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_B8',
        description: 'PI linear feature 1 in transect B8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_B8',
        description: 'PI linear feature 2 in transect B8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_B8',
        description: 'Field linear feature 1 in transect B8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_B8',
        description: 'Field linear feature 2 in transect B8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_C1',
        description: 'PI linear feature 1 in transect C1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_C1',
        description: 'PI linear feature 2 in transect C1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_C1',
        description: 'Field linear feature 1 in transect C1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_C1',
        description: 'Field linear feature 2 in transect C1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_C3',
        description: 'PI linear feature 1 in transect C3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_C3',
        description: 'PI linear feature 2 in transect C3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_C3',
        description: 'Field linear feature 1 in transect C3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_C3',
        description: 'Field linear feature 2 in transect C3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_C5',
        description: 'PI linear feature 1 in transect C5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_C5',
        description: 'PI linear feature 2 in transect C5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_C5',
        description: 'Field linear feature 1 in transect C5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_C5',
        description: 'Field linear feature 2 in transect C5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_C7',
        description: 'PI linear feature 1 in transect C7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_C7',
        description: 'PI linear feature 2 in transect C7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_C7',
        description: 'Field linear feature 1 in transect C7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_C7',
        description: 'Field linear feature 2 in transect C7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_C9',
        description: 'PI linear feature 1 in transect C9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_C9',
        description: 'PI linear feature 2 in transect C9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_C9',
        description: 'Field linear feature 1 in transect C9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_C9',
        description: 'Field linear feature 2 in transect C9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_D2',
        description: 'PI linear feature 1 in transect D2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_D2',
        description: 'PI linear feature 2 in transect D2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_D2',
        description: 'Field linear feature 1 in transect D2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_D2',
        description: 'Field linear feature 2 in transect D2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_D4',
        description: 'PI linear feature 1 in transect D4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_D4',
        description: 'PI linear feature 2 in transect D4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_D4',
        description: 'Field linear feature 1 in transect D4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_D4',
        description: 'Field linear feature 2 in transect D4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_D6',
        description: 'PI linear feature 1 in transect D6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_D6',
        description: 'PI linear feature 2 in transect D6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_D6',
        description: 'Field linear feature 1 in transect D6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_D6',
        description: 'Field linear feature 2 in transect D6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_D8',
        description: 'PI linear feature 1 in transect D8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_D8',
        description: 'PI linear feature 2 in transect D8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_D8',
        description: 'Field linear feature 1 in transect D8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_D8',
        description: 'Field linear feature 2 in transect D8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_E1',
        description: 'PI linear feature 1 in transect E1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_E1',
        description: 'PI linear feature 2 in transect E1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_E1',
        description: 'Field linear feature 1 in transect E1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_E1',
        description: 'Field linear feature 2 in transect E1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_E3',
        description: 'PI linear feature 1 in transect E3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_E3',
        description: 'PI linear feature 2 in transect E3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_E3',
        description: 'Field linear feature 1 in transect E3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_E3',
        description: 'Field linear feature 2 in transect E3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_E5',
        description: 'PI linear feature 1 in transect E5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_E5',
        description: 'PI linear feature 2 in transect E5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_E5',
        description: 'Field linear feature 1 in transect E5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_E5',
        description: 'Field linear feature 2 in transect E5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_E7',
        description: 'PI linear feature 1 in transect E7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_E7',
        description: 'PI linear feature 2 in transect E7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_E7',
        description: 'Field linear feature 1 in transect E7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_E7',
        description: 'Field linear feature 2 in transect E7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_E9',
        description: 'PI linear feature 1 in transect E9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_E9',
        description: 'PI linear feature 2 in transect E9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_E9',
        description: 'Field linear feature 1 in transect E9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_E9',
        description: 'Field linear feature 2 in transect E9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_F2',
        description: 'PI linear feature 1 in transect F2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_F2',
        description: 'PI linear feature 2 in transect F2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_F2',
        description: 'Field linear feature 1 in transect F2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_F2',
        description: 'Field linear feature 2 in transect F2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_F4',
        description: 'PI linear feature 1 in transect F4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_F4',
        description: 'PI linear feature 2 in transect F4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_F4',
        description: 'Field linear feature 1 in transect F4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_F4',
        description: 'Field linear feature 2 in transect F4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_F6',
        description: 'PI linear feature 1 in transect F6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_F6',
        description: 'PI linear feature 2 in transect F6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_F6',
        description: 'Field linear feature 1 in transect F6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_F6',
        description: 'Field linear feature 2 in transect F6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_F8',
        description: 'PI linear feature 1 in transect F8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_F8',
        description: 'PI linear feature 2 in transect F8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_F8',
        description: 'Field linear feature 1 in transect F8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_F8',
        description: 'Field linear feature 2 in transect F8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_G1',
        description: 'PI linear feature 1 in transect G1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_G1',
        description: 'PI linear feature 2 in transect G1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_G1',
        description: 'Field linear feature 1 in transect G1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_G1',
        description: 'Field linear feature 2 in transect G1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_G3',
        description: 'PI linear feature 1 in transect G3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_G3',
        description: 'PI linear feature 2 in transect G3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_G3',
        description: 'Field linear feature 1 in transect G3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_G3',
        description: 'Field linear feature 2 in transect G3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_G5',
        description: 'PI linear feature 1 in transect G5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_G5',
        description: 'PI linear feature 2 in transect G5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_G5',
        description: 'Field linear feature 1 in transect G5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_G5',
        description: 'Field linear feature 2 in transect G5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_G7',
        description: 'PI linear feature 1 in transect G7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_G7',
        description: 'PI linear feature 2 in transect G7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_G7',
        description: 'Field linear feature 1 in transect G7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_G7',
        description: 'Field linear feature 2 in transect G7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_G9',
        description: 'PI linear feature 1 in transect G9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_G9',
        description: 'PI linear feature 2 in transect G9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_G9',
        description: 'Field linear feature 1 in transect G9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_G9',
        description: 'Field linear feature 2 in transect G9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_H2',
        description: 'PI linear feature 1 in transect H2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_H2',
        description: 'PI linear feature 2 in transect H2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_H2',
        description: 'Field linear feature 1 in transect H2',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_H2',
        description: 'Field linear feature 2 in transect H2',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_H4',
        description: 'PI linear feature 1 in transect H4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_H4',
        description: 'PI linear feature 2 in transect H4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_H4',
        description: 'Field linear feature 1 in transect H4',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_H4',
        description: 'Field linear feature 2 in transect H4',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_H6',
        description: 'PI linear feature 1 in transect H6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_H6',
        description: 'PI linear feature 2 in transect H6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_H6',
        description: 'Field linear feature 1 in transect H6',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_H6',
        description: 'Field linear feature 2 in transect H6',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_H8',
        description: 'PI linear feature 1 in transect H8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_H8',
        description: 'PI linear feature 2 in transect H8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_H8',
        description: 'Field linear feature 1 in transect H8',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_H8',
        description: 'Field linear feature 2 in transect H8',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_I1',
        description: 'PI linear feature 1 in transect I1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_I1',
        description: 'PI linear feature 2 in transect I1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_I1',
        description: 'Field linear feature 1 in transect I1',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_I1',
        description: 'Field linear feature 2 in transect I1',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_I3',
        description: 'PI linear feature 1 in transect I3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_I3',
        description: 'PI linear feature 2 in transect I3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_I3',
        description: 'Field linear feature 1 in transect I3',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_I3',
        description: 'Field linear feature 2 in transect I3',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_I5',
        description: 'PI linear feature 1 in transect I5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_I5',
        description: 'PI linear feature 2 in transect I5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_I5',
        description: 'Field linear feature 1 in transect I5',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_I5',
        description: 'Field linear feature 2 in transect I5',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_I7',
        description: 'PI linear feature 1 in transect I7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_I7',
        description: 'PI linear feature 2 in transect I7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_I7',
        description: 'Field linear feature 1 in transect I7',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_I7',
        description: 'Field linear feature 2 in transect I7',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_1_I9',
        description: 'PI linear feature 1 in transect I9',
        type: ee_const.var_type.string,
      },
      {
        name: 'PI_FEATURE_2_I9',
        description: 'PI linear feature 2 in transect I9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_1_I9',
        description: 'Field linear feature 1 in transect I9',
        type: ee_const.var_type.string,
      },
      {
        name: 'FIELD_FEATURE_2_I9',
        description: 'Field linear feature 2 in transect I9',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_INSPIRE_PERCON1',
        description: 'Permanent snow and ice (%).',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_LAT',
        description: 'Point latitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_LONG',
        description: 'Point longitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CAR_LATITUDE',
        description: 'Car park latitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CAR_LONGITUDE',
        description: 'Car park longitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_LAT',
        description: 'Point latitude',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_LONG',
        description: 'Point longitude',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_LITTER_DEPTH',
        description: 'Litter depth(if sample taken)',
        type: ee_const.var_type.double,
      },
      {
        name: 'photo_north',
        description: |||
          URL of photo looking North.

          Source: C1(Instructions), p.258, sec.9.1.19
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_south',
        description: |||
          URL of photo looking South.

          Source: C1(Instructions), p.258, sec.9.1.19
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_east',
        description: |||
          URL of photo looking East.

          Source: C1(Instructions), p.258, sec.9.1.19
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_west',
        description: |||
          URL of photo looking West.

          Source: C1(Instructions), p.258, sec.9.1.19
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_point',
        description: |||
          URL of photo on the point.

          Source: C1(Instructions), p.258, sec.9.1.19
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_croplc1',
        description: |||
          URL of crop LC1 photo.

          Source: C1(Instructions), p.258, sec.9.1.19
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'LUCAS Points',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
        table_visualization: {
          color: '489734',
          point_size: 3,
        },
      },
      {
        display_name: 'LUCAS Points',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 37.0,
          lon: -6.0,
          zoom: 10,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    Ghassemi, B., Izquierdo-Verdiguier, E., Verhegghen, A. et al.
    European Union crop map 2022: Earth observation’s 10-meter dive into
    Europe's crop tapestry. Sci Data 11, 1048 (2024).
    [doi:10.1038/s41597-024-03884-y](https://doi.org/10.1038/s41597-024-03884-y)
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
}
