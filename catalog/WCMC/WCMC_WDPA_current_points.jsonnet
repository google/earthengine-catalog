local id = 'WCMC/WDPA/current/points';
local subdir = 'WCMC';

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
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WDPA: World Database on Protected Areas (points)',
  version: 'June 2020',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The World Database on Protected Areas (WDPA) is the
    most up-to-date and complete source of information on protected
    areas, updated monthly with submissions from governments, non-governmental
    organizations, landowners, and communities. It is managed by
    the United Nations Environment Programme's World Conservation
    Monitoring Centre (UNEP-WCMC) with support from IUCN and its
    World Commission on Protected Areas (WCPA).

    **WDPA User Manual.** For details including methodologies,standards, data
    providers, metadata field definitions and descriptions, refer
    to the [WDPA User Manual](https://pp-import-production.s3.amazonaws.com/WDPA_Manual_1_5.pdf).

    The WDPA has two feature classes with associated spatial
    and tabular data on more than 200k protected areas. About 91%
    contain polygon boundaries, with the remaining only as points,
    representing the center of the protected area as much as possible.

    **Asset Naming Conventions.** WCMC updates the WDPA on a
    monthly basis. The most recent version is always available as
    WCMC/WDPA/current/polygons and WCMC/WDPA/current/points. Historical
    versions, starting with July 2017, are available in the format
    WCMC/WDPA/YYYYMM/polygons and WCMC/WDPA/YYYYMM/points.

    Please see the [WDPA User Manual](https://pp-import-production.s3.amazonaws.com/WDPA_Manual_1_5.pdf)
    for additional details on the field list.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, basename + '_FeatureView'),
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
  extent: ee.extent_global('2017-07-01T00:00:00Z', '2030-01-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'WDPAID',
        description: 'Unique identifier for a protected area (PA), assigned by UNEP-WCMC.',
        type: ee_const.var_type.double,
      },
      {
        name: 'WDPA_PID',
        description: 'Unique identifier for parcels or zones within a PA, assigned by UNEP-WCMC.',
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
        name: 'NAME',
        description: 'Name of the PA as provided by the data provider.',
        type: ee_const.var_type.string,
      },
      {
        name: 'ORIG_NAME',
        description: 'Name of the PA in the original language.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG',
        description: 'Designation of the PA in the native language.',
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG_ENG',
        description: |||
          Designation of the PA in English. Allowed values
          for international-level designations: Ramsar Site, Wetland
          of International Importance; UNESCO-MAB Biosphere Reserve;
          or World Heritage Site. Allowed values for regional-level designations:
          Baltic Sea Protected Area (HELCOM), Specially Protected Area
          (Cartagena Convention), Marine Protected Area (CCAMLR), Marine
          Protected Area (OSPAR), Site of Community Importance (Habitats
          Directive), Special Protection Area (Birds Directive), or Specially
          Protected Areas of Mediterranean Importance (Barcelona Convention).
          No fixed values for PAs designated at a national level.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DESIG_TYPE',
        description: 'Designation type, one of: national, regional, international, or not applicable',
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
        name: 'INT_CRIT',
        description: 'International criteria, assigned by UNEP-WCMC. For World Heritage and Ramsar sites only.',
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
        name: 'REP_M_AREA',
        description: 'Marine area in square kilometers provided by the data provider.',
        type: ee_const.var_type.double,
      },
      {
        name: 'REP_AREA',
        description: |||
          The total PA extent, including both marine (if applicable)
          and terrestrial areas, in square kilometers provided by data
          provider as specified in the legal text for the site.
        |||,
        type: ee_const.var_type.double,
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
        name: 'STATUS',
        description: 'Status of a PA, one of: proposed, inscribed, adopted, designated, or established.',
        type: ee_const.var_type.string,
      },
      {
        name: 'STATUS_YR',
        description: 'Year of enactment of status in the STATUS field.',
        type: ee_const.var_type.int,
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
        name: 'OWN_TYPE',
        description: |||
          Ownership type, one of: state, communal, individual
          landowners, for-profit organizations, non-profit organizations,
          joint ownership, multiple ownership, contested, or not Reported.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'MANG_AUTH',
        description: 'Management authority. Agency, organization, individual or group that manages the PA.',
        type: ee_const.var_type.string,
      },
      {
        name: 'MANG_PLAN',
        description: 'Link or reference to the PAs management plan.',
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
        name: 'METADATAID',
        description: 'Metadata ID, assigned by UNEP-WCMC. Link to WDPA source table.',
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
        name: 'PARENT_ISO',
        description: |||
          Parent ISO3 code. [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
          of country where the PA is located.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'ISO3',
        description: |||
          ISO3 Code. [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
          of the country or territory where the PA is located.
        |||,
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Protected Area Points',
        lookat: {
          lat: 0.88,
          lon: 110.57,
          zoom: 4,
        },
        table_visualization: {
          color: '4285F4',
          point_size: 3,
        },
      },
      {
        display_name: 'Protected Area Points',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 0.88,
          lon: 110.57,
          zoom: 4,
        },
        feature_view_visualization: {
          color: '4285F4',
          point_size: 14,
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
    on Protected Areas (WDPA) [On-line], [insert month/year of the
    version used], Cambridge, UK: UNEP-WCMC and IUCN Available at:
    www.protectedplanet.net.
  |||,
  'gee:terms_of_use': |||
    Please visit the [full terms and conditions page](https://www.protectedplanet.net/c/terms-and-conditions)
    of Protected Planet. Select highlights below:

    **No Commercial Use.** Neither (a) the WDPA Materials nor (b) any work
    derived from or based upon the WDPA Materials (\"Derivative Works\")
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
    WDPA Materials in any derived form or format.
  |||,
  'gee:unusual_terms_of_use': true,
}
