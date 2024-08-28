
local id = 'EDF/OGIM/current';
local subdir = 'EDF';
local version = '2.5.1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'OGIM: Oil and Gas Infrastructure Mapping Database v' + version,
  version: version,

  description: |||
    This dataset provides the locations of oil and gas (O&G) related
    infrastructure globally.

    The Oil and Gas Infrastructure Mapping (OGIM) database is a project
    developed by the Environmental Defense Fund (EDF) and [MethaneSAT LLC](https://www.methanesat.org/),
    a wholly-owned subsidiary of EDF. The primary objective of developing
    a standardized O&G infrastructure database such as OGIM is to support
    MethaneSAT's emission quantification, source characterization, and other
    scientific- or advocacy-relevant analyses of methane emissions from the oil
    and gas sector. The OGIM database is developed based on the acquisition,
    analysis, and quality assurance of publicly available geospatial data
    sources of O&G facilities, which are combined within one standard data
    schema and coordinate reference system.

    This dataset contains the spatial locations of the following types of
    infrastructure assets:

    * oil and natural gas wells,
    * oil and gas pipelines,
    * natural gas compressor stations,
    * gathering and processing facilities,
    * tank batteries,
    * offshore platforms,
    * liquified natural gas (LNG) facilities,
    * crude oil refineries,
    * petroleum terminals,
    * injection and disposal facilities,
    * equipment and component locations,
    * satellite detections of oil and gas flares,
    * and "other" oil and gas related infrastructure, such as metering stations


    Records in the OGIM are consolidated from numerous publicly-available
    governmental and academic sources. This list of sources is available [in the
    OGIM_v2.5.1_Data_Source_References.pdf](https://zenodo.org/records/13259749)
    document. For more information on each source, refer to the "Data_Catalog"
    table that accompanies [Omara et al (2023)](https://doi.org/10.5194/essd-15-3761-2023).

    Important notes about the attributes associated with these facility locations:

    - Missing values (i.e., values missing or not reported by the original data
    source) are handled by assigning "N/A" to string attributes, -999 to
    numerical attributes, and a generic date of "1900-01-01" to date/datetime
    attributes.

    - Facility operator names have not been altered in any way from the original
    source of data and are assumed to be accurate as of the original source's
    publication date.

    For more information about the OGIM database, including methods used in its
    development and key applications of the database, please refer to the recent
    publication by [Omara et al, 2023](https://doi.org/10.5194/essd-15-3761-2023).

    Contact the data provider for more information about the project at this link:
    [https://www.methanesat.org/contact/](https://www.methanesat.org/contact/)

    This dataset will be updated in-place with the new versions.
  |||,

  keywords: [
    'climate',
    'methane',
    'emissions',
    'ghg',
    'edf',
    'methanesat',
    'methaneair',
    // 'oil_and_gas_infrastructure'
  ],
  providers: [
    ee.producer_provider('Environmental Defense Fund - MethaneSAT', 'https://methanesat.org'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2024-05-15T00:00:00Z', '2024-05-15T00:00:00Z'),

  summaries: {

    'gee:schema': [
      {
        name: 'CATEGORY',
        description: |||
          Category of O&G infrastructure to which the facility belongs.

          Values:

          * CRUDE OIL REFINERIES
          * EQUIPMENT AND COMPONENTS
          * INJECTION AND DISPOSAL
          * GATHERING AND PROCESSING
          * LNG FACILITIES
          * NATURAL GAS COMPRESSOR STATION
          * NATURAL GAS FLARING DETECTIONS
          * OFFSHORE PLATFORMS
          * OIL AND NATURAL GAS WELLS
          * OIL AND NATURAL GAS PIPELINES
          * PETROLEUM TERMINALS
          * STATIONS - OTHER
          * TANK BATTERIES
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'OGIM_ID',
        description: |||
          Unique identifier for each facility in the dataset. Values do not
          repeat across infrastructure categories.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'SRC_DATE',
        description: |||
          Original publication date of the data source from which the record was
          acquired, in YYYY-MM-DD format.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SRC_REF_ID',
        description: |||
         ID number(s) linking the record to its corresponding original data
         source(s). To look up the citation for a given SRC_REF_ID value, refer
         to the Data Source Reference list (PDF) here, or the "Data_Catalog"
         table in the GeoPackage that accompanies [Omara et al (2023)](https://doi.org/10.5194/essd-15-3761-2023).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'COUNTRY',
        description: |||
          Country in which the record resides. Where possible, country name
          matches the UN Member State list.

          If features are located in more than one country, COUNTRY field
          contains a comma-separated list of these countries in alphabetical
          order.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'STATE_PROV',
        description: 'State or province in which the facility resides.',
        type: ee_const.var_type.string,
      },
      {
        name: 'FAC_ID',
        description: |||
          Unique ID used by the original source agency to identify the facility.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'FAC_NAME',
        description: 'Name of the facility.',
        type: ee_const.var_type.string,
      },
      {
        name: 'FAC_STATUS',
        description: |||
          Operational status of the infrastructure asset, according to the
          original source e.g. 'ACTIVE'; 'SUSPENDED'; 'TEMPORARILY CLOSED'.

          FAC_STATUS of "N/A" cannot be assumed to mean active or inactive.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'FAC_TYPE',
        description: 'Detailed information on type of facility.',
        type: ee_const.var_type.string,
      },
      {

        name: 'OGIM_STATUS',
        description: |||
          Standardized version of the facility status reported by the original
          data source. The original statuses were binned into one of 12
          categories defined by EDF.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'OPERATOR',
        description: |||
          Name of the facility's operator, according to the original source at
          time of publication.
        |||,
        type: ee_const.var_type.string,
      },
    ],

    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },

    'gee:visualizations': [
      {
        display_name: 'Oil and Gas Infrastructure',
        lookat: { lon: -96, lat: 40, zoom: 4 },
        table_visualization: {
          color: 'purple',
          point_size: 1,
          width: 1,
        }
      },
      {
        display_name: 'FeatureView visualization of Oil and Gas Infrastructure',
        visualize_as: 'FeatureView',
        lookat: { lon: -96, lat: 40, zoom: 4 },
      },
    ],
  },

  'sci:doi': '10.5194/essd-15-3761-2023',
  'sci:citation': |||
    Omara, M., Gautam, R., O'Brien, M., Himmelberger, A., Franco, A.,
    Meisenhelder, K., Hauser, G., Lyon, D., Chulakadaba, A., Miller, C. and
    Franklin, J., 2023. Developing a spatially explicit global oil and gas
    infrastructure database for characterizing methane emission sources at high
    resolution. Earth System Science Data Discussions, 2023, pp.1-35.
    [doi:10.5194/essd-15-3761-2023](https://doi.org/10.5194/essd-15-3761-2023),
  |||,

  'gee:type': ee_const.gee_type.table,
  'gee:user_uploaded': true,
  'gee:terms_of_use': ee.gee_terms_of_use(license),

  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, subdir, basename + '_FeatureView')
  ],

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
