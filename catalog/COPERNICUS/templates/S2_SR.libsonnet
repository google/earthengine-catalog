local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local subdir = 'COPERNICUS';
local license = spdx.proprietary;

// TODO(b/271332540): After Collection 1 reprocessing, the Feb 2022-Feb 2024
// gap in QA60/MSK_CLASSI bands will be gone, so we will need to remove
// the corresponding text below.

{
  s2_dataset(id, version, version_config)::
    local basename = std.strReplace(id, '/', '_');
    local base_filename = basename + '.json';
    local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
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
      title: 'Sentinel-2 MSI: MultiSpectral Instrument, Level-2A',
      'gee:type': ee_const.gee_type.image_collection,
      description: |||
        Sentinel-2 is a wide-swath, high-resolution, multi-spectral
        imaging mission supporting Copernicus Land Monitoring studies,
        including the monitoring of vegetation, soil and water cover,
        as well as observation of inland waterways and coastal areas.

        The Sentinel-2 L2 data are downloaded from scihub. They were
        computed by running sen2cor. WARNING: ESA did not produce L2 data
        for all L1 assets, and earlier L2 coverage is not global.

        The assets contain
        12 UINT16 spectral bands representing SR scaled by 10000 (unlike in L1 data,
        there is no B10). There are also several more L2-specific bands (see band
        list for details). See the
        [Sentinel-2 User Handbook](https://sentinel.esa.int/documents/247904/685211/Sentinel-2_User_Handbook)
        for details.

        QA60 is a bitmask band that contained rasterized cloud mask
        polygons until February 2022, when these polygons stopped being produced.
        Starting in February 2024, legacy-consistent QA60 bands are constructed from the MSK_CLASSI
        cloud classification bands.
        For more details,
        [see the full explanation of how cloud masks are computed.](https://sentinel.esa.int/web/sentinel/technical-guides/sentinel-2-msi/level-1c/cloud-masks)

        EE asset ids for Sentinel-2 L2 assets have the following format:
        COPERNICUS/S2_SR/20151128T002653_20151128T102149_T56MNN. Here the
        first numeric part represents the sensing date and time, the
        second numeric part represents the product generation date and
        time, and the final 6-character string is a unique granule identifier
        indicating its UTM grid reference (see [MGRS](https://en.wikipedia.org/wiki/Military_Grid_Reference_System)).

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
        'reflectance',
        'sentinel',
        'sr',
      ],
      providers: [
        ee.producer_provider('European Union/ESA/Copernicus', 'https://sentinel.esa.int/web/sentinel/user-guides/sentinel-2-msi/processing-levels/level-2'),
        ee.host_provider(version_config.ee_catalog_url),
      ],
      extent: ee.extent(-180.0, -56.0, 180.0, 83.0, '2017-03-28T00:00:00Z', null),
      summaries: {
        'gee:schema': [
          {
            name: 'AOT_RETRIEVAL_ACCURACY',
            description: 'Accuracy of Aerosol Optical thickness model',
            type: ee_const.var_type.double,
          },
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
            name: 'CLOUDY_SHADOW_PERCENTAGE',
            description: 'Percentage of pixels classified as cloud shadow',
            type: ee_const.var_type.double,
          },
          {
            name: 'DARK_FEATURES_PERCENTAGE',
            description: 'Percentage of pixels classified as dark features or shadows',
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
            name: 'HIGH_PROBA_CLOUDS_PERCENTAGE',
            description: 'Percentage of pixels classified as high probability clouds',
            type: ee_const.var_type.double,
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
            name: 'MEDIUM_PROBA_CLOUDS_PERCENTAGE',
            description: 'Percentage of pixels classified as medium probability clouds',
            type: ee_const.var_type.double,
          },
          {
            name: 'MGRS_TILE',
            description: 'US-Military Grid Reference System (MGRS) tile',
            type: ee_const.var_type.string,
          },
          {
            name: 'NODATA_PIXEL_PERCENTAGE',
            description: 'Percentage of No Data pixels',
            type: ee_const.var_type.double,
          },
          {
            name: 'NOT_VEGETATED_PERCENTAGE',
            description: 'Percentage of pixels classified as non-vegetated',
            type: ee_const.var_type.double,
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
            name: 'RADIATIVE_TRANSFER_ACCURACY',
            description: 'Accuracy of radiative transfer model',
            type: ee_const.var_type.double,
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
            name: 'SATURATED_DEFECTIVE_PIXEL_PERCENTAGE',
            description: 'Percentage of saturated or defective pixels',
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
            name: 'SNOW_ICE_PERCENTAGE',
            description: 'Percentage of pixels classified as snow or ice',
            type: ee_const.var_type.double,
          },
          {
            name: 'SPACECRAFT_NAME',
            description: 'Sentinel-2 spacecraft name: Sentinel-2A, Sentinel-2B',
            type: ee_const.var_type.string,
          },
          {
            name: 'THIN_CIRRUS_PERCENTAGE',
            description: 'Percentage of pixels classified as thin cirrus clouds',
            type: ee_const.var_type.double,
          },
          {
            name: 'UNCLASSIFIED_PERCENTAGE',
            description: 'Percentage of unclassified pixels',
            type: ee_const.var_type.double,
          },
          {
            name: 'VEGETATION_PERCENTAGE',
            description: 'Percentage of pixels classified as vegetation',
            type: ee_const.var_type.double,
          },
          {
            name: 'WATER_PERCENTAGE',
            description: 'Percentage of pixels classified as water',
            type: ee_const.var_type.double,
          },
          {
            name: 'WATER_VAPOUR_RETRIEVAL_ACCURACY',
            description: 'Declared accuracy of the Water Vapor model',
            type: ee_const.var_type.double,
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
            name: 'AOT',
            description: 'Aerosol Optical Thickness',
            gsd: 10.0,
            'gee:scale': 0.001,
          },
          {
            name: 'WVP',
            description: |||
              Water Vapor Pressure. The height the water would occupy if the vapor were condensed into
              liquid and spread evenly across the column.
            |||,
            'gee:units': units.centimeter,
            gsd: 10.0,
            'gee:scale': 0.001,
          },
          {
            name: 'SCL',
            description: 'Scene Classification Map (The "No Data" value of 0 is masked out)',
            gsd: 20.0,
            'gee:classes': [
              {
                value: 1,
                color: 'ff0004',
                description: 'Saturated or defective',
              },
              {
                value: 2,
                color: '868686',
                description: 'Dark Area Pixels',
              },
              {
                value: 3,
                color: '774b0a',
                description: 'Cloud Shadows',
              },
              {
                value: 4,
                color: '10d22c',
                description: 'Vegetation',
              },
              {
                value: 5,
                color: 'ffff52',
                description: 'Bare Soils',
              },
              {
                value: 6,
                color: '0000ff',
                description: 'Water',
              },
              {
                value: 7,
                color: '818181',
                description: 'Clouds Low Probability / Unclassified',
              },
              {
                value: 8,
                color: 'c0c0c0',
                description: 'Clouds Medium Probability',
              },
              {
                value: 9,
                color: 'f1f1f1',
                description: 'Clouds High Probability',
              },
              {
                value: 10,
                color: 'bac5eb',
                description: 'Cirrus',
              },
              {
                value: 11,
                color: '52fff9',
                description: 'Snow / Ice',
              },
            ],
          },
          {
            name: 'TCI_R',
            description: 'True Color Image, Red channel',
            gsd: 10.0,
          },
          {
            name: 'TCI_G',
            description: 'True Color Image, Green channel',
            gsd: 10.0,
          },
          {
            name: 'TCI_B',
            description: 'True Color Image, Blue channel',
            gsd: 10.0,
          },
          {
            name: 'MSK_CLDPRB',
            description: 'Cloud Probability Map (missing in some products)',
            gsd: 20.0,
          },
          {
            name: 'MSK_SNWPRB',
            description: 'Snow Probability Map (missing in some products)',
            gsd: 10.0,
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
              lat: 17.7009,
              lon: 83.277,
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
        SCL: {
          minimum: 1.0,
          maximum: 11.0,
          'gee:estimated_range': false,
        },
        MSK_CLDPRB: {
          minimum: 0.0,
          maximum: 100.0,
          'gee:estimated_range': false,
        },
        MSK_SNWPRB: {
          minimum: 0.0,
          maximum: 100.0,
          'gee:estimated_range': false,
        },
      },
      'gee:interval': {
        type: 'revisit_interval',
        unit: 'day',
        interval: 5,
      },
      'gee:terms_of_use': |||
        The use of Sentinel data is governed by the [Copernicus
        Sentinel Data Terms and Conditions.](https://scihub.copernicus.eu/twiki/pub/SciHubWebPortal/TermsConditions/Sentinel_Data_Terms_and_Conditions.pdf)
      |||,
    }
}
