local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';

local subdir = 'COPERNICUS';
local license = spdx.proprietary;

// TODO(b/271332540): After Collection 1 reprocessing, the Feb 2022-Feb 2024
// gap in QA60/MSK_CLASSI bands will be gone, so we will need to remove
// the corresponding text below.

{
  s2_dataset(id, version, version_config)::
    local basename = std.strReplace(id, '/', '_');
    local base_filename = basename + '.json';
    local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
    local parent_url = catalog_subdir_url + 'catalog.json';
    local self_url = catalog_subdir_url + base_filename;

    {
      stac_version: ee_const.stac_version,
      type: 'Collection',
      stac_extensions: [
        ee_const.ext_eo,
        ee_const.ext_ver,
      ],
      id: id,
      version: version,
      title: 'Sentinel-2 MSI: MultiSpectral Instrument, Level-1C',
      'gee:type': ee_const.gee_type.image_collection,
      description: |||
        Sentinel-2 is a wide-swath, high-resolution, multi-spectral
        imaging mission supporting Copernicus Land Monitoring studies,
        including the monitoring of vegetation, soil and water cover,
        as well as observation of inland waterways and coastal areas.

        The Sentinel-2 data contain 13 UINT16 spectral bands representing
        TOA reflectance scaled by 10000. See the [Sentinel-2 User Handbook](https://sentinel.esa.int/documents/247904/685211/Sentinel-2_User_Handbook)
        for details. QA60 is a bitmask band that contained rasterized cloud mask
        polygons until Feb 2022, when these polygons stopped being produced.
        Starting in February 2024, legacy-consistent QA60 bands are constructed from the MSK_CLASSI
        cloud classification bands.
        For more details,
        [see the full explanation of how cloud masks are computed.](https://sentinel.esa.int/web/sentinel/technical-guides/sentinel-2-msi/level-1c/cloud-masks).

        Each Sentinel-2 product (zip archive) may contain multiple
        granules. Each granule becomes a separate Earth Engine asset.
        EE asset ids for Sentinel-2 assets have the following format:
        COPERNICUS/S2/20151128T002653_20151128T102149_T56MNN. Here the
        first numeric part represents the sensing date and time, the
        second numeric part represents the product generation date and
        time, and the final 6-character string is a unique granule identifier
        indicating its UTM grid reference (see [MGRS](https://en.wikipedia.org/wiki/Military_Grid_Reference_System)).

        The Level-2 data produced by ESA can be found in the collection
        [COPERNICUS/S2_SR](COPERNICUS_S2_SR).

        For datasets to assist with cloud and/or cloud shadow detection, see [COPERNICUS/S2_CLOUD_PROBABILITY](COPERNICUS_S2_CLOUD_PROBABILITY)
        and [GOOGLE/CLOUD_SCORE_PLUS/V1/S2_HARMONIZED](GOOGLE_CLOUD_SCORE_PLUS_V1_S2_HARMONIZED).

        For more details on Sentinel-2 radiometric resolution, [see this page](https://sentinel.esa.int/web/sentinel/user-guides/sentinel-2-msi/resolutions/radiometric).
      |||,
      license: license.id,
      links: ee.standardLinks(subdir, id) + version_config.version_links,
      keywords: [
        'copernicus',
        'esa',
        'eu',
        'msi',
        'radiance',
        'sentinel',
      ],
      providers: [
        ee.producer_provider('European Union/ESA/Copernicus', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-2-msi/processing-levels/level-1'),
        ee.host_provider(version_config.ee_catalog_url),
      ],
      extent: ee.extent(-180.0, -56.0, 180.0, 83.0, '2015-06-27T00:00:00Z', null),
      summaries: {
        'gee:schema': [
          {
            name: 'CLOUDY_PIXEL_PERCENTAGE',
            description: 'Granule-specific cloudy pixel percentage taken from the original metadata',
            type: ee_const.var_type.double,
          },
          {
            name: 'CLOUD_COVERAGE_ASSESSMENT',
            description: |||
              Cloudy pixel percentage for the whole archive that
              contains this granule. Taken from the original metadata
            |||,
            type: ee_const.var_type.double,
          },
          {
            name: 'DATASTRIP_ID',
            description: 'Unique identifier of the datastrip Product Data Item (PDI)',
            type: ee_const.var_type.string,
          },
          {
            name: 'DATATAKE_IDENTIFIER',
            description: |||
              Uniquely identifies a given Datatake. The ID contains
              the Sentinel-2 satellite, start date and time, absolute orbit
              number, and processing baseline.
            |||,
            type: ee_const.var_type.string,
          },
          {
            name: 'DATATAKE_TYPE',
            description: 'MSI operation mode',
            type: ee_const.var_type.string,
          },
          {
            name: 'DEGRADED_MSI_DATA_PERCENTAGE',
            description: 'Percentage of degraded MSI and ancillary data',
            type: ee_const.var_type.double,
          },
          {
            name: 'FORMAT_CORRECTNESS',
            description: |||
              Synthesis of the On-Line Quality Control (OLQC) checks
              performed at granule (Product_Syntax) and datastrip (Product
              Syntax and DS_Consistency) levels
            |||,
            type: ee_const.var_type.string,
          },
          {
            name: 'GENERAL_QUALITY',
            description: 'Synthesis of the OLQC checks performed at the datastrip level (Relative_Orbit_Number)',
            type: ee_const.var_type.string,
          },
          {
            name: 'GENERATION_TIME',
            description: 'Product generation time',
            type: ee_const.var_type.double,
          },
          {
            name: 'GEOMETRIC_QUALITY',
            description: 'Synthesis of the OLQC checks performed at the datastrip level (Attitude_Quality_Indicator)',
            type: ee_const.var_type.string,
          },
          {
            name: 'GRANULE_ID',
            description: 'Unique identifier of the granule PDI (PDI_ID)',
            type: ee_const.var_type.string,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B1',
            description: 'Mean value containing viewing incidence azimuth angle average for band B1 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B2',
            description: 'Mean value containing viewing incidence azimuth angle average for band B2 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B3',
            description: 'Mean value containing viewing incidence azimuth angle average for band B3 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B4',
            description: 'Mean value containing viewing incidence azimuth angle average for band B4 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B5',
            description: 'Mean value containing viewing incidence azimuth angle average for band B5 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B6',
            description: 'Mean value containing viewing incidence azimuth angle average for band B6 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B7',
            description: 'Mean value containing viewing incidence azimuth angle average for band B7 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B8',
            description: 'Mean value containing viewing incidence azimuth angle average for band B8 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B8A',
            description: 'Mean value containing viewing incidence azimuth angle average for band B8a and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B9',
            description: 'Mean value containing viewing incidence azimuth angle average for band B9 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B10',
            description: 'Mean value containing viewing incidence azimuth angle average for band B10 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B11',
            description: 'Mean value containing viewing incidence azimuth angle average for band B11 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_AZIMUTH_ANGLE_B12',
            description: 'Mean value containing viewing incidence azimuth angle average for band B12 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B1',
            description: 'Mean value containing viewing incidence zenith angle average for band B1 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B2',
            description: 'Mean value containing viewing incidence zenith angle average for band B2 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B3',
            description: 'Mean value containing viewing incidence zenith angle average for band B3 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B4',
            description: 'Mean value containing viewing incidence zenith angle average for band B4 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B5',
            description: 'Mean value containing viewing incidence zenith angle average for band B5 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B6',
            description: 'Mean value containing viewing incidence zenith angle average for band B6 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B7',
            description: 'Mean value containing viewing incidence zenith angle average for band B7 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B8',
            description: 'Mean value containing viewing incidence zenith angle average for band B8 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B8A',
            description: 'Mean value containing viewing incidence zenith angle average for band B8a and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B9',
            description: 'Mean value containing viewing incidence zenith angle average for band B9 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B10',
            description: 'Mean value containing viewing incidence zenith angle average for band B10 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B11',
            description: 'Mean value containing viewing incidence zenith angle average for band B11 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_INCIDENCE_ZENITH_ANGLE_B12',
            description: 'Mean value containing viewing incidence zenith angle average for band B12 and for all detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_SOLAR_AZIMUTH_ANGLE',
            description: 'Mean value containing sun azimuth angle average for all bands and detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MEAN_SOLAR_ZENITH_ANGLE',
            description: 'Mean value containing sun zenith angle average for all bands and detectors',
            type: ee_const.var_type.double,
          },
          {
            name: 'MGRS_TILE',
            description: 'US-Military Grid Reference System (MGRS) tile',
            type: ee_const.var_type.string,
          },
          {
            name: 'PROCESSING_BASELINE',
            description: |||
              Configuration baseline used at the time of the product
              generation in terms of processor software version and major Ground
              Image Processing Parameters (GIPP) version
            |||,
            type: ee_const.var_type.string,
          },
          {
            name: 'PRODUCT_ID',
            description: 'The full id of the original Sentinel-2 product',
            type: ee_const.var_type.string,
          },
          {
            name: 'RADIOMETRIC_QUALITY',
            description: 'Based on the OLQC reports contained in the Datastrips/QI_DATA with RADIOMETRIC_QUALITY checklist name',
            type: ee_const.var_type.string,
          },
          {
            name: 'REFLECTANCE_CONVERSION_CORRECTION',
            description: 'Earth-Sun distance correction factor',
            type: ee_const.var_type.double,
          },
          {
            name: 'SENSING_ORBIT_DIRECTION',
            description: 'Imaging orbit direction',
            type: ee_const.var_type.string,
          },
          {
            name: 'SENSING_ORBIT_NUMBER',
            description: 'Imaging orbit number',
            type: ee_const.var_type.double,
          },
          {
            name: 'SENSOR_QUALITY',
            description: |||
              Synthesis of the OLQC checks performed at granule
              (Missing_Lines, Corrupted_ISP, and Sensing_Time) and datastrip
              (Degraded_SAD and Datation_Model) levels
            |||,
            type: ee_const.var_type.string,
          },
          {
            name: 'SOLAR_IRRADIANCE_B1',
            description: 'Mean solar exoatmospheric irradiance for band B1',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B2',
            description: 'Mean solar exoatmospheric irradiance for band B2',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B3',
            description: 'Mean solar exoatmospheric irradiance for band B3',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B4',
            description: 'Mean solar exoatmospheric irradiance for band B4',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B5',
            description: 'Mean solar exoatmospheric irradiance for band B5',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B6',
            description: 'Mean solar exoatmospheric irradiance for band B6',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B7',
            description: 'Mean solar exoatmospheric irradiance for band B7',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B8',
            description: 'Mean solar exoatmospheric irradiance for band B8',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B8A',
            description: 'Mean solar exoatmospheric irradiance for band B8a',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B9',
            description: 'Mean solar exoatmospheric irradiance for band B9',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B10',
            description: 'Mean solar exoatmospheric irradiance for band B10',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B11',
            description: 'Mean solar exoatmospheric irradiance for band B11',
            type: ee_const.var_type.double,
          },
          {
            name: 'SOLAR_IRRADIANCE_B12',
            description: 'Mean solar exoatmospheric irradiance for band B12',
            type: ee_const.var_type.double,
          },
          {
            name: 'SPACECRAFT_NAME',
            description: 'Sentinel-2 spacecraft name: Sentinel-2A, Sentinel-2B',
            type: ee_const.var_type.string,
          },
        ],
        platform: [
          'Sentinel-2A',
          'Sentinel-2B',
        ],
        instruments: [
          'MSI',
        ],
        'eo:bands': [
          {
            name: 'B1',
            description: 'Aerosols',
            center_wavelength: 0.4439,
            gsd: 60.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '443.9nm (S2A) / 442.3nm (S2B)',
          },
          {
            name: 'B2',
            description: 'Blue',
            center_wavelength: 0.4966,
            gsd: 10.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '496.6nm (S2A) / 492.1nm (S2B)',
          },
          {
            name: 'B3',
            description: 'Green',
            center_wavelength: 0.56,
            gsd: 10.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '560nm (S2A) / 559nm (S2B)',
          },
          {
            name: 'B4',
            description: 'Red',
            center_wavelength: 0.6645,
            gsd: 10.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '664.5nm (S2A) / 665nm (S2B)',
          },
          {
            name: 'B5',
            description: 'Red Edge 1',
            center_wavelength: 0.7039,
            gsd: 20.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '703.9nm (S2A) / 703.8nm (S2B)',
          },
          {
            name: 'B6',
            description: 'Red Edge 2',
            center_wavelength: 0.7402,
            gsd: 20.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '740.2nm (S2A) / 739.1nm (S2B)',
          },
          {
            name: 'B7',
            description: 'Red Edge 3',
            center_wavelength: 0.7825,
            gsd: 20.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '782.5nm (S2A) / 779.7nm (S2B)',
          },
          {
            name: 'B8',
            description: 'NIR',
            center_wavelength: 0.8351,
            gsd: 10.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '835.1nm (S2A) / 833nm (S2B)',
          },
          {
            name: 'B8A',
            description: 'Red Edge 4',
            center_wavelength: 0.8648,
            gsd: 20.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '864.8nm (S2A) / 864nm (S2B)',
          },
          {
            name: 'B9',
            description: 'Water vapor',
            center_wavelength: 0.945,
            gsd: 60.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '945nm (S2A) / 943.2nm (S2B)',
          },
          {
            name: 'B10',
            description: 'Cirrus',
            center_wavelength: 1.3735,
            gsd: 60.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '1373.5nm (S2A) / 1376.9nm (S2B)',
          },
          {
            name: 'B11',
            description: 'SWIR 1',
            center_wavelength: 1.6137,
            gsd: 20.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '1613.7nm (S2A) / 1610.4nm (S2B)',
          },
          {
            name: 'B12',
            description: 'SWIR 2',
            center_wavelength: 2.2024,
            gsd: 20.0,
            'gee:scale': 0.0001,
            'gee:wavelength': '2202.4nm (S2A) / 2185.7nm (S2B)',
          },
          {
            name: 'QA10',
            description: 'Always empty',
            gsd: 10.0,
          },
          {
            name: 'QA20',
            description: 'Always empty',
            gsd: 20.0,
          },
          {
            name: 'QA60',
            description: 'Cloud mask. Masked out between February 2022 and February 2024.',
            gsd: 60.0,
            'gee:bitmask': {
              bitmask_parts: [
                {
                  description: 'Unused',
                  first_bit: 0,
                  bit_count: 10,
                },
                {
                  description: 'Opaque clouds',
                  first_bit: 10,
                  bit_count: 1,
                  values: [
                    {
                      description: 'No opaque clouds',
                      value: 0,
                    },
                    {
                      value: 1,
                      description: 'Opaque clouds present',
                    },
                  ],
                },
                {
                  description: 'Cirrus clouds',
                  first_bit: 11,
                  bit_count: 1,
                  values: [
                    {
                      description: 'No cirrus clouds',
                      value: 0,
                    },
                    {
                      value: 1,
                      description: 'Cirrus clouds present',
                    },
                  ],
                },
              ],
              total_bit_count: 12,
            },
          },
          {
            name: 'MSK_CLASSI_OPAQUE',
            description: 'Opaque clouds classification band (0=no clouds, 1=clouds). Masked out before February 2024.',
            gsd: 60.0,
          },
          {
            name: 'MSK_CLASSI_CIRRUS',
            description: 'Cirrus clouds classification band (0=no clouds, 1=clouds). Masked out before February 2024.',
            gsd: 60.0,
          },
          {
            name: 'MSK_CLASSI_SNOW_ICE',
            description: 'Snow/ice classification band (0=no snow/ice, 1=snow/ice). Masked out before February 2024.',
            gsd: 60.0,
          }
        ],
        'gee:visualizations': [
          {
            display_name: 'RGB',
            lookat: {
              lat: 51.4191,
              lon: 4.1968,
              zoom: 12,
            },
            image_visualization: {
              band_vis: {
                min: [
                  0.0,
                ],
                max: [
                  3000.0,
                ],
                bands: [
                  'B4',
                  'B3',
                  'B2',
                ],
              },
            },
          },
        ],
      },
      'gee:interval': {
        type: 'revisit_interval',
        unit: 'day',
        interval: 5,
      },
      'gee:terms_of_use': |||
        The use of Sentinel data is governed by the [Copernicus
        Sentinel Data Terms and Conditions.](https://sentinels.copernicus.eu/documents/247904/690755/Sentinel_Data_Legal_Notice)
      |||,
    },
}
