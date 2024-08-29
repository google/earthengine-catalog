
local id = 'EDF/OGIM/OGIM_v2-4_RF06_RF08';
local successor_id = 'EDF/OGIM/current';
local subdir = 'EDF';
local latest_id = successor_id;
local version = '2.4_RF06_RF08';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local successor_basename = std.strReplace(successor_id, '/', '_');
local latest_basename = std.strReplace(latest_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  id: id,
  title: 'OGIM: Oil and Gas Infrastructure Mapping Database v' + version +
    ' [deprecated]',
  version: version,

  description: |||
    This dataset provides the locations of oil and gas (O&G) related
    infrastructure within two key O&G producing regions in the United States:
    the Delaware sub-basin of the Permian Basin in western Texas and southern
    New Mexico, and the Uinta Basin in Utah.

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

    * oil and gas wells,
    * natural gas compressor stations,
    * gathering and processing facilities,
    * petroleum terminals,
    * oil and gas pipelines,
    * satellite detections of oil and gas flares,
    * and "other" oil and gas related infrastructure, such as metering stations.

    Records in the OGIM are consolidated from numerous publicly-available
    governmental and academic sources, including:

    * [Homeland Infrastructure Foundation-Level Data (HIFLD)](https://hifld-geoplatform.hub.arcgis.com/pages/hifld-open)
    * [EPA Facility Level Information on Greenhouse Gases Tool (FLIGHT)](https://ghgdata.epa.gov/ghgp/main.do)
    * [Texas Railroad Commission (RRC)](https://www.rrc.texas.gov/resource-center/research/data-sets-available-for-download/)
    * [New Mexico Energy Minerals, and Natural Resources Department (EMNRD)](https://ocd-hub-nm-emnrd.hub.arcgis.com/datasets/dd971b8e25c54d1a8ab7c549244cf3cc_0/about)
    * [Utah Geospatial Resource Center (UGRC)](https://gis.utah.gov/data/energy/oil-gas/)
    * [Earth Observation Group (EOG) at the Colorado School of Mines](https://eogdata.mines.edu/products/vnf/global_gas_flare.html)
    * [Marchese et al, 2015](https://doi.org/10.1021/acs.est.5b02275)

    The O&G facilities in this dataset are spatially coincident with the extent
    of MethaneAIR measurements taken on 8 August 2021 (research flight RF06)
    over the Permian Basin and 11 August 2021 (research flight RF08) over the
    Uinta Basin. MethaneAIR is an airborne precursor of the MethaneSAT satellite
    mission, managed by MethaneSAT LLC. Only O&G facilities found within the RF06
    or RF08 region of interest are included in this data release.

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
  extent: ee.extent(-110.3, 31.4, -103.1, 40.6,
                    '2023-11-14T00:00:00Z', '2023-11-14T00:00:00Z'),

  summaries: {

    'gee:schema': [
      {
        name: 'CATEGORY',
        description: |||
          Category of O&G infrastructure to which the facility belongs.

          Values:

          * GATHERING AND PROCESSING
          * NATURAL GAS COMPRESSOR STATION
          * NATURAL GAS FLARING DETECTIONS
          * OIL AND NATURAL GAS WELLS
          * OIL AND NATURAL GAS PIPELINES
          * PETROLEUM TERMINALS
          * STATIONS - OTHER
        |||,
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
        name: 'FAC_TYPE',
        description: 'Detailed information on type of facility.',
        type: ee_const.var_type.string,
      },
      {
        name: 'OGIM_ID',
        description: |||
          Unique identifier for each facility in the geopackage. Values do not
          repeat across infrastructure categories.
        |||,
        type: ee_const.var_type.int,
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
          ID number linking the record to its corresponding original data source.
          For more information, refer to the "Data_Catalog" table in the
          GeoPackage that accompanies [Omara et al (2023)](https://doi.org/10.5194/essd-15-3761-2023).

          Values:

          * 87, 91, 93, 94, 95, and 96 = HIFLD;
          * 89 = EPA FLIGHT;
          * 90 = Marchese et al (2015);
          * 142 = Earth Observation Group;
          * 197 and 217 = TX RRC;
          * 210 = NM EMNRD;
          * 218 = UGRC;
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'STATE_PROV',
        description: |||
          State or province in which the facility resides.

          Values:

          * TEXAS
          * NEW_MEXICO
          * UTAH
          * N/A
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
        lookat: { lon: -103.71, lat: 31.96, zoom: 9 },
        table_visualization: {
          color: 'blue',
          point_size: 2,
          width: 0.5,
        }
      },
      {
        display_name: 'FeatureView visualization of Oil and Gas Infrastructure',
        visualize_as: 'FeatureView',
        lookat: { lon: -103.71, lat: 31.96, zoom: 9 },
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
    ee.link.example(id, subdir, basename + '_FeatureView'),
    ee.link.latest(latest_id, catalog_subdir_url + latest_basename + ".json"),
    ee.link.successor(
      successor_id, catalog_subdir_url + successor_basename + ".json"),
  ],

  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  'gee:status': "deprecated",
}
