local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local license = spdx.cc_by_4_0;

local units = import 'units.libsonnet';

{
  description: |||
    European primary forest data harmonizes 48 different, mostly field-based
    datasets of primary forests, and contains 18,411 individual patches
    (41.1 Mha) spread across 33 countries. It includes includes mainly
    old-growth, late-successional forests, but also some early seral stages
    and young forests that originated after natural disturbances and natural
    regeneration, without subsequent management.

    For more information, including a complete list of authors and their
    affiliations, please see the
    [dataset documentation](https://www.nature.com/articles/s41597-021-00988-7)
  |||,
  keywords: [
    'europe',
    'forest',
  ],
  providers(name, catalog_url): [
    ee.producer_provider(
      'Geography Department, Humboldt University of Berlin, Berlin, Germany',
      'https://www.geographie.hu-berlin.de/en/geography_department'),
    ee.host_provider(catalog_url),
  ],
  license: license.id,
  extent: ee.extent_global('2000-01-01T01:00:00Z', '2019-12-31T16:45:00Z'),
  citation: |||
    Sabatini, F.M., Bluhm, H., Kun, Z. et al. European primary forest database v2.0.
    Sci Data 8, 220 (2021).
    [https://doi.org/10.1038/s41597-021-00988-7](https://doi.org/10.1038/s41597-021-00988-7)
  |||,
  regular_bands: [
      {
        name: 'BIOGEOGRAP',
        description: |||
          Biogeographical region is defined by the European Environmental Agency,
          one of: Alpine, Arctic, Atlantic, Black Sea, Boreal, Continental,
          Macaronesia, Mediterranean, Pannonian, or Steppic.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'CONTACT_PE',
        description: 'Contact person',
        type: ee_const.var_type.string,
      },
      {
        name: 'DOMINANT_1',
        description: |||
          Species (latin name) of the dominant tree species of the overstorey
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DOMINANT_2',
        description: |||
          Species (latin name) of the second dominant tree species of the
          overstorey (if any)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'DOMINANT_T',
        description: |||
          Species (latin name) of the third dominant tree species of the overstorey
          (if any)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'FOREST_NAM',
        description: |||
          Name of the forest stand (if applicable, otherwise can be name of the
          wider area)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'FOREST_SHA',
        description: |||
          Actual share of the polygon covered by forest, assuming that primary
          forests in high naturalness classes, and having a large extent, may
          encompass land temporarily or permanently not covered by forest.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'FOREST_TYP',
        description: |||
          Main forest type according to the forest categories defined by the
          European Environmental Agency, based on the map of Potential Vegetation
          type for Europe. Possible values:

          * 1: Boreal
          * 2: Hemiboreal-nemoral
          * 3: Alpine coniferous
          * 4: Acidophilus oak-birch
          * 5: Mesophytic deciduous
          * 6: Lowland beech
          * 7: Montane beech
          * 8: Thermophilus deciduous
          * 9: Broadleaved evergreen
          * 10: Coniferous Mediterranean
          * 11: Mire and swamp
          * 12: Floodplain
          * 13: Non-riverine Alder-birch-aspen
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'FOREST_T_1',
        description: |||
          Second main forest type according to the forest categories defined by the
          European Environmental Agency, based on the map of Potential Vegetation
          types for Europe
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'ID_Dataset',
        description: 'ID of the data set',
        type: ee_const.var_type.string,
      },
      {
        name: 'LAST_DISTU',
        description: |||
          LAST_DISTURBANCE1_TYPE, type of the last disturbance event. Possible
          values:

          * 1: Fire
          * 2: Windthrow
          * 3: Flood
          * 4: Landslide Avalanche
          * 5: Logging/harvesting
          * 6: Diseases/insect outbreak
          * 7: OTHER natural
          * 8: OTHER anthropogenic
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'LAST_DIS_1',
        description: |||
          LAST_DISTURBANCE1_YEAR, year when disturbance event 1 happened
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'LAST_DIS_2',
        description: |||
          LAST_DISTURBANCE1_INTENSITY, intensity of disturbance event 1. Possible
          values:

          * 1: Light (<20% of the stand disturbed)
          * 2: Moderate (20-70% of the stand disturbed)
          * 3: Stand replacing (>70% of the stand disturbed)
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'LAST_DIS_3',
        description: |||
          LAST_DISTURBANCE2_TYPE, type of the penultimate disturbance event
          Possible values:

          * 1: Fire
          * 2: Windthrow
          * 3: Flood
          * 4: Landslide Avalanche
          * 5: Logging/harvesting
          * 6: Diseases/insect outbreak
          * 7: OTHER natural
          * 8: OTHER anthropogenic
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'LAST_DIS_4',
        description: |||
          LAST_DISTURBANCE2_YEAR, year when disturbance event 2 happened
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'LAST_DIS_5',
        description: |||
          LAST_DISTURBANCE2_INTENSITY, intensity of disturbance event 2. Possible
          values:

          * 1: Light (<20% of the stand disturbed)
          * 2: Moderate (20-70% of the stand disturbed)
          * 3: Stand replacing (>70% of the stand disturbed)
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'LOCATION',
        description: |||
          Municipality, Protected Area, or Region in which the primary forest
          remnant is located
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'NATURALNES',
        description: |||
          Naturalness level of the primary forest remnant: Possible values:

          * 10: n10 - Primeval Forest
          * 9: n9 - Virgin Forest
          * 8: n8 - Frontier Forest
          * 7: n7 - Near-virgin Forest
          * 6: n6 - Old-growth Forest
          * 5: n5 - Long Untouched Forest
          * 0: UNKNOWN
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'Notes',
        description: 'Optional additional remarks to the forest points/polygon',
        type: ee_const.var_type.string,
      },
      {
        name: 'OBJECTID',
        description: 'Object ID',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROTECTION',
        description: |||
          Legal protection status of the forest stand as derived from the World
          Database of Protected. The original IUCN classification was simplified to
          three classes:

          * Strictly protected (IUCN category I);
          * Protected (IUCN categories II-VI + not classified);
          * Not protected.

          In case more updated/precise information was available from our data
          contributors, these were given priority. Possible values:

          * 0: Not protected
          * 1: Protected
          * 2: Strictly protected
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'RELEVANT_L',
        description: |||
          Any relevant sources of information describing the forest remnant
          (including journal articles, local reports and websites)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'Source',
        description: |||
          Directly attributable source/ownership attribution of the forest remnant
          data
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'THREATS_1',
        description: |||
          Threat (if any) that is most likely to endanger the primary forest
          remnant. Possible values:

          * 1: Plantation development
          * 2: Anthropogenic Fires
          * 3: Tourism/recreation
          * 4: Infrastructure development (including touristic)
          * 5: Mismanagement
          * 6: Illegal logging
          * 7: Timber and fuelwood extraction
          * 8: Non-Timber Forest Products extraction
          * 9: Urbanization and housing construction
          * 10: Climate change
          * 11: Biodiversity loss
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'THREATS_2',
        description: |||
          Threat (if any) that is most likely to endanger the primary forest
          remnant.
        |||,
        type: ee_const.var_type.int,
      }
  ],
  terms_of_use: |||
    European primary forest datasets are provided under the CC BY 4.0
    license, which allows for most commmercial, noncommercial, and academic
    uses. See [provider terms of use](https://www.nature.com/articles/s41597-021-00988-7#Tab3:~:text=Full%20size%20table-,Rights%20and%20permissions,-Open%20Access%20This).
  |||,
}
