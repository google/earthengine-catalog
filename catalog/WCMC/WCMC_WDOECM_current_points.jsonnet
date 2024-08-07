local id = 'WCMC/WDOECM/current/points';
local subdir = 'WCMC';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WDOECM: Other Effective Area-based Conservation Measures (points)',
  version: 'July 2024',
  'gee:type': ee_const.gee_type.table,
  description: |||
    A geographically defined area other than a Protected Area, which is governed
    and managed in ways that achieve positive and sustained long-term outcomes
    for the in situ conservation of biodiversity, with associated ecosystem
    functions and services and where applicable, cultural, spiritual,
    socio-economic, and other locally relevant values.

    The WDOECM has two feature classes with associated spatial
    and tabular data.
    The World Database on Other Effective Area-based Conservation Measures
    (WDOECM) is a global repository of information on Other Effective
    Area-based Conservation Measures (OECMs). It is managed by the United
    Nations Environment Programme's World Conservation Monitoring Centre
    (UNEP-WCMC) with support from the Convention on Biological Diversity
    (CBD).

    **WDOECM User Manual.** For details including methodologies,standards, data
    providers, metadata field definitions and descriptions, refer
    to the [WDOECM User Manual](https://wdpa.s3-eu-west-1.amazonaws.com/WDPA_Manual/English/WDPA_WDOECM_Manual_1_6.pdf).

    **Asset Naming Conventions.** WCMC updates the WDOECM on a
    monthly basis. The most recent version is always available as
    WCMC/WDOECM/current/polygons and WCMC/WDOECM/current/points. Historical
    versions, starting with May 2024, are available in the format
    WCMC/WDOECM/YYYYMM/polygons and WCMC/WDOECM/YYYYMM/points.

    Please see the [WDOECM User Manual](https://wdpa.s3-eu-west-1.amazonaws.com/WDPA_Manual/English/WDPA_WDOECM_Manual_1_6.pdf)
    for additional details on the field list.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView'),
  ],
  keywords: [
    'boundaries',
    'iucn',
    'marine',
    'mpa',
    'protected',
    'wcmc',
    'wdpa',
  ],
  providers: [
    ee.producer_provider('UN Environment World Conservation Monitoring Centre (UNEP-WCMC) / Protected Planet', 'https://www.protectedplanet.net/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  // TODO(b/229788379): how to represent an ongoing end date?
  extent: ee.extent_global('2024-05-01T00:00:00Z', '2030-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'CONS_OBJ',
        description: |||
          Designation type, categorized as National, Regional,
          International, or Not Applicable.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG',
        description: |||
          Designation of the protected area or OECM in the native language,
          provided by the data provider.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG_ENG',
        description: |||
          Designation of the protected area or OECM in English. If the original
          language is English, this field will contain the same value as DESIG.
          No fixed values for national-level designations.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG_TYPE',
        description: |||
          Designation type, categorized as National, Regional, International,
          or Not Applicable.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GOV_TYPE',
        description: |||
          Governance type under which the protected area or OECM operates, such
          as Federal or National Ministry or Agency, Sub-national Ministry or
          Agency, Collaborative governance, etc.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'INT_CRIT',
        description: |||
          International criteria used for World Heritage Sites and Ramsar sites,
          assigned by UNEP-WCMC.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ISO3',
        description: |||
          ISO3 Code.
          [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
          of the country or territory where the protected area or OECM is
          located.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'IUCN_CAT',
        description: |||
          IUCN management category classifies protected areas according to their
          management objectives. Categories include Ia (Strict Nature Reserve),
          II (National Park), VI (Protected Area with sustainable use of natural
          resources), etc.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MANG_AUTH',
        description: |||
          Management authority responsible for managing the protected area or
          OECM.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MANG_PLAN',
        description: |||
          Indicates whether a management plan exists for the protected area or
          OECM.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MARINE',
        description: |||
          Indicates whether the area is terrestrial or marine. Values: 0 for
          terrestrial, 1 for coastal, and 2 for marine. Essential for
          understanding the nature of the protected area.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'METADATAID',
        description: |||
          Unique identifier for the metadata record associated with the
          protected area or OECM.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'NAME',
        description: |||
          Legal name or other name assigned to the protected area or OECM in
          Latin characters.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NO_TAKE',
        description: |||
          No-take areas within the protected area or OECM where extractive
          activities are prohibited. Values include All, Part, None, Not
          Reported, and Not Applicable.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NO_TK_AREA',
        description: |||
          Area of the no-take zone within the protected area or OECM, measured
          in square kilometers.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'ORIG_NAME',
        description: |||
          Original name of the protected area or OECM in its original language
          or characters.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'OWN_TYPE',
        description: |||
          Ownership type of the land and/or waters within the protected area or
          OECM. Accepted values include State, Communal, Individual landowners,
          For-profit organizations, etc.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PARENT_ISO',
        description: |||
          Parent ISO3 code.
          [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
          of the parent country if the protected area or OECM spans multiple
          countries.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PA_DEF',
        description: |||
          Indicates whether the area meets the IUCN definition of a protected
          area. Values: 1 for yes, 0 for no (stored outside WDPA).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'REP_AREA',
        description: |||
          The total reported area of the protected area or OECM in square
          kilometers, including both marine (if applicable) and terrestrial
          areas, as specified in the legal text.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'REP_M_AREA',
        description: |||
          Reported marine area in square kilometers within the protected area
          or OECM.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'STATUS',
        description: |||
          Current status of the protected area or OECM, such as Proposed,
          Designated, or Established.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'STATUS_YR',
        description: |||
          Year when the current status of the protected area or OECM was
          enacted.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'SUB_LOC',
        description: |||
          Sub-national location or administrative region where the protected
          area or OECM is situated. If the PA is in more than one region,
          multiple ISO-3166-2 codes can be listed.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SUPP_INFO',
        description: |||
          Supplementary information supporting the categorization of the site
          as an OECM.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'VERIF',
        description: |||
          Verification status of the data, indicating whether it has been
          verified by state authorities or other recognized entities. Values:
          State Verified, Expert Verified, or Not Reported.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'WDPAID',
        description: |||
          Unique identifier for a protected area (PA), assigned by UNEP-WCMC.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'WDPA_PID',
        description: |||
          Unique identifier for parcels or zones within a PA, assigned by
          UNEP-WCMC.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'WDOECMs Points',
        lookat: {
          lat: 11.63,
          lon: 124.49,
          zoom: 6,
        },
        table_visualization: {
          color: '0000ff',
          point_size: 6,
        },
      },
      {
        display_name: 'WDOECMs Points',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 11.63,
          lon: 124.49,
          zoom: 6,
        },
        feature_view_visualization: {
          color: '0000FF',
          point_size: 10,
          point_shape: 'hexagon',
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 12000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['REP_AREA DESC'],
      z_order_ranking: ['REP_AREA DESC'],
      prerender_tiles: true,
    },
  },
  'sci:citation': |||
    UNEP-WCMC and IUCN (year), Protected Planet: The World Database
    on OECM Database [On-line], [insert month/year of the
    version used], Cambridge, UK: UNEP-WCMC and IUCN Available at:
    www.protectedplanet.net.
  |||,
  'gee:terms_of_use': |||
    Please visit the [full terms and conditions page](https://www.protectedplanet.net/c/terms-and-conditions)
    of Protected Planet. Select highlights below:

    **No Commercial Use.** Neither (a) the WDOECM Materials nor (b) any work
    derived from or based upon the WDOECM Materials (\"Derivative Works\")
    may be put to Commercial Use without the prior written permission
    of UNEP-WCMC. \"Commercial Use\" means a) any use by, on behalf
    of, or to inform or assist the activities of, a commercial entity
    (an entity that operates 'for profit') or b) use by any individual
    or non-profit entity for the purposes of revenue generation.

    **Disclaimer.** The designations of geographical entities
    in any Data Set do not imply the expression of any view or opinion
    whatsoever on the part of UNEP or WCMC concerning the legal status
    of any country, territory, or area, or of its authorities, or
    concerning the delimitation of its frontiers or boundaries.

    **Attribution.** You must ensure that the citation is always
    clearly reproduced in any publication or analysis involving the
    WDOECM Materials in any derived form or format.
  |||,
  'gee:unusual_terms_of_use': true,
}
