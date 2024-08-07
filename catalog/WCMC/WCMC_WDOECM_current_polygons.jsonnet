local id = 'WCMC/WDOECM/current/polygons';
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
  title: 'WDOECM: Other Effective Area-based Conservation Measures (polygons)',
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
          It refers to the primacy of conservation objectives. The field
          provides an indication of whether an OECM is managed with biodiversity
          conservation as a primary objective, secondary objective, or without
          conservation as an explicit objective.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG',
        description: 'Designation of the OECMs in the native language.',
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
          Designation type, one of: national, regional, international, or not
          applicable
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GIS_AREA',
        description: |||
          Protected area total extent, including both marine
          (if applicable) and terrestrial areas, in square kilometers calculated
          by UNEP-WCMC projecting the protected area polygon in the standard
          Mollweide projection and using GIS software tools.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GIS_M_AREA',
        description: |||
          Protected area marine extent in square kilometers
          calculated by UNEP-WCMC projecting the protected area polygon
          in the standard Mollweide projection and using GIS software tools.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'GOV_TYPE',
        description: |||
          Description of the decision-making structure of
          a PA. One of: federal or national ministry or agency, sub-national
          ministry or agency, government-delegated management, transboundary
          governance, collaborative governance, joint governance, individual
          landowners, non-profit organizations, for-profit organizations,
          indigenous peoples, local communities, or not reported.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'INT_CRIT',
        description: |||
          International criteria, assigned by UNEP-WCMC. For World Heritage and
          Ramsar sites only.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ISO3',
        description: |||
          ISO3 Code. [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
          of the country or territory where the OECM is located.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'IUCN_CAT',
        description: |||
          IUCN management category, one of: Ia (strict nature
          reserve), Ib (wilderness area), II (national park), III (natural
          monument or feature), IV (habitat/species management area),
          V (protected landscape/seascape), VI (PA with sustainable use
          of natural resources), not applicable, not assigned, or not
          reported.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MANG_AUTH',
        description: |||
          Management authority. Agency, organization, individual or group that
          manages the OECM.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MANG_PLAN',
        description: 'Link or reference to the PAs management plan.',
        type: ee_const.var_type.string,
      },
      {
        name: 'MARINE',
        description: |||
          This field describes whether a PA falls totally
          or partially within the marine environment, one of: 0 (100%
          terrestrial PA), 1 (coastal: marine and terrestrial PA), or
          2 (100% marine PA).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'METADATAID',
        description: |||
          Metadata ID, assigned by UNEP-WCMC. Link to WDPA source table.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'NAME',
        description: 'Name of the OECM as provided by the data provider.',
        type: ee_const.var_type.string,
      },
      {
        name: 'NO_TAKE',
        description: |||
          No take means that the taking of living or dead
          natural resources, inclusive of all methods of fishing, extraction,
          dumping, dredging and construction, is strictly prohibited
          in all or part of a marine PA. This is only applicable to PAs
          where the field marine = 1 or 2. One of: all, part, none, not
          reported, or not applicable (if MARINE field = 0).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NO_TK_AREA',
        description: 'Area of the marine no-take area in square kilometers.',
        type: ee_const.var_type.double,
      },
      {
        name: 'ORIG_NAME',
        description: 'Name of the PA in the original language.',
        type: ee_const.var_type.string,
      },
      {
        name: 'OWN_TYPE',
        description: |||
          Ownership type, one of: state, communal, individual
          landowners, for-profit organizations, non-profit organizations,
          joint ownership, multiple ownership, contested, or not Reported.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PARENT_ISO',
        description: |||
          Parent ISO3 code. [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
          of country where the PA is located.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PA_DEF',
        description: |||
          PA definition. Whether this site meets the IUCN
          and/or CBD definition of a PA: 1=yes, 0=no (currently stored
          outside WDPA).
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'REP_AREA',
        description: |||
          The total OECMs extent, including both marine (if applicable)
          and terrestrial areas, in square kilometers provided by data
          provider as specified in the legal text for the site.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'REP_M_AREA',
        description: |||
          Marine area in square kilometers provided by the data provider.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'STATUS',
        description: |||
          Status of a PA, one of: proposed, inscribed, adopted, designated, or
          established.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'STATUS_YR',
        description: 'Year of enactment of status in the STATUS field.',
        type: ee_const.var_type.int,
      },
      {
        name: 'SUB_LOC',
        description: |||
          Sub-national location. [ISO 3166-2 sub-national
          code](https://en.wikipedia.org/wiki/ISO_3166-2) where the PA
          is located. If the PA is in more than one state, province,
          region etc., multiple ISO-3166-2 codes can be listed separated
          by a comma and space.
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
          Verification status, assigned by UNEP-WCMC. One
          of: state verified, expert verified, not reported (for unverified
          data that was already in the WDPA prior to the inclusion of
          the ''Verification'' field).
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
        display_name: 'Total OECMs extent',
        lookat: {
          lat: 27.33,
          lon: -4.14,
          zoom: 5,
        },
        polygon_visualization: {
          property_name: 'REP_AREA',
          property_vis: {
            min: [
              50000.0,
            ],
            max: [
              800000.0,
            ],
            palette: [
              '2ed033',
              '5aff05',
              '67b9ff',
              '5844ff',
              '0a7618',
              '2c05ff',
            ],
          },
        },
      },
      {
        display_name: 'Total OECMs extent',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 16000,
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
