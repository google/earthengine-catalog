local id = 'JAXA/ALOS/AVNIR-2/ORI';
local subdir = 'JAXA';

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
    ee_const.ext_eo,
  ],
  id: id,
  title: 'ALOS/AVNIR-2 ORI',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset is contains orthorectified imagery from
    the Advanced Visible and Near Infrared Radiometer type 2 (AVNIR-2)
    sensor on-board the Advanced Land Observing Satellite (ALOS) \"DAICHI\".

    The AVNIR-2 ORI product was created from AVNIR-2 1B1 data after stereo
    matching with reference to ALOS's Panchromatic Remote-sensing Instrument
    for Stereo Mapping (PRISM)-derived DSM AW3D30. The orthorectification
    process used AW3D30 DSM data when available and SRTM (The Shuttle
    Radar Topography Mission) DSM data otherwise.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['satellite-imagery'],
  keywords: [
    'alos',
    'avnir_2',
    'eorc',
    'jaxa',
    'orthophoto',
    'visible',
  ],
  providers: [
    ee.producer_provider(
      'JAXA Earth Observation Research Center',
      'https://www.eorc.jaxa.jp/ALOS/en/dataset/ori_e.htm'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(127.05, 23.81, 154.41, 46.04,
                    '2006-04-26T00:00:00Z', '2011-04-18T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'CENTER_ALTITUDE',
        description: 'Satellite alitutude at scene center (km)',
        type: ee_const.var_type.double,
      },
      {
        name: 'CENTER_FRAME_NUMBER',
        description: 'Frame number of scene center (0000 to 7198)',
        type: ee_const.var_type.double,
      },
      {
        name: 'CENTER_HEADING_ANGLE',
        description: 'Satellite heading angle including Earth rotation at scene center (radians)',
        type: ee_const.var_type.double,
      },
      {
        name: 'CENTER_SKEW_ANGLE',
        description: 'Image skew angle at scene center (milli-radians)',
        type: ee_const.var_type.double,
      },
      {
        name: 'CENTER_SOLAR_AZIMUTH',
        description: 'Azimuth angle of the sun at scene center (°)',
        type: ee_const.var_type.double,
      },
      {
        name: 'CENTER_SOLAR_ZENITH',
        description: 'Solar elevation (zenith) angle of the sun at scene center (°)',
        type: ee_const.var_type.double,
      },
      {
        name: 'CENTER_START_TIME',
        description: 'Scene center time (UTC).',
        type: ee_const.var_type.string,
      },
      {
        name: 'INCIDENT_ANGLE',
        description: 'Incident angle "SNN.NNN" (S: Incident direction R/L, NN.NNN degrees)',
        type: ee_const.var_type.string,
      },
      {
        name: 'ORBIT_DIRECTION',
        description: 'Orbit direction ("A"/"D": ascending/descending)',
        type: ee_const.var_type.string,
      },
      {
        name: 'ORBIT_INCLINATION',
        description: 'Nominal satellite orbit inclination (°)',
        type: ee_const.var_type.double,
      },
      {
        name: 'ORBIT_CYCLE_PERIOD',
        description: 'Nominal satellite orbit cycle period (min)',
        type: ee_const.var_type.double,
      },
      {
        name: 'ORIENTATION_ANGLE',
        description: 'Angle of the vertical axis of image frame from the map northing axis.',
        type: ee_const.var_type.double,
      },
      {
        name: 'PROCESSING_DATE',
        description: 'Processing date (JST)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_FACILITY',
        description: 'Processing facility.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_SOFTWARE_VESRION',
        description: 'Processing software version.',
        type: ee_const.var_type.string,
      },
      {
        name: 'PROCESSING_TIME',
        description: 'Processing time (JST)',
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_ID',
        description: |||
          Product ID e.g: "ABBBCCDE"

          *  A: Observation mode ("O")
          *  BBB: Processing level ("ORI")
          *  CC: Framing ("RF" Geo-reference, "GT", Geo-coded True-north
          "GM", Geo-coded Map-north),
          *  D: Map projection ("U": UTM, "P": PS)
          *  E: Sensor type ("N": nadir 35km, "F": forward 35km
          "B": backward 35km "W": nadir 70km)
          *  A: AVNIR-2
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'PRODUCT_NUMBER',
        description: 'Product version number',
        type: ee_const.var_type.double,
      },
      {
        name: 'RSP_ID',
        description: |||
          RSP ID e.g: "MPPPFFFFSN"

          *  M: Oribit direction ("A": ascending, "D": descending)
          *  PPP: RSP path number (0 to 671)
          *  FFFF: RSP frame number (0000 to 7199)
          *  SN: Scene shift ("-2" to " 2")
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SATELLITE_NAME',
        description: 'Satellite name.',
        type: ee_const.var_type.string,
      },
      {
        name: 'SCENE_ID',
        description: |||
          Scene ID e.g. "AABBBCDDDDDEEEE"

          *  AA: Satellite code ("AL": ALOS)
          *  BBB: Sensor code ("PSM": PRISM, "AV2": AVNIR-2)
          *  C: Sensor type ("N": nadir 35km, "F": forward 35km,
          "B": backward 35km "W": nadir 70km, "A": AVNIR-2)
          *  DDDDD: Total orbit number of scene center ("00001" to "99999")
          *  EEEE: Frame number of scene center, including scene shift
          ("0000" to "7199")
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR_CODE',
        description: 'Sensor code ("PSM": PRISM, "AV2": AVNIR-2)',
        type: ee_const.var_type.string,
      },
      {
        name: 'SENSOR_TYPE',
        description: 'Sensor type ("N": nadir 35km, "F": forward 35km, "B": backward 35km "W": nadir 70km, "A": AVNIR-2)',
        type: ee_const.var_type.string,
      },
      {
        name: 'TOTAL_ORBIT_NUMBER',
        description: 'Total orbit number of scene center.',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      10.0,
    ],
    'eo:bands': [
      {
        name: 'B1',
        description: 'Blue (0.42 - 0.50 &mu;m)',
      },
      {
        name: 'B2',
        description: 'Green (0.52 - 0.60 &mu;m)',
      },
      {
        name: 'B3',
        description: 'Red (0.61 - 0.69 &mu;m)',
      },
      {
        name: 'B4',
        description: 'Near-Infrared (0.76 - 0.89 &mu;m)',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'AVNIR-2 ORI RGB',
        lookat: {
          lat: 35.3641,
          lon: 138.7302,
          zoom: 12,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              255.0,
            ],
            bands: [
              'B3',
              'B2',
              'B1',
            ],
          },
        },
      },
    ],
    B1: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': true,
    },
    B2: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': true,
    },
    B3: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': true,
    },
    B4: {
      minimum: 1.0,
      maximum: 255.0,
      'gee:estimated_range': true,
    },
  },
  'gee:terms_of_use': |||
    The Japan Aerospace Exploration Agency (JAXA) releases the ALOS
    Orthorectified Image Product (ALOS-ORI) free of charge and open
    to the public with the following conditions:

    *  When you provide or publish any products or services to a
    third party using this dataset, you are kindly requested to display
    that the original data is provided by JAXA.
    *  When you publish your product(s) using this dataset, you are
    kindly requested to show the copyright (© JAXA) and the source
    of the data.
    *  JAXA does not guarantee the quality and reliability of this
    dataset and JAXA assume no responsibility whatsoever for any direct
    or indirect damage and loss caused by use of this dataset. Also,
    JAXA will not be responsible for any damages of users due to changing,
    deleting or terminating the provision of this dataset.
  |||,
}
