local id = 'JRC/LUCAS_HARMO/THLOC/V1';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'LUCAS Harmonized (Theoretical Location, 2006-2018) V1',
  version: 'V1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The [Land Use/Cover Area frame Survey (LUCAS)](https://ec.europa.eu/eurostat/web/lucas)
    in the European Union (EU) was set up to provide statistical information.
    It represents a triennial in-situ landcover and land-use data-collection
    exercise that extends over the whole of the EU's territory.  LUCAS collects
    information on land cover and land use, agro-environmental variables, soil, and
    grassland. The surveys also provide spatial information to analyse the mutual
    influences between agriculture, environment, and countryside, such as
    irrigation and land management.

    The dataset presented here is the harmonized version of all yearly LUCAS
    surveys with a total of 106 attributes. Each point's location is using
    the fields 'th_lat' and 'th_lon', that is, the LUCAS theoretical location
    (THLOC), as prescribed by the LUCAS grid.  For more information please
    see Citations. Note that not every field is present for every year - see
    the \"Years\" section in property descriptions.

    The text \"C1 (Instructions)\" in the table schema descriptions refers to
    [this document](https://ec.europa.eu/eurostat/documents/205002/8072634/LUCAS2018-C1-Instructions.pdf).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license(license.reference),
    {
      rel: 'source',
      href: 'https://www.dropbox.com/s/6fist8jby0uwwgo/lucas_harmo_pack_uf_final_th_gee_noNAs_noQuo.csv',
    },
  ],
  keywords: [
    'EU',
    'JRC',
    'landcover',
    'landuse',
  ],
  providers: [
    ee.producer_provider('Joint Research Center, Unit D5', 'https://jeodpp.jrc.ec.europa.eu/ftp/jrc-opendata/LUCAS/LUCAS_harmonised/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-13.359375, 34.307144, 34.804688, 71.187754,
                    '2006-02-05T00:00:00Z', '2019-03-14T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'id',
        description: 'Unique row identifier.\n\nSource: Added by harmonization process',
        type: ee_const.var_type.int,
      },
      {
        name: 'point_id',
        description: |||
          8-digit unique point identifier, point ID according to the LUCAS grid.
          Such a point ID can either be part or not of a particular yearly
          LUCAS survey.

          Source: C1(Instructions), p.141, sec.9.1.1

          Years: all
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'year',
        description: 'Year of survey.\n\nSource: Added by harmonization process\n\nYears: all',
        type: ee_const.var_type.int,
      },
      {
        name: 'nuts0',
        description: 'NUTS 2016 Level 0.\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'nuts1',
        description: 'NUTS 2016 Level 1.\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'nuts2',
        description: 'NUTS 2016 Level 2.\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'nuts3',
        description: 'NUTS 2016 Level 3.\n\nYears: 2018',
        type: ee_const.var_type.string,
      },
      {
        name: 'office_pi',
        description: |||
          Whether photo-interpretation has happened in the office
          for this LUCAS point. If true, then this point_id was not visited by
          an inspector for this year.

          Values:

          * true
          * false

          Source: C1(Instructions), p.141, sec.9.1.1

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ex_ante',
        description: |||
          Ex-ante points are points that are parts of the in-situ sample and in
          principle have to be visited in the field, although there are a posteriori
          reasons why this is impossible. If true, then this point_id was not
          visited by an inspector for this year.

          Values:

          * true
          * false

          Source: C1(Instructions), p.16, sec 8.1; C1(Instructions), p.141, sec.9.1.1

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'survey_date',
        description: 'Date on which the survey was carried out in the format dd/mm/yy\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'car_latitude',
        description: |||
          Latitude (WGS84) on which the car was parked.

          Source: C1(Instructions), p.141, sec.9.1.2

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'car_ew',
        description: |||
          GPS Car parking East/West compass setting. Used for knowing when to add
          a minus to the respective coordinate.

          Values:

          * East
          * West
          * empty if not relevant

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'car_longitude',
        description: |||
          Longitude (WGS84) on which the car was parked.

          Source: C1(Instructions), p.142, sec.9.1.2

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'gps_proj',
        description: |||
          GPS projection.

          Values:

          * WGS84
          * No GPS signal
          * empty if not relevant

          Source: C1(Instructions), p.142, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'gps_prec',
        description: |||
          Average location error as given by GPS receiver (in meters).

          Source: C1(Instructions), p.142, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'gps_altitude',
        description: |||
          Elevation in m above sea level.

          Source: C1(Instructions), p.141, sec.9.1.1

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'gps_lat',
        description: |||
          GPS latitude of the location from which observation is actually done (WGS84) measured in degrees.

          Source: C1(Instructions), p.142, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'gps_ew',
        description: 'East-west encoding setting for GPS.\n\nValues:\n\n* East\n* West\n* empty if not relevant\n\nYears: all',
        type: ee_const.var_type.string,
      },
      {
        name: 'gps_long',
        description: |||
          GPS longitude of the location from which observation is actually done (WGS84) measured in degrees.

          Source: C1(Instructions), p.142, sec.9.1.2

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'obs_dist',
        description: |||
          Distance between observation location and the LUCAS point as provided by the GPS receiver (in meters).

          Years: all
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'obs_direct',
        description: |||
          Direction of the observation.

          Values:

          * On the point: Point regularly observed
          * Look to the North: "Look to the North" rule is applied id the point is
              located on a boundary/ e.g., or a small linear feature (<3 m wide)
          * Look to the East: "Look to the East" rule is applied if he point is
              located on a boundary/e.g., or a small linear feature (<3 m wide)
          * empty if not relevant

          Source: C1(Instructions), p.144, sec.9.1.4

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'obs_type',
        description: |||
          The method of observation for the relevant point. For the availability of LUCAS photos according to obs_type, please check C1(Instructions), sec. 8.15.3.

          Values:

          * In situ < 100 m
          * In situ > 100 m
          * In situ PI
          * In situ PI not possible
          * Out of national territory
          * In office PI
          * Marine Sea
          * (only 2015)

          Find more details check the documentation.

          Source: C1(Instructions), p.142-144, sec.9.1.4

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'obs_radius',
        description: |||
          The radius of observation - whether the near or the extended window
          of observation is applied.

          Values:

          * 1.5
          * 20
          * null if not relevant

          Source: C1(Instructions)

          Years: 2006, 2009, 2012, 2015
        |||,
        type: ee_const.var_type.double,
        units: 'meters',
      },
      {
        name: 'letter_group',
        description: |||
          Which letter group (top tier classification) from the C3 document is the point assigned to.

          Source: Added by harmonization process

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc1',
        description: |||
          Coding of land cover according to harmonized C3 classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc1_label',
        description: |||
          Label of land cover according to harmonized C3 document. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc1_spec',
        description: |||
          Coding of land cover species according to harmonized C3 classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc1_spec_label',
        description: |||
          Label of land cover species according to harmonized C3 document. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc1_perc',
        description: |||
          The percentage that the assigned land cover type (lc1) occupies on the ground.

          Values:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * > 75 %
          * empty if not relevant

          This coding applies only for the years 2009–2015 . For 2018 the number represents the percentage of land-cover (0-100). The variable does not exist for 2006

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc2',
        description: |||
          Coding of land cover according to harmonized C3 classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc2_label',
        description: |||
          Label of land cover according to harmonized C3 document. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc2_spec',
        description: |||
          Coding of land cover species according to harmonized C3 classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc2_spec_label',
        description: |||
          Label of land cover species according to harmonized C3 document. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc2_perc',
        description: |||
          The percentage that the assigned land cover type (lc2) occupies on the ground.

          Values:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * > 75 %
          * empty if not relevant

          This coding applies only for the years 2009–2015 . For 2018 the number represents the percentage of land-cover (0-100). The variable does not exist for 2006

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu1',
        description: |||
          Coding of the land use according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu1_label',
        description: |||
          Label of the land use according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu1_type',
        description: |||
          Coding of the land use types according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu1_type_label',
        description: |||
          Label of the land use types according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu1_perc',
        description: |||
          The percentage that the assigned land use type (lu1) occupies on the ground.

          Values:

          * < 5 %
          * 5 - 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * 75 - 90 %
          * > 90 %
          * Not Relevant

          This coding applies only for the year 2015. For 2018 the number represents the percentage of land-cover (0-100). The variable does not exist for 2006, 2009 and 2012.

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu2',
        description: |||
          Coding of the land use according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu2_label',
        description: |||
          Label of the land use according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu2_type',
        description: |||
          Coding of the land use types according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu2_type_label',
        description: |||
          Label of the land use types according to Harmonized C3 document classification. Coding and label translation can be found in the [supporting docs](https://figshare.com/s/e6cab3bceaa9a2299237) in file *c3_legends_new.csv*.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lu2_perc',
        description: |||
          The percentage that the assigned land use type (lu2) occupies on the ground.

          Values:

          * < 5 %
          * 5 - 10 %
          * 10 - 25 %
          * 25 - 50 %
          * 50 - 75 %
          * 75 - 90 %
          * > 90 %
          * Not Relevant

          This coding applies only for the year 2015. For 2018 the number represents the percentage of land-cover (0-100). The variable does not exist for 2006, 2009 and 2012.

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'parcel_area_ha',
        description: |||
          Size of the surveyed parcel in hectares.

          Values:

          * < 0.5
          * 0.5 - 1
          * 1 - 10
          * > 10
          * empty if not relevant

          Source: C1(Instructions), p.50, sec.8.4.15

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'tree_height_maturity',
        description: |||
          Height of trees at maturity.

          Values:

          * < 5 m
          * > 5 m
          * Not identifiable
          * empty if not relevant

          Source: C1(Instructions), p.147, sec.9.1.6

          Years: 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'tree_height_survey',
        description: |||
          Height of trees at the moment of survey.

          Values:

          * < 5 m
          * > 5 m
          * Not identifiable
          * empty if not relevant

          Source: C1(Instructions), p.147, sec.9.1.6

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'feature_width',
        description: |||
          Width of the feature.

          Values:

          * < 20 m
          * > 20 m
          * Not identifiable
          * empty if not relevant

          Source: C1(Instructions), p.147, sec.9.1.6

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lm_stone_walls',
        description: |||
          Presence of stone walls on the plot.

          Values:

          * No
          * Stone wall not maintained
          * Stone wall well maintained
          * empty if not relevant

          Source: C1(Instructions), p.148, sec.9.1.7

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'crop_residues',
        description: |||
          Presence of crop residues on the plot.

          Values:

          * true
          * false

          Source: C1(Instructions), p.51, sec.8.6

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lm_grass_margins',
        description: |||
          Presence of grass margins on the plot.

          Values:

          * No
          * < 1 m width
          * > 1 m width
          * empty if not relevant

          Source: C1(Instructions), p.148, sec.9.1.7

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'grazing',
        description: |||
          Signs of grazing on the plot.

          Values:

          * Signs of grazing
          * No signs of grazing
          * empty if not relevant

          Source: C1(Instructions), p.148, sec.9.1.8

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'special_status',
        description: |||
          Whether the plot is a part of any specially regulated area.

          Values:

          * Protected
          * Hunting
          * Protected and hunting
          * No special status
          * empty if not relevant

          Source: C1(Instructions), p.149, sec.9.1.8

          Years: 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'lc_lu_special_remark',
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

          Source: C1(Instructions), p.149-150, sec.9.1.8

          Years: 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_cando',
        description: |||
          Whether a Copernicus survey can be done on this point.
          For more information on the
          Copernicus module and the data created please refer to
          [d'Andrimont et al, 2021](https://essd.copernicus.org/articles/13/1119/2021/ ).

          Values:

          * true
          * false

          Source: C1(Instructions), p.58, sec.8.8.1, C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc',
        description: |||
          The land cover on the Copernicus points according to the classification scheme at level2.

          Source: Harmonized C3 document

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc_label',
        description: |||
          Label of land cover on the Copernicus points according to the classification scheme at level2.

          Source: Harmonized C3 document
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc1n',
        description: |||
          The extent (in meters) to which the land cover of the Copernicus point stays the same in direction North.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprnc_lc1e',
        description: |||
          The extent (in meters) to which the land cover of the Copernicus point stays the same in direction East.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprnc_lc1s',
        description: |||
          The extent (in meters) to which the land cover of the Copernicus point stays the same in direction South.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprnc_lc1w',
        description: |||
          The extent (in meters) to which the land cover of the Copernicus point stays the same in direction West.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprn_lc1n_brdth',
        description: |||
          The breath (in %) to the next Copernicus land cover in direction North.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprn_lc1e_brdth',
        description: |||
          The breath (in %) to the next Copernicus land cover in direction East.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprn_lc1s_brdth',
        description: |||
          The breath (in %) to the next Copernicus land cover in direction South.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprn_lc1w_brdth',
        description: |||
          The breath (in %) to the next Copernicus land cover in direction West.

          Source: C1(Instructions), p.150, sec.9.1.9

          Years: 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'cprn_lc1n_next',
        description: |||
          The recorded next land cover if a land cover change (LUCAS land cover
          level 2) occurs within 50m in direction North, regardless of the fact that the
          next land cover is visible on the landscape photo or not. Any feature less than
          3m wide is not taken into account and is not considered a land cover change.

          Source: Harmonized C3 document

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc1s_next',
        description: |||
          The recorded next land cover if a land cover change (LUCAS land cover
          level 2) occurs within 50m in direction South, regardless of the fact that the
          next land cover is visible on the landscape photo or not. Any feature less than
          3m wide is not taken into account and is not considered a land cover change.

          Source: Harmonized C3 document

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc1e_next',
        description: |||
          The recorded next land cover if a land cover change (LUCAS land cover
          level 2) occurs within 50m in direction East, regardless of the fact that the
          next land cover is visible on the landscape photo or not. Any feature less than
          3m wide is not taken into account and is not considered a land cover change.

          Source: Harmonized C3 document

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_lc1w_next',
        description: |||
          The recorded next land cover if a land cover change (LUCAS land cover
          level 2) occurs within 50m in direction West, regardless of the fact that the
          next land cover is visible on the landscape photo or not. Any feature less than
          3m wide is not taken into account and is not considered a land cover change.

          Source: Harmonized C3 document

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_urban',
        description: |||
          Whether the Copernicus point located in an urban area.

          Values:

          * true
          * false

          Source: C1(Instructions), p.151, sec.9.1.10.1

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'cprn_impervious_perc',
        description: 'Percentage of impervious surfaces.\n\nSource: C1(Instructions), p.151, sec.9.1.10.1\n\nYears: 2018',
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc1',
        description: 'Percentage of coniferous trees.\n\nSource: C1(Instructions), p.151, sec.9.1.10.2\n\nYears: 2015, 2018',
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc2',
        description: 'Percentage of broadleaved trees.\n\nSource: C1(Instructions), p.151, sec.9.1.10.2\n\nYears: 2015, 2018',
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc3',
        description: 'Percentage of shrubs.\n\nSource: C1(Instructions), p.151, sec.9.1.10.2\n\nYears: 2015, 2018',
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc4',
        description: 'Percentage of herbaceous plants.\n\nSource: C1(Instructions), p.151, sec.9.1.10.2\n\nYears: 2015, 2018',
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc5',
        description: 'Percentage of lichens and mosses.\n\nSource: C1(Instructions), p.151, sec.9.1.10.2\n\nYears: 2015, 2018',
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc6',
        description: |||
          Percentage of consolidated (bare) surface (e.g., rock outcrops).

          Source: C1(Instructions), p.151, sec.9.1.10.2

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc7',
        description: |||
          Percentage of unconsolidated (bare) surface (e.g., sand).

          Source: C1(Instructions), p.151, sec.9.1.10.2

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'inspire_plcc8',
        description: |||
          Difference between the sum of all inspire persentage classes and 100%.

          Source: C1(Instructions), p.151, sec.9.1.10.2

          Years: 2015, 2018
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'eunis_complex',
        description: |||
          EUNIS habitat classification.

          Values:

          * X06
          * X09
          * Other
          * Unknown
          * empty if not relevant

          Source: C1(Instructions), p.152, sec.9.1.11

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'grassland_sample',
        description: |||
          Whether the point is a part of the grassland module.

          Values:

          * true
          * false

          Source: C1(Instructions), p.152, sec.9.1.12

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'grass_cando',
        description: |||
          Whether a grassland survey is possible.

          Values:

          * true
          * false

          Source: C1(Instructions), p.152, sec.9.1.12

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'wm',
        description: |||
          Type of water management present at the point.

          Values:

          * Irrigation
          * Potential irrigation
          * Drainage
          * Irrigation and drainage
          * No visible water management
          * empty if not relevant

          Source: C1(Instructions), p.162, sec.9.1.13

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'wm_source',
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

          Combo classes exist only for 2009 and were later discontinued. For more details
          check the documentation.

          Source: C1(Instructions), p.163, sec.9.1.13

          Years: 2009
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'wm_type',
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

          Combo classes exist only for 2009 and were later discontinued. For more details
          check the documentation.

          Source: C1(Instructions), p.162-163, sec.9.1.13

          Years: 2009
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'wm_delivery',
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

          Combo classes exist only for 2009 and were later discontinued. For more details
          check the documentation.

          Source: C1(Instructions), p.163-164, sec.9.1.13

          Years: 2009
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'erosion_cando',
        description: |||
          Whether a point is foreseen for assessing erosion (true) or not (false).

          Values:

          * true
          * false

          Source: C1(Instructions), p.168, sec.9.1.15

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_stones_perc',
        description: |||
          Percentage of stones on the surface (does not include
          stones covered by soil).

          Values:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * > 50 %
          * empty if not relevant

          This coding applies only for the years 2009–2015 . For 2018 the number
          represents the percentage of stones on the surface (0-100). The variable
          does not exist for 2006.

          Source: C1(Instructions), p.164, sec.9.1.14.2

          Years: 2009, 2012, 2015, 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'bio_sample',
        description: 'Whether the point a biodiversity sample point.\n\nValues:\n\n* true\n* false\n\nYears: 2018',
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_bio_taken',
        description: |||
          Whether a soil-biodiversity sample was taken.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'bulk0_10_sample',
        description: |||
          Whether a point is foreseen for collecting the bulk density between the given range.

          Values:

          * false
          * true

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_blk_0_10_taken',
        description: |||
          Whether the soil sample between the given range was taken.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'bulk10_20_sample',
        description: |||
          Whether a point is foreseen for collecting the bulk density between the given range.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_blk_10_20_taken',
        description: |||
          Whether the soil sample between the given range was taken.

          Values:

          * Yes
          * No

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'bulk20_30_sample',
        description: |||
          Whether a point is foreseen for collecting the bulk density between the given range.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_blk_20_30_taken',
        description: |||
          Whether the soil sample between the given range was taken.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'standard_sample',
        description: |||
          Whether the point is a standard soil point.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_std_taken',
        description: |||
          Whether the standard soil sample was taken.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'organic_sample',
        description: |||
          Whether the point is an organic sample point.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_org_depth_cando',
        description: |||
          Whether depth can be evaluated.

          Values:

          * true
          * false

          Source: C1(Instructions)

          Years: 2018
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_taken',
        description: |||
          Has a soil sample been taken (before 2018).

          Values:

          * Yes
          * Not possible
          * No, already taken
          * No sample required
          * empty if not relevant

          Source: C1(Instructions)

          Years: 2009, 2012, 2015
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'soil_crop',
        description: |||
          Percentage of residual crop.

          Values:

          * < 10 %
          * 10 - 25 %
          * 25 - 50 %
          * > 50 %
          * empty if not relevant

          Source: C1(Instructions)

          Years: 2009, 2012, 2015
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_point',
        description: |||
          Whether a photo on the point was taken.

          Values:

          * Photo taken
          * Photo not taken
          * empty if not relevant

          Source: C1(Instructions)

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_north',
        description: |||
          Whether a photo looking north was taken.

          Values:

          * Photo taken
          * Photo not taken
          * empty if not relevant

          Source: C1(Instructions)

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_south',
        description: |||
          Whether a photo looking south was taken.

          Values:

          * Photo taken
          * Photo not taken
          * empty if not relevant

          Source: C1(Instructions)

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_east',
        description: |||
          Whether a photo looking east was taken.

          Values:

          * Photo taken
          * Photo not taken
          * empty if not relevant

          Source: C1(Instructions)

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'photo_west',
        description: |||
          Whether a photo looking west been taken.

          Values:

          * Photo taken
          * Photo not taken
          * empty if not relevant

          Source: C1(Instructions)

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'transect',
        description: 'The changes in land cover as recorded by the east-facing transect line.\n\nYears: 2009, 2012, 2015',
        type: ee_const.var_type.string,
      },
      {
        name: 'revisit',
        description: 'Number of visits to the point throughout the survey years.\n\nSource: Added by harmonization process',
        type: ee_const.var_type.double,
      },
      {
        name: 'th_gps_dist',
        description: |||
          Calculated distance between theoretical and recorded location.

          Source: Added by harmonization process
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'file_path_gisco_north',
        description: |||
          File path to north-facing photo as stored on ESTAT GISCO sever.

          Source: Added by harmonization process

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'file_path_gisco_south',
        description: |||
          File path to south-facing photo as stored on ESTAT GISCO sever.

          Source: Added by harmonization process

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'file_path_gisco_east',
        description: |||
          File path to east-facing photo as stored on ESTAT GISCO sever.

          Source: Added by harmonization process

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'file_path_gisco_west',
        description: |||
          File path to west-facing photo as stored on ESTAT GISCO sever.

          Source: Added by harmonization process

          Years: all
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'file_path_gisco_point',
        description: |||
          File path to point-facing photo as stored on ESTAT GISCO sever.

          Source: Added by harmonization process

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
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    d'Andrimont, R., Yordanov, M., Martinez-Sanchez, L. et al. Harmonised LUCAS
    in-situ land cover and use database for field surveys from 2006 to 2018
    in the European Union. Sci Data 7, 352 (2020).
    [doi:10.1038/s41597-020-00675-z](https://doi.org/10.1038/s41597-020-00675-z)
  |||,
  'gee:terms_of_use': 'Licensed under the Creative Commons Attribution 4.0 International License.',
  'gee:user_uploaded': true,
}
