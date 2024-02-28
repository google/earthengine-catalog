local id = 'GOOGLE/AirView/California_Unified_2015_2019';
local subdir = 'GOOGLE';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_nc_4_0;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

local overrange_description = |||
  Boolean flag indicating the measured value was higher than the
  operating range of the instrument's specification. This field can
  be empty.
|||;
{
  'gee:skip_featureview_generation': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Google Street View Air Quality: High Resolution Air Pollution Mapping in California',
  version: version,
  'gee:type': ee_const.gee_type.table,
  description: |||
    This large vector dataset contains high resolution air pollution mapping of
    NO, NO2, O3, CH4, CO2, BC, PN2.5, and UFP concentrations in California
    between June 2015 and June 2019.

    The dataset consists of measurements collected using four Google Street View
    vehicles equipped with the Aclima mobile measurement and data integration
    platform from 2015-05-28 to 2019-06-07.  Not all four cars were actively
    mapping over the entire time frame.  Note that there may be gaps in the data
    when an individual car was not mapping due to operational, mechanical, or
    system difficulties.

    Dates of operation for each of the four cars:

    * Car A: 2016-05-03 - 2019-04-30
    * Car B: 2016-05-03 - 2018-06-08
    * Car C: 2015-05-28 - 2019-06-07
    * Car D: 2015-06-24 - 2018-11-05

    Data was collected in several geographic regions of California including the
    San Francisco Bay Area, Los Angeles, and the northern San Joaquin Valley.
    Mapping occurred in targeted neighborhoods or cities within these regions. 
    The data set contains a table titled "California_Unified_2015_2019" which
    consists of the concentration of the pollutants Ozone (O3), Nitrogen Dioxide
    (NO2), Nitrogen Monoxide (NO), Methane (CH4), Carbon Dioxide (CO2),
    Black Carbon (BC), particle number less than 2.5 micrometers in size
    (PN2.5), and Ultrafine Particles (UFP)  measured using four Google Street
    View cars equipped with fast time-response, laboratory-grade instruments.
    The data was collected at 1-Hz time resolution from 20150528 to 20190607 for
    roads in three regions of California - the San Francisco Bay area,
    Los Angeles, and the northern San Joaquin Valley.  Specific areas mapped
    varied by region based on desired spatial data coverage and science
    questions.  Each data point is geolocated with latitude and longitude as
    well as the identity and speed of the car.

    For details including methodologies, standards, data providers,
    metadata field definitions and descriptions, refer to the
    [metadata](https://docs.google.com/document/d/1If15JccoJcN01Jg3ljN3V-qUFS0HywKAd4OsQ-_JXJo/view).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'air_quality',
    'nitrogen_dioxide',
    'pollution',
  ],
  providers: [
    ee.producer_provider('Google / Aclima', 'https://medium.com/google-earth/powering-new-research-with-hyperlocal-air-pollution-data-c9947359e87e'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2015-05-28T00:00:00Z', '2019-06-07T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'BC',
        description: 'Black carbon concentration',
        type: ee_const.var_type.double,
        units: units.mg_per_sq_m,
      },
      {
        name: 'CH4',
        description: 'Methane dry air mixing ratio',
        type: ee_const.var_type.double,
        units: units.ppm,
      },
      {
        name: 'CO2',
        description: 'Carbon dioxide mixing ratio',
        type: ee_const.var_type.double,
        units: units.ppm,
      },
      {
        name: 'Car_Identifier',
        description: 'Unique identifier for the four vehicles (Car_A/B/C/D)',
        type: ee_const.var_type.string,
      },
      {
        name: 'Car_Speed',
        description: 'Car speed',
        type: ee_const.var_type.double,
        units: units.velocity_si,
      },
      {
        name: 'Date_Time',
        description: 'Time in UTC, format YYYY-MM-DD hh:mm:ss',
        type: ee_const.var_type.string,
      },
      {
        name: 'Metadata_Link',
        description: ' Link to the document',
        type: ee_const.var_type.string,
      },
      {
        name: 'NO',
        description: 'Nitrogen monoxide mixing ratio',
        type: ee_const.var_type.double,
        units: units.ppb,
      },
      {
        name: 'NO2',
        description: 'Nitrogen dioxide mixing ratio',
        type: ee_const.var_type.double,
        units: units.ppb,
      },
      {
        name: 'NO2_Overrange',
        description: overrange_description,
        type: ee_const.var_type.string,
      },
      {
        name: 'NO_Overrange',
        description: overrange_description,
        type: ee_const.var_type.string,
      },
      {
        name: 'O3',
        description: 'Ozone mixing ratio',
        type: ee_const.var_type.double,
        units: units.ppb,
      },
      {
        name: 'PN1',
        description: 'Particle number concentration between 0.3 and 0.5 &mu;m',
        type: ee_const.var_type.double,
        units: units.count,
      },
      {
        name: 'PN2',
        description: 'Particle number concentration between 0.5 and 0.7 &mu;m',
        type: ee_const.var_type.double,
        units: units.count,
      },
      {
        name: 'PN3',
        description: 'Particle number concentration between 0.7 and 1.0 &mu;m',
        type: ee_const.var_type.double,
        units: units.count,
      },
      {
        name: 'PN4',
        description: 'Particle number concentration between 1.0 and 1.5 &mu;m',
        type: ee_const.var_type.double,
        units: units.count,
      },
      {
        name: 'PN5',
        description: 'Particle number concentration between 1.5 and 2.5 &mu;m',
        type: ee_const.var_type.double,
        units: units.count,
      },
      {
        name: 'PN_Overrange',
        description: overrange_description,
        type: ee_const.var_type.string,
      },
      {
        name: 'UFP',
        description: 'Total particle number concentration greater than 3 nm',
        type: ee_const.var_type.double,
        units: units.count,
      },
      {
        name: 'UFP_Overrange',
        description: overrange_description,
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Air Quality',
        lookat: {
          lat: 37.70,
          lon: -122.01,
          zoom: 17,
        },
        table_visualization: {
          color: 'ffffff',
          fill_color: 'ffffff88',
        },
      },
      {
        display_name: 'Air View',
        visualize_as: 'FeatureCollection',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 2500,
      thinning_strategy: 'HIGHER_DENSITY',
    },
  },
  'sci:citation': |||
    Attribution: Every instance where the data is used must include a notice
    with the text "Air Quality Data from Google and Aclima"

    Citation for publications: Google and Aclima 2019: Project Air View California 2015-2019
  |||,
  'gee:terms_of_use': ee.gee_terms_of_use(license),
  'gee:unusual_terms_of_use': true,
  'gee:user_uploaded': true,
}
