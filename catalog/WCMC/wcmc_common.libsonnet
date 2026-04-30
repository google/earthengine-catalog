local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

{
  license: spdx.proprietary,
  citation: |||
    UNEP-WCMC and IUCN (year), Protected Planet: The World Database
    on Protected and Conserved Areas (WDPCA) [On-line], [insert month/year of the
    version used], Cambridge, UK: UNEP-WCMC and IUCN Available at:
    www.protectedplanet.net.
  |||,
  terms_of_use: |||
    Please visit the [full terms and conditions page](https://www.protectedplanet.net/c/terms-and-conditions)
    of Protected Planet. Select highlights below:

    **No Commercial Use.** Neither (a) the WDPCA Materials nor (b) any work
    derived from or based upon the WDPCA Materials ("Derivative Works")
    may be put to Commercial Use without the prior written permission
    of UNEP-WCMC. "Commercial Use" means a) any use by, on behalf
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
    WDPCA Materials in any derived form or format.
  |||,
  unusual_terms_of_use: true,
  wdoecm_description: |||
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
  wdpa_description: |||
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
  wdpca_description: |||
    The World Database on Protected and Conserved Areas (WDPCA) is the most
    comprehensive global database on terrestrial, inland water, coastal and
    marine protected areas and other effective area-based conservation measures
    (OECMs). The WDPCA is a joint product of the United Nations Environment
    Programme (UNEP) and the International Union for Conservation of Nature
    (IUCN), managed by UNEP World Conservation Monitoring Centre (UNEP-WCMC).
    Data for the WDPCA is collected from international convention secretariats,
    governments, non-state actors and collaborating non-governmental
    organisations. To be included in the WDPCA, sites must align with the IUCN
    or Convention on Biological Diversity's definition of a protected area, or
    the CBD definition of an OECM.

    The WDPCA has two feature classes with associated spatial and tabular
    data. The WDPCA is an important evolution in the way Protected Planet
    brings together and makes data available to the world. Its launch reflects
    the fact that many countries are diversifying their conservation strategies,
    increasingly seeing protected areas and OECMs (a type of 'conserved area')
    as two complementary approaches. In addition to streamlining reporting, the
    merge of the databases will drive more informed data analysis and decision
    making.

    Protected Area data and information in the WDPCA underpin the publication
    of the United Nations List of Protected Areas.

    The compilation and management of these databases is carried out by
    UNEP-WCMC, in collaboration with governments, non-governmental
    organisations, academia and industry. Data is sourced from almost 500 data
    providers in 245 countries and territories. These include governments,
    international secretariates, regional entities, NGOs and individuals.

    Please see the [WDPCA catalog page](https://www.ibat-alliance.org/datasets/wdpca)
    for additional details.
  |||,
  providers: function(self_ee_catalog_url) [
    ee.producer_provider('UN Environment World Conservation Monitoring Centre (UNEP-WCMC) / Protected Planet', 'https://www.protectedplanet.net/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  keywords: [
    'boundaries',
    'iucn',
    'marine',
    'mpa',
    'protected',
    'wcmc',
    'wdpa',
    'wdpca',
    'oecm',
    'wdoecm',
  ],
  schema_fields: {
    CONS_OBJ: {
      name: 'CONS_OBJ',
      description: |||
        It refers to the primacy of conservation objectives. The field provides
        an indication of whether an OECM is managed with biodiversity
        conservation as a primary objective, secondary objective, or without
        conservation as an explicit objective.
      |||,
      type: ee_const.var_type.string,
    },
    DESIG: {
      name: 'DESIG',
      description: |||
        Designation of the protected area or OECM in the native language,
        provided by the data provider.
      |||,
      type: ee_const.var_type.string,
    },
    DESIG_ENG: {
      name: 'DESIG_ENG',
      description: |||
        Designation of the protected area or OECM in English. If the original
        language is English, this field will contain the same value as DESIG.
        No fixed values for national-level designations.
      |||,
      type: ee_const.var_type.string,
    },
    DESIG_TYPE: {
      name: 'DESIG_TYPE',
      description: |||
        Designation type, categorized as National, Regional, International,
        or Not Applicable.
      |||,
      type: ee_const.var_type.string,
    },
    GIS_AREA: {
      name: 'GIS_AREA',
      description: |||
        Site total extent, including both marine
        (if applicable) and terrestrial areas, in square kilometers calculated
        by UNEP-WCMC projecting the site polygon in the standard
        Mollweide projection and using GIS software tools.
      |||,
      type: ee_const.var_type.double,
    },
    GIS_M_AREA: {
      name: 'GIS_M_AREA',
      description: |||
        Site marine extent in square kilometers
        calculated by UNEP-WCMC projecting the site polygon
        in the standard Mollweide projection and using GIS software tools.
      |||,
      type: ee_const.var_type.double,
    },
    GOV_TYPE: {
      name: 'GOV_TYPE',
      description: |||
        Governance type under which the protected area or OECM operates, such
        as Federal or National Ministry or Agency, Sub-national Ministry or
        Agency, Collaborative governance, etc.
      |||,
      type: ee_const.var_type.string,
    },
    GOVSUBTYPE: {
      name: 'GOVSUBTYPE',
      description: |||
        Governance subtype, alongside the existing governance type (GOV_TYPE)
        field, this field will provide additional transparency on the actors
        involved in shared governance of protected areas and OECMs.
      |||,
      type: ee_const.var_type.string,
    },
    INT_CRIT: {
      name: 'INT_CRIT',
      description: |||
        International criteria used for World Heritage Sites and Ramsar sites,
        assigned by UNEP-WCMC.
      |||,
      type: ee_const.var_type.string,
    },
    ISO3: {
      name: 'ISO3',
      description: |||
        ISO3 Code.
        [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
        of the country or territory where the protected area or OECM is
        located.
      |||,
      type: ee_const.var_type.string,
    },
    IUCN_CAT: {
      name: 'IUCN_CAT',
      description: |||
        IUCN management category classifies protected areas according to their
        management objectives. Categories include Ia (Strict Nature Reserve),
        II (National Park), VI (Protected Area with sustainable use of natural
        resources), etc.
      |||,
      type: ee_const.var_type.string,
    },
    MANG_AUTH: {
      name: 'MANG_AUTH',
      description: |||
        Management authority responsible for managing the protected area or
        OECM.
      |||,
      type: ee_const.var_type.string,
    },
    MANG_PLAN: {
      name: 'MANG_PLAN',
      description: |||
        Indicates whether a management plan exists for the protected area or
        OECM.
      |||,
      type: ee_const.var_type.string,
    },
    MARINE: {
      name: 'MARINE',
      description: |||
        Indicates whether the area is terrestrial or marine. Values: 0 for
        terrestrial, 1 for coastal, and 2 for marine. Essential for
        understanding the nature of the protected area.
      |||,
      type: ee_const.var_type.string,
    },
    METADATAID: {
      name: 'METADATAID',
      description: |||
        Unique identifier for the metadata record associated with the
        protected area or OECM.
      |||,
      type: ee_const.var_type.int,
    },
    NAME: {
      name: 'NAME',
      description: |||
        Legal name or other name assigned to the protected area or OECM in
        Latin characters.
      |||,
      type: ee_const.var_type.string,
    },
    NO_TAKE: {
      name: 'NO_TAKE',
      description: |||
        No-take areas within the protected area or OECM where extractive
        activities are prohibited. Values include All, Part, None, Not
        Reported, and Not Applicable.
      |||,
      type: ee_const.var_type.string,
    },
    NO_TK_AREA: {
      name: 'NO_TK_AREA',
      description: |||
        Area of the no-take zone within the protected area or OECM, measured
        in square kilometers.
      |||,
      type: ee_const.var_type.double,
    },
    ORIG_NAME: {
      name: 'ORIG_NAME',
      description: |||
        Original name of the protected area or OECM in its original language
        or characters.
      |||,
      type: ee_const.var_type.string,
    },
    OWN_TYPE: {
      name: 'OWN_TYPE',
      description: |||
        Ownership type of the land and/or waters within the protected area or
        OECM. Accepted values include State, Communal, Individual landowners,
        For-profit organizations, etc.
      |||,
      type: ee_const.var_type.string,
    },
    PARENT_ISO3: {
      name: 'PARENT_ISO3',
      description: |||
        Parent ISO3 code.
        [ISO 3166-3 character code](https://en.wikipedia.org/wiki/ISO_3166-3)
        of the parent country if the protected area or OECM spans multiple
        countries.
      |||,
      type: ee_const.var_type.string,
    },
    PRNT_ISO3: self.PARENT_ISO3 { name: 'PRNT_ISO3' },
    PA_DEF: {
      name: 'PA_DEF',
      description: |||
        Indicates whether the area meets the IUCN definition of a protected
        area. Values: 1 for yes, 0 for no (stored outside WDPA).
      |||,
      type: ee_const.var_type.string,
    },
    REP_AREA: {
      name: 'REP_AREA',
      description: |||
        The total reported area of the protected area or OECM in square
        kilometers, including both marine (if applicable) and terrestrial
        areas, as specified in the legal text.
      |||,
      type: ee_const.var_type.double,
    },
    REP_M_AREA: {
      name: 'REP_M_AREA',
      description: |||
        Reported marine area in square kilometers within the protected area
        or OECM.
      |||,
      type: ee_const.var_type.double,
    },
    STATUS: {
      name: 'STATUS',
      description: |||
        Current status of the protected area or OECM, such as Proposed,
        Designated, or Established.
      |||,
      type: ee_const.var_type.string,
    },
    STATUS_YR: {
      name: 'STATUS_YR',
      description: |||
        Year when the current status of the protected area or OECM was
        enacted.
      |||,
      type: ee_const.var_type.int,
    },
    SUB_LOC: {
      name: 'SUB_LOC',
      description: |||
        Sub-national location or administrative region where the protected
        area or OECM is situated. If the PA is in more than one region,
        multiple ISO-3166-2 codes can be listed.
      |||,
      type: ee_const.var_type.string,
    },
    SUPP_INFO: {
      name: 'SUPP_INFO',
      description: |||
        Supplementary information supporting the categorization of the site
        as an OECM.
      |||,
      type: ee_const.var_type.string,
    },
    VERIF: {
      name: 'VERIF',
      description: |||
        Verification status of the data, indicating whether it has been
        verified by state authorities or other recognized entities. Values:
        State Verified, Expert Verified, or Not Reported.
      |||,
      type: ee_const.var_type.string,
    },
    WDPAID: {
      name: 'WDPAID',
      description: |||
        Unique identifier for a protected area (PA), assigned by UNEP-WCMC.
      |||,
      type: ee_const.var_type.double,
    },
    WDPA_PID: {
      name: 'WDPA_PID',
      description: |||
        Unique identifier for parcels or zones within a PA, assigned by
        UNEP-WCMC.
      |||,
      type: ee_const.var_type.string,
    },
    NAME_ENG: {
      name: 'NAME_ENG',
      description: |||
        Name of the site in English. If the original name is not in English,
        this field contains the English translation or transliteration.
      |||,
      type: ee_const.var_type.string,
    },
    REALM: {
      name: 'REALM',
      description: |||
        The biogeographical realm or environmental domain of the site. Common
        values include "Terrestrial", "Marine", or "Coastal".
      |||,
      type: ee_const.var_type.string,
    },
    OWNSUBTYPE: {
      name: 'OWNSUBTYPE',
      description: |||
        Ownership subtype. Provides additional details on the actors involved
        in shared ownership, complementing the OWN_TYPE field.
      |||,
      type: ee_const.var_type.string,
    },
    SITE_ID: {
      name: 'SITE_ID',
      description: |||
        Global unique identifier for the site (formerly WDPAID). This ID
        persists over time for the same protected area or OECM.
      |||,
      type: ee_const.var_type.double,
    },
    SITE_PID: {
      name: 'SITE_PID',
      description: |||
        Unique identifier for a specific parcel or zone within the
        site (formerly WDPA_PID). Used to distinguish multiple polygons that
        make up a single site.
      |||,
      type: ee_const.var_type.string,
    },
    SITE_TYPE: {
      name: 'SITE_TYPE',
      description: |||
        Type of designation. Distinguishes between "Protected Area" (PA)
        and "Other Effective area-based Conservation Measure" (OECM).
      |||,
      type: ee_const.var_type.string,
    },
    INLND_WTRS: {
      name: 'INLND_WTRS',
      description: |||
        Inland waters. Indicates whether conservation measures are in place for
        inland water ecosystems that occur within the site.
      |||,
      type: ee_const.var_type.string,
    },
    OECM_ASMT: {
      name: 'OECM_ASMT',
      description: |||
        OECM assessment. Describes the type of assessment used to verify that
        the site meets the definition of an OECM.
      |||,
      type: ee_const.var_type.string,
    },
  },
}
