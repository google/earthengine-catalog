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
    surveys with a total of 310 attributes. Each point's location is using
    the fields 'POINT_LAT' and 'POINT_LON', that is, the LUCAS theoretical
    location (THLOC), as prescribed by the LUCAS grid.  For more information
    please see Citations. Note that not every field is present for every
    year - see the \"Years\" section in property descriptions.

    The text \"C1 (Instructions)\" in the table schema descriptions refers to
    [this document](https://ec.europa.eu/eurostat/documents/205002/13686460/C1-LUCAS-2022.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.license(license.reference),
    {
      rel: ee_const.rel.source,
      href: 'https://www.dropbox.com/s/6fist8jby0uwwgo/lucas_harmo_pack_uf_final_th_gee_noNAs_noQuo.csv',
    },
  ],
  'gee:categories': ['landuse-landcover'],
  keywords: [
    'copernicus',
    'eu',
    'jrc',
    'landcover',
    'landuse',
    'lucas',
  ],
  providers: [
    ee.producer_provider(
      'Joint Research Center, Unit D5',
      'https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/LUCAS/LUCAS_2022/'
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
          8-digit unique point identifier, point ID according to the LUCAS grid.
          Such a point ID can either be part or not of a particular yearly
          LUCAS survey.

          Source: C1(Instructions), p.218, sec.9.1.1

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_NUTS0',
        description: 'Country (NUTS 2021 classification).\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_NUTS1',
        description: |||
          Sub country division (NUTS 2021 classification).\n\nYears: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_NUTS2',
        description: 'Region (NUTS 2021 classification).\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_NUTS3',
        description: 'Province (NUTS 2021 classification).\n\nYears: 2018, 2022',
        type: ee_const.var_type.string,
      },
      {
        name: 'POINT_ALTITUDE',
        description: 'Elevation in m above sea level.',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_SOIL',
        description: 'Soil point.',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_EX_ANTE',
        description: |||
          Ex-ante points are points that are parts of the in-situ sample and in
          principle have to be visited in the field, although there are a
          posteriori reasons why this is impossible. If true, then this
          point_id was not visited by an inspector for this year.

          Values:

          * TRUE
          * FALSE

          Source: C1(Instructions), p.21, sec 8.1; C1(Instructions), p.218,
          sec.9.1.1

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'PI_EXTENSION',
        description: 'PI extension point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_COPERNICUS',
        description: 'COPERNICUS 2022 sample',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_EROSION',
        description: 'GULLY EROSION point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_SOIL_BULK_0_10',
        description: 'SOIL_BULK_0_10 point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_SOIL_BULK_10_20',
        description: 'SOIL_BULK_10_20 point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_SOIL_BULK_20_30',
        description: 'SOIL_BULK_20_30 point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_SOIL_BIO',
        description: 'SOIL BIO point',
        type: ee_const.var_type.double,
      },
      {
        name: 'POINT_LF',
        description: 'LANSCAPE FEATURES 2022 sample',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_DATE',
        description: |||
          Date on which the survey was carried out in the format dd/mm/yy
          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_OBS_TYPE',
        description: |||
          The method of observation for the relevant point. For the
          availability of LUCAS photos according to obs_type, please
          check C1(Instructions), sec. 8.15.3.

          Values:

          * In situ < 100 m
          * In situ > 100 m
          * In situ PI
          * In situ PI not possible
          * Out of national territory
          * In office PI
          * Marine Sea (only 2015)

          For more details, check the documentation.

          Source: C1(Instructions), p.220, sec.9.1.3

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_PROJ',
        description: |||
          GPS projection.

          Values:

          * WGS84
          * No GPS signal
          * empty if not relevant

          Source: C1(Instructions), p.219, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_ALTITUDE',
        description: |||
          GPS elevation of the location from which observation
          is done (in meters above sea level).

          Source: C1(Instructions), p.218, sec.9.1.1

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_PREC',
        description: |||
          GPS precision (meters).

          Source: C1(Instructions), p.219, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_OBS_DIST',
        description: |||
          Distance between observation location and the LUCAS point as
          provided by the GPS receiver (in meters).

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_OBS_DIRECT',
        description: |||
          Direction of the observation.

          Values:

          * On the point: Point regularly observed
          * Look to the North: "Look to the North" rule is applied id the point
            is located on a boundary/ e.g., or a small linear feature
            (<3 m wide)
          * Look to the East: "Look to the East" rule is applied if he point is
            located on a boundary/e.g., or a small linear feature (<3 m wide)
          * empty if not relevant

          Source: C1(Instructions), p.220, sec.9.1.3

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_PARCEL_AREA_HA',
        description: |||
          Size of the surveyed parcel in hectares.

          Values:

          * < 0.5
          * 0.5 - 1
          * 1 - 10
          * > 10
          * empty if not relevant

          Source: C1(Instructions), p.66, sec.8.6.15

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LC1',
        description: |||
          Coding of land cover according to harmonized C3 classification.
          Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC1_SPEC',
        description: |||
          Coding of land cover species according to harmonized C3
          classification. Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC1_PERC',
        description: |||
          Percentage of LC1 crop coverage. For 2009-2015, values are classes:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * > 75 %
          * empty if not relevant

          For 2018 and 2022, values are percentage (0-100).
          The variable does not exist for 2006.

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LC2',
        description: |||
          Coding of land cover according to harmonized C3 classification.
          Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC2_SPEC',
        description: |||
          Coding of land cover species according to harmonized C3
          classification. Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LC2_PERC',
        description: |||
          Percentage of LC2 crop coverage. For 2009-2015, values are classes:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * > 75 %
          * empty if not relevant

          For 2018 and 2022, values are percentage (0-100).
          The variable does not exist for 2006.

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_TREE_HEIGHT_SURVEY',
        description: |||
          Height of trees at the moment of survey.

          Values:

          * < 5 m
          * > 5 m
          * Not identifiable
          * empty if not relevant

          Source: C1(Instructions), p.227, sec.9.1.7

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_TREE_HEIGHT_MATURITY',
        description: |||
          Height of trees at maturity.

          Values:

          * < 5 m
          * > 5 m
          * Not identifiable
          * empty if not relevant

          Source: C1(Instructions), p.227, sec.9.1.7

          Years: 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_FEATURE_WIDTH',
        description: |||
          Width of the feature.

          Values:

          * < 20 m
          * > 20 m
          * Not identifiable
          * empty if not relevant

          Source: C1(Instructions), p.227, sec.9.1.7

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LU1',
        description: |||
          Coding of the land use according to Harmonized C3 document
          classification. Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU1_TYPE',
        description: |||
          Coding of the land use types according to Harmonized C3 document
          classification. Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU1_PERC',
        description: |||
          Percentage of LU1 coverage. For 2015, values are classes:

          * < 5 %
          * 5 - 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * 75 - 90 %
          * > 90 %
          * Not Relevant

          For 2018 and 2022, values are percentage (0-100).
          The variable does not exist for 2006, 2009 and 2012.

          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LU2',
        description: |||
          Coding of the land use according to Harmonized C3 document
          classification. Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU2_TYPE',
        description: |||
          Coding of the land use types according to Harmonized C3 document
          classification. Coding and label translation can be found in
          the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237)
          in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_LU2_PERC',
        description: |||
          Percentage of LU2 coverage. For 2015, values are classes:

          * < 5 %
          * 5 - 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * 75 - 90 %
          * > 90 %
          * Not Relevant

          For 2018 and 2022, values are percentage (0-100).
          The variable does not exist for 2006, 2009 and 2012.

          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GRAZING',
        description: |||
          Signs of grazing in the field.

          Values:

          * Signs of grazing
          * No signs of grazing
          * empty if not relevant

          Source: C1(Instructions), p.229, sec.9.1.9

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SPECIAL_STATUS',
        description: |||
          Whether the plot is a part of any specially regulated area.

          Values:

          * Protected
          * Hunting
          * Protected and hunting
          * No special status
          * empty if not relevant

          Source: C1(Instructions), p.229, sec.9.1.9

          Years: 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LC_LU_SPECIAL_REMARK',
        description: |||
          Any special remarks on the land cover / land use.

          Values:

          * Harvested field
          * Tilled/sowed
          * Clear cut
          * Burnt area
          * Fire break
          * Nursery
          * Dump site
          * Temporary dry
          * Temporary flooded
          * No remark
          * empty if not relevant

          For more details check the documentation.

          Source: C1(Instructions), p.229, sec.9.1.9

          Years: 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC1',
        description: |||
          Percentage of coniferous forest trees.
          Source: C1(Instructions), p.226, sec.9.1.6
          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC2',
        description: |||
          Percentage of broadleaved forest trees.
          Source: C1(Instructions), p.226, sec.9.1.6
          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC3',
        description: |||
          Percentage of shrubs.
          Source: C1(Instructions), p.226, sec.9.1.6
          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC4',
        description: |||
          Percentage of herbaceous plants.
          Source: C1(Instructions), p.226, sec.9.1.6
          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC5',
        description: |||
          Percentage of lichens and mosses.
          Source: C1(Instructions), p.226, sec.9.1.6
          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC6',
        description: |||
          Percentage of consolidated (bare) surface.

          Source: C1(Instructions), p.226, sec.9.1.6

          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PLCC7',
        description: |||
          Percentage of unconsolidated (bare) surface.

          Source: C1(Instructions), p.226, sec.9.1.6

          Years: 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_WM',
        description: |||
          Presence of water management.

          Values:

          * Irrigation
          * Potential irrigation
          * Drainage
          * Irrigation and drainage
          * No visible water management
          * empty if not relevant

          Source: C1(Instructions), p.232, sec.9.1.11

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_WM_TYPE',
        description: |||
          The type of irrigation present at the point.

          Values:

          * Gravity
          * Pressure: Sprinkle irrigation
          * Pressure: Micro-irrigation
          * Gravity/Pressure
          * Other/Non identifiable
          * Combo - Pressure: Sprinkle irrigation + Pressure: Micro-irrigation
          * Combo - Gravity/Pressure + Gravity
          * Combo - Pressure: Sprinkle irrigation + Gravity/Pressure
          * Combo - Pressure: Micro-irrigation + Gravity/Pressure
          * Other/not identifiable
          * Combo - Other/Non identifiable + Gravity
          * Combo - Other/Non identifiable + Gravity/Pressure
          * Combo - Other/Non identifiable + Gravity/Pressure + Pressure: Micro-irrigation
          * empty if not relevant

          Combo classes exist only for 2009 and were later discontinued.
          For more details check the documentation.

          Source: C1(Instructions), p.232, sec.9.1.11

          Years: 2009
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_WM_SOURCE',
        description: |||
          Source of the irrigation at the point.

          Values:

          * Combo - Other/Not Identifiable + Well
          * Combo - Other/Not Identifiable + Pond/Lake/Reservoir
          * Combo - Other/Not Identifiable + Stream/Canal/Ditch
          * Combo - Other/Not Identifiable + Lagoon/Wastewater
          * Combo - Pond/Lake/Reservoir + Stream/Canal/Ditch
          * Lagoon/Wastewater
          * Pond/Lake/Reservoir
          * Stream/Canal/Ditch
          * Well
          * Other/Not Identifiable
          * empty if not relevant

          Combo classes exist only for 2009 and were later discontinued.
          For more details check the documentation.

          Source: C1(Instructions), p.232, sec.9.1.11

          Years: 2009
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_WM_DELIVERY',
        description: |||
          The irrigation delivery system at the point.

          Values:

          * Canal
          * Combo - Pipeline + Ditch
          * Combo - Other/Non identifiable + Ditch
          * Combo - Other/Non identifiable + Pipeline
          * Ditch
          * Pipeline
          * Other/Non identifiable
          * Other/Non identifiable + Canal
          * empty if not relevant

          Combo classes exist only for 2009 and were later discontinued. For
          more details check the documentation.

          Source: C1(Instructions), p.232, sec.9.1.11

          Years: 2009
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_STD_TAKEN',
        description: |||
          Standard soil sample taken?.

          Values:

          * true
          * false

          Source: C1(Instructions), p.257, sec.9.1.17.6

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_HEDGE',
        description: 'Presence of hedgerows',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_STONES_PERC',
        description: |||
          Stones on the surface (%).

          Values:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * > 50 %
          * empty if not relevant

          This coding applies only for the years 2009-2015 . For 2018 the number
          represents the percentage of stones on the surface (0-100).
          The variable does not exist for 2006.

          Source: C1(Instructions), p.255, sec.9.1.17.3

          Years: 2009, 2012, 2015, 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_STONE_WALLS',
        description: |||
          Presence of stone walls on the plot.

          Values:

          * No
          * Stone wall not maintained
          * Stone wall well maintained
          * empty if not relevant

          Source: C1(Instructions), p.228, sec.9.1.8

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_GRASS_MARGINS',
        description: |||
          Presence of grass margins on the plot.

          Values:

          * No
          * < 1 m width
          * > 1 m width
          * empty if not relevant

          Source: C1(Instructions), p.228, sec.9.1.8

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRN_LC1N',
        description: |||
          Extension of LC to the North (in m).

          Source: C1(Instructions), p.233, sec.9.1.12

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRNC_LC1E',
        description: |||
          Extension of LC to the East (in m).

          Source: C1(Instructions), p.233, sec.9.1.12

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRNC_LC1S',
        description: |||
          Extension of LC to the South (in m).

          Source: C1(Instructions), p.233, sec.9.1.12

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRNC_LC1W',
        description: |||
          Extension of LC to the West (in m).

          Source: C1(Instructions), p.233, sec.9.1.12

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRN_URBAN',
        description: |||
          Point in urban area?.

          Values:

          * true
          * false

          Source: C1(Instructions), p.226, sec.9.1.6

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_TREES_SECONDARY',
        description: |||
          Trees with secondary crops or grazing 2
          (within the extended + homogenous plot).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BIO_TAKEN',
        description: |||
          Biodiversity sample taken?.

          Values:

          * true
          * false

          Source: C1(Instructions), p.255, sec.9.1.17.4

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_TAKEN',
        description: |||
          Bulk (0-10 cm) sample taken?.

          Values:

          * true
          * false

          Source: C1(Instructions), p.256, sec.9.1.17.5

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_TAKEN',
        description: |||
          Bulk (10-20 cm) sample taken?.

          Values:

          * Yes
          * No

          Source: C1(Instructions), p.256, sec.9.1.17.5

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_TAKEN',
        description: |||
          Bulk (20-30 cm) sample taken?.

          Values:

          * true
          * false

          Source: C1(Instructions), p.256, sec.9.1.17.5

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_P',
        description: |||
          Flag indicating if soil bulk density sample 0-10cm depth at point
          P (centre) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_N',
        description: |||
          Flag indicating if soil bulk density sample 0-10cm depth at point
          N (north) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_E',
        description: |||
          Flag indicating if soil bulk density sample 0-10cm depth at point
          E (east) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_S',
        description: |||
          Flag indicating if soil bulk density sample 0-10cm depth at point
          S (south) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_0_10_CO_W',
        description: |||
          Flag indicating if soil bulk density sample 0-10cm depth at point
          W (west) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_P',
        description: |||
          Flag indicating if soil bulk density sample 10-20cm depth at
          point P (centre) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_N',
        description: |||
          Flag indicating if soil bulk density sample 10-20cm depth at
          point N (north) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_E',
        description: |||
          Flag indicating if soil bulk density sample 10-20cm depth at
          point E (east) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_S',
        description: |||
          Flag indicating if soil bulk density sample 10-20cm depth at
          point S (south) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_10_20_CO_W',
        description: |||
          Flag indicating if soil bulk density sample 10-20cm depth at
          point W (west) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_P',
        description: |||
          Flag indicating if soil bulk density sample 20-30cm depth at
          point P (centre) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_N',
        description: |||
          Flag indicating if soil bulk density sample 20-30cm depth at
          point N (north) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_E',
        description: |||
          Flag indicating if soil bulk density sample 20-30cm depth at
          point E (east) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_S',
        description: |||
          Flag indicating if soil bulk density sample 20-30cm depth at
          point S (south) was collected
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_BLK_20_30_CO_W',
        description: |||
          Flag indicating if soil bulk density sample 20-30cm depth at
          point W (west) was collected
        |||,
        type: ee_const.var_type.double,
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
        description: |||
          Distance between theoretical point and GPS point in meters
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CPRN_LC',
        description: |||
          The land cover on the Copernicus points according to the
          classification scheme at level2.

          Source: Harmonized C3 document

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_CPRN_CANDO',
        description: |||
          Can you do the Copernicus survey?.
          For more information on the
          Copernicus module and the data created please refer to
          [d'Andrimont et al, 2021](https://essd.copernicus.org/articles/13/1119/2021/ ).

          Values:
          * true
          * false

          Source: C1(Instructions), p.233, sec.9.1.12

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_HOMPLOT_FILLS_EXTWIN',
        description: 'Homogenous plot fills extended window',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_REASON_DIRCHANGE',
        description: 'Reason for changing direction of observation',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_REASON_BORDER_FROM',
        description: 'Reason for border: from',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_REASON_BORDER_TO',
        description: 'Reason for border: to',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_REASON_LF',
        description: 'Linear feature',
        type: ee_const.var_type.string,
      },
      {
        name: 'SURVEY_PHOTO_POOR',
        description: 'Poor Ortho-photo conditions ?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_PHOTO_ADD_SOURCES',
        description: 'LC/LU assessment by using additional sources',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_PHOTO_SOURCES_USED',
        description: 'Additional sources used',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_PHOTO_LOW_DETAIL',
        description: 'Only assessment on lower detail level possible',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_ARTIF',
        description: 'Percentage of artificial constructions',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_ARABLE',
        description: 'Percentage of arable land',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_PERCON',
        description: 'Percentage of permanent woody and shrubby crops',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_WETCON',
        description: 'Percentage of wetlands and marshes',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_ORGCON',
        description: 'Percentage of organic deposits (peatland)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_CHECON',
        description: 'Percentage of chemical deposits',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_INTCON',
        description: 'Percentage of intertidal flats',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_FRECON',
        description: 'Percentage of fresh water course',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_FRECON1',
        description: 'Percentage of fresh water bodies',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_SALCON',
        description: 'Percentage of salt or brackish water',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_INSPIRE_UNVEGETATED',
        description: 'Percentage of unvegetated Area',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_GRASS_HEDGE',
        description: 'Presence of combined grass margin + hedgegrow',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_STAND_VEGET',
        description: 'Presence of soil surface covers: standing vegetation',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_BY_VEGET',
        description: 'Percentage of surface cover by standing vegetation',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_CROP_RESID',
        description: 'Presence of soil surface covers: crop residues',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LM_CROP_RESID_PERC',
        description: 'Percentage of surface cover by crop residues',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GULLY_SIGNS',
        description: 'Can you see signs of gully erosion?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GULLY_TYPE',
        description: 'What type of gully do you observe?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GULLY_DIRECTION',
        description: 'Direction from point',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GULLY_LEN',
        description: 'Mean length (L) in meters',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GULLY_WID',
        description: 'Mean width (W) in meters',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GULLY_DEP',
        description: 'Mean depth (D) in meters',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_WM_RECLAIM_SIGNS',
        description: 'Signs of use of reclaimed water',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_CANDO',
        description: 'Can you do the soil assessement?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_SOIL_LITTER_TAKEN',
        description: 'Litter sample taken? (CXX)',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LF_PICANDO',
        description: 'Landscape feature survey possible?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LF_SUCANDO',
        description: 'Landscape feature survey possible?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LF_OFFPI_CONFIRMED',
        description: 'Office PI confirmed?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LF_AFTER_EDIT',
        description: 'After editing',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LF_PHOTO_OUTDATED',
        description: 'Orthophoto outdated within the quadrant?',
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_LF_ADDIT_WALKING',
        description: 'Additional walking needed in the field?',
        type: ee_const.var_type.double,
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
        description: |||
          Percentage of permanent snow and ice.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_LAT',
        description: |||
          GPS latitude of the location from which observation is actually
          done (WGS84) measured in degrees.

          Source: C1(Instructions), p.219, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_GPS_LONG',
        description: |||
          GPS longitude of the location from which observation is actually
          done (WGS84) measured in degrees.

          Source: C1(Instructions), p.219, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CAR_LATITUDE',
        description: |||
          Latitude (WGS84) on which the car was parked.

          Source: C1(Instructions), p.219, sec.9.1.2

          Years: 2018, 2022
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'SURVEY_CAR_LONGITUDE',
        description: |||
          Longitude (WGS84) on which the car was parked.

          Source: C1(Instructions), p.219, sec.9.1.2

          Years: 2018, 2022
        |||,
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

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_south',
        description: |||
          URL of photo looking South.

          Source: C1(Instructions), p.258, sec.9.1.19

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_east',
        description: |||
          URL of photo looking East.

          Source: C1(Instructions), p.258, sec.9.1.19

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_west',
        description: |||
          URL of photo looking West.

          Source: C1(Instructions), p.258, sec.9.1.19

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_point',
        description: |||
          URL of photo on the point.

          Source: C1(Instructions), p.258, sec.9.1.19

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_croplc1',
        description: |||
          URL of crop LC1 photo.

          Source: C1(Instructions), p.258, sec.9.1.19

          Years: all
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
      max_features_per_tile: 150,
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
