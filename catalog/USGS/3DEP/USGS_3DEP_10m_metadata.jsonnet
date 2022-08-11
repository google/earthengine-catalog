local id = 'USGS/3DEP/10m_metadata';
local subdir = 'USGS/3DEP';

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
  id: id,
  title: 'USGS 3DEP National Map Spatial Metadata 1/3 Arc-Second (10m)',
  'gee:type': ee_const.gee_type.table,
  description: |||
    This is a table with metadata [for the 3DEP 10m DEM asset](USGS_3DEP_10m).

    The Work unit Extent Spatial Metadata (WESM) contains current lidar data
    availability and basic information about lidar projects, including lidar
    quality level, data acquisition dates, and links to project-level metadata.

    See more details
    [in this document](https://prd-wret.s3.us-west-2.amazonaws.com/assets/palladium/production/atoms/files/3DEP_Spatial_Metadata_Glossary_0.pdf) (taken from
    [this page](https://www.usgs.gov/media/files/3dep-spatial-metadata-glossary)).

    Dataset uploaded by [Farmers Business Network](https://fbn.com).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://www.usgs.gov/information-policies-and-instructions/crediting-usgs'),
  ],
  keywords: [
    '3dep',
    'usgs',
  ],
  providers: [
    ee.producer_provider('United States Geological Survey', 'https://www.usgs.gov/core-science-systems/ngp/ss/3dep-spatial-metadata'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-171.0, -16.6, 164.0, 76.9,
                    '1998-08-16T00:00:00Z', '2020-05-06T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'abspts',
        description: 'Sample Size. Always 0',
        type: ee_const.var_type.int,
      },
      {
        name: 'absx',
        description: |||
          Absolute accuracy in X

          This field applies only to standard production USGS DEMs and echoes data
          element 2 of the source DEM's Type C record,(Digital Elevation Models,
          USGS, 1993). See Standards for Digital Elevation Models for more
          information. This field is populated with zero if not available.

          For DEMs introduced after April 1, 2014 this field will be populated
          with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'absy',
        description: |||
          Absolute accuracy in Y

          This field applies only to standard production USGS DEMs and echoes data
          element 2 of the source DEM's Type C record,(Digital Elevation Models,
          USGS, 1993). See Standards for Digital Elevation Models for more
          information. This field is populated with zero if not available.

          For DEMs introduced after April 1, 2014 this field will be populated
          with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'absz',
        description: |||
          Absolute accuracy in Z

          This field applies only to standard production USGS DEMs and echoes data
          element 2 of the source DEM's Type C record,(Digital Elevation Models,
          USGS, 1993). See Standards for Digital Elevation Models for more
          information. This field is populated with zero if not available.

          For DEMs introduced after April 1, 2014 this field will be populated
          with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'demname',
        description: |||
          Data Name.

          The name of the original project that was adapted for incorporation into
          the elevation layers. The format of this field will most commonly be
          three parts separated by underscores: PRIMARYSTATE,
          BRIEF-PROJECT-DESCRIPTION, YEAR
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'freetext',
        description: |||
          Free Text Description

          For DEMs derived from standard USGS paper map series, this field is
          first 136 bytes of the source DEM file, including the quadrangle name,
          free format text, and process field. This field may contain additional
          information, though there are no standards for the use of the free text
          field.

          Example: NORTH CHINOOK RESERVOIR, MT -VDYA 1-09 9/06/75 WILD A-7 60000 4 - 10915 0.0000 4845 0.00002

          For DEMs introduced after April 1, 2014 this field will no longer
          be populated.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'hdatum',
        description: |||
          Horizontal Datum

          Valid values:
            * 0: Unknown
            * 27: North American Datum of 1927 (NAD 27)
            * 83: North American Datum of 1983 (NAD 83)
            * 72: World Geodetic System of 1972 (WGS 72)
            * 84: World Geodetic System of 1984 (WGS 84)
            * 99: Other
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'horizres_m',
        description: |||
          Horizontal Resolution of Source DEM

          The horizontal resolution (x, y) of the original DEM which was used to
          produce elevation products, expressed in meters. Regardless of the
          source DEM horizontal units, this field is expressed in the common unit
          meters for more meaningful comparisons and simplified queries.

          This is a new field in the spatial metadata shapefiles for DEMs used to
          produce elevation products after April 1, 2014. For DEMs used to produce
          elevation products prior to March 31, 2014, this field will be populated
          with -100.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'i_date',
        description: |||
          Data Inspection Date

          For DEMs derived from standard USGS paper map series, this field is
          data element 22 in the source DEMs Type A record: DEM Edit System (DES)
          inspection date (Digital Elevation Models, USGS, 1993). This information
          was not provided with some standard DEMs.

          Format is either YYYY or YYMM.

          For DEMs introduced after April 1, 2014 this field be populated
          with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'lrlat',
        description: 'Southern extent in latitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'lrlon',
        description: 'Eastern extent in longitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'meta_p_are',
        description: 'Unknown',
        type: ee_const.var_type.int,
      },
      {
        name: 'meta_p_per',
        description: 'Unknown',
        type: ee_const.var_type.int,
      },
      {
        name: 'pdevice',
        description: |||
          Production Device

          The name of the instrument used to compile the source DEM. This field
          is of significance primarily to DEMs produced by manual profiling
          (PMETHOD = 2). For DEMs introduced after April 1, 2014 this field
          will no longer be populated.

          The current list of identified instruments is:
            * Wild A-7: Wild Autograph A7 - Mechanical Stereoplotter
            * Wild AG-1: Wild AG1 - Analytical Stereoplotter
            * OMI AS11A: OMI AS11A - Mechanical Stereoplotter
            * Wild B-8: Wild Aviograph B8 - Mechanical Stereoplotter
            * Wild BC-1: Wild BC1 - Analytical Stereoplotter
            * Wild BC-2: Wild BC2 - Analytical Stereoplotter
            * Zeiss C-8: Zeiss Stereoplanigraph C8 - Stereoplotter
            * Zeiss C100: Zeiss C100 Planicomp - Analytical Stereoplotter
            * GPM: Gestalt Photo Mapper II (GPM II)
            * KELSH: Kelsh - Optical Stereoplotter
            * Kern: PG-2 Kern PG-2 - Mechanical Stereoplotter
            * Wild: PPO-8 Wild PPO-8 Orthophoto Equipment (Used with Wild A8)
            * Santoni IIC: Santoni IIC - Analytical Stereoplotter
            * Galileo IIId: Galileo-Santoni Stereosimplex IIId
            * Jena Topocart B: Zeiss Jena Topocart B
            * Matra Traster: Matra Optique Traster - Photogrammetric Workstation
            * Helava US-2: Helava US-2 - Analytical Stereoplotter
            * CP100: Unknown, but appears to be a stereoplotter
            * CTOG: Contour to Grid Conversion
            * DCASS: Digital Cartographic Software System (USGS Software)
            * DLG: Digital Line Graph
            * LT4X: Either LT4X or LTPlus software
            * GDM COTS: DEM made by GeoDigital Mapping, Inc.
            * GTR COTS: DEM made by GTRSystems, Inc.
            * LT2000: Windows version of LT4X by Titan Systems, Inc.
            * SRTM: Shuttle Radar Topographic Mission
            * Unknown: Unknown
            * ADS40: Leica ADS40 Digital Camera
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'pmethod',
        description: |||
          Production Method

          The method used to compile or capture the source DEM. For more
          information regarding PMETHODS see Digital Elevation Models (USGS, 1993).

          Valid codes are:
            * 0: Unknown
            * 1: Electronic Image Correlation (specifically GPM II)
            * 2: Manual Profiling
            * 3: DLG2DEM
            * 4: DCASS
            * 5: LT4X
            * 6: Complex polynomial interpolation, such as ANUDEM
            * 7: Lidar
            * 8: Photogrammetric mass points and break lines
            * 9: Digital camera correlation
            * 10: Ifsar
            * 11: Other remote sensing technique
            * 12: Topobathymetric model
            * 13: Topobathymetric lidar
            * 14: Bathymetric lidar
            * 15: Geiger mode lidar
            * 16: Single photon lidar
            * 17: Flash lidar
            * 18: Acoustic
            * 19: Structure from motion
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'psite',
        description: |||
          Production Site

          The site or party who created the source DEM for DEMs used to produce
          elevation products prior to March 31, 2014. For DEMs introduced after
          April 1, 2014 this field will be populated with the value UNKNOWN.

          Valid codes are:
            * UNKNOWN: Unknown
            * CONT: Contractor
            * MCMC: Mid-Continent Mapping Center
            * RMMC: Rocky Mountain Mapping Center
            * EMC: Eastern Mapping Center
            * WMC: Western Mapping Center
            * MAC: Mapping Applications Center
            * FS: Forest Service
            * USFS: Forest Service
            * BLM: Bureau of Land Management
            * NGTO: National Geospatial Technical Operations Center
            * AB: Alberta Sustainable Resource Development: Edmonton, Alberta, Canada
            * GDB: Center for Topographic Information, Geomatics Canada
            * NS: Nova Scotia Geomatics Center
            * NTDB: Center for TopographicInformation Geomatics Canada: Ottawa, Ontario, Canada or Landscape Analysis - Canadian Forest Service: Sault Ste. Marie, Ontario, Canada
            * ON: Water Resources Information Program: Ottawa, Ontario, Canada
            * RS: Center for Topographic Information Geomatics Canada: Ottawa, Ontario, Canada
            * Z: Direction generale de l'information geographique, MRNF, Quebec, Canada
            * YT: Yukon Environment Information Management and Technology
            * BC: Base Mapping and Geomatic Services: Victoria, British Columbia, Canada
            * MULT: Multiple Canadian government agencies
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'pts_id',
        description: 'Unknown',
        type: ee_const.var_type.int,
      },
      {
        name: 'quaddate',
        description: |||
          Date the data were used to produce the elevation product

          The date on which the source DEM was first processed into elevation
          products. This field is particularly useful in the identification
          of recently updated areas.

          Format: YYYYMMDD
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'quadname',
        description: |||
          Quadrangle Name.
          Additional source information. For DEMs introduced after April 1, 2014 this field will not be populated.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'resolution',
        description: |||
          Source Resolution

          This code indicates the planimetric (x, y) spacing of elevation postings
          within the source DEM. Note that all source data are resampled to a
          common resolution during production.

          For DEMs used to produce elevation products prior to March 31, 2014
          valid values are:

            * 0: Unknown
            * 1: 1 arc-second (Alaska, Canada, Mexico)
            * 2: 2 arc-seconds (1:100k series)
            * 3: 3 arc-seconds (1:250k series)
            * 5: 5 meters (non-standard data)
            * 10: 10 meters (7.5-minute series)
            * 30: 30 meters (7.5-minute series)
            * 13: 1/3 arc-second (non-standard data)
            * 19: 1/9 arc-second (non-standard data)

          For DEMs introduced after April 1, 2014 the actual resolution of the
          original high-resolution source DEM will be populated in the HORIZRES_M
          field, and the RESOLUTION field will be populated with:

            * 100: High-resolution source
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'rmse',
        description: |||
          Availability of Relative Accuracy Statistics

          This field applies only to standard production USGS DEMs and echoes
          data element 4 of the source DEM's Type C (relative accuracy statistics)
          (Digital Elevation Models, USGS, 1993).

          Valid codes:

            * 1 Available
            * 0 Not available

          For DEMs introduced after April 1, 2014 this field will be populated
          with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'rmsepts',
        description: |||
          Sample Size
          This field applies only to standard production USGS DEMs and echoes data element 6 of the source DEM's Type C (sample size) (Digital Elevation Models, USGS, 1993).
          For DEMs introduced after April 1, 2014 this field will populated with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'rmsex',
        description: |||
          Relative Accuracy X
          This field applies only to standard production USGS DEMs and echoes data element 5 of the source DEM's Type C (relative accuracy in X, Y, Z (Digital Elevation Models, USGS, 1993). This field is zero if not available.
          For DEMs introduced after April 1, 2014 this field will be populated with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'rmsey',
        description: |||
          Relative Accuracy Y
          This field applies only to standard production USGS DEMs and echoes data element 5 of the source DEM's Type C (relative accuracy in X, Y, Z (Digital Elevation Models, USGS, 1993). This field is zero if not available.
          For DEMs introduced after April 1, 2014 this field will be populated with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'rmsez',
        description: |||
          Relative Accuracy Z
          This field applies only to standard production USGS DEMs and echoes data element 5 of the source DEM's Type C (relative accuracy in X, Y, Z (Digital Elevation Models, USGS, 1993). This field is zero if not available.
          For DEMs introduced after April 1, 2014 this field will be populated with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 's_date',
        description: |||
          Data Source Date

          For DEMs derived from standard USGS paper map series, this field is data
          element 21 in the source DEM Type A record, the date of original
          photography from which the DEM was compiled (Digital Elevation Models
          (USGS, 1993). This information was not provided with some standard DEMs
          with a native resolution of 30 meters.

          In the case of high resolution source data, this field reflects the year
          that the base elevation data was collected, as in the case of LIDAR
          derived DEMs. For projects whose collection spanned more than
          one calendar year, this is the earliest acquisition year.

          Format: YYYY
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'ullat',
        description: 'Northern extent in latitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'ullon',
        description: 'Western extent in longitude.',
        type: ee_const.var_type.double,
      },
      {
        name: 'utmzone',
        description: |||
          Source UTM or State Plane Zone
          The projection zone of the source DEM. If two digits, a UTM zone. If four digits, a State Plane zone. A value of zero in this field indicates that the source DEM is cast in geographic (lat/lon) coordinates.
          For DEMs introduced after April 1, 2014 this field will be populated with -100.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'vdatum',
        description: |||
          Vertical Datum

          This code represents the vertical datum of source DEM. Valid values are:

            * 0: Unknown
            * 1: Local Mean Sea Level
            * 2: American Samoa Vertical Datum of 2002 (ASVD02)
            * 3: Northern Marianas Vertical Datum of 2003 (NMVD03)
            * 4: Guam Vertical Datum of 2004 (GUVD04)
            * 5: Puerto Rico Vertical Datum of 2002 (PRVD02)
            * 6: Virgin Islands Vertical Datum of 2009 (VIVD09)
            * 29: National Geodetic Vertical Datum of 1929 (NGVD 29)
            * 88: North American Vertical Datum of 1988 (NAVD 88)
            * 99: Other
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'xshift',
        description: |||
          Horizontal Shift in longitude.
          The positional shift in longitude applied to each posting in the source DEM to convert from NAD27 coordinates to NAD83 coordinates. These values will be zero if the source DEM's HDATUM field value is 83, 84 or 72. (WGS84 is nearly identical to NAD83, and WGS72 is sufficiently similar that no shift was deemed necessary). The shift values were obtained from NGS's NADCON software, and were calculated at the nominal center of each quadrangle.
          New high-resolution DEMs introduced after April 1, 2014 generally have a horizontal datum of NAD83 and this field will be populated with -100.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'yshift',
        description: |||
          Horizontal Shift in latitude.
          The positional shift in latitude applied to each posting in the source DEM to convert from NAD27 coordinates to NAD83 coordinates. These values will be zero if the source DEM's HDATUM field value is 83, 84 or 72. (WGS84 is nearly identical to NAD83, and WGS72 is sufficiently similar that no shift was deemed necessary). The shift values were obtained from NGS's NADCON software, and were calculated at the nominal center of each quadrangle.
          New high-resolution DEMs introduced after April 1, 2014 generally have a horizontal datum of NAD83 and this field will be populated with -100.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zmax',
        description: |||
          Maximum Elevation of Source DEM
          The maximum elevation value of the source DEM before any filtering or reprojection, but after conversion to meters and to NAVD88. For DEMs derived from standard USGS maps, subtracting ZSHIFT and converting to the DEM's original units results in the min and max values reported in data element 12 of the DEM's Type A record (Digital Elevation Models, USGS, 1993).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zmean',
        description: |||
          Mean Elevation of Elevations in Source DEM
          The mean elevation value of the source DEM before any filtering or reprojection, but after conversion to meters and to NAVD88.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zmin',
        description: |||
          Minimum Elevation of Source DEM
          The minimum elevation value of the source DEM before any filtering or reprojection, but after conversion to meters and to NAVD88. For DEMs derived from standard USGS maps, subtracting ZSHIFT and converting to the DEM's original units results in the min and max values reported in data element 12 of the DEM's Type A record (Digital Elevation Models, USGS, 1993).
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zshift',
        description: |||
          Elevation Shift
          The elevation shift, in meters, applied to each posting within the source DEM to convert to NAVD88 values. The shift values were obtained from NGS's VERTCON software, and were calculated at the nominal center of each quadrangle.
          New high-resolution DEMs introduced into after April 1, 2014 all have a vertical datum of NAVD88, therefore this field will be populated with -100.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zsigma',
        description: |||
          Standard Deviation of Elevations in Source DEM
          The standard deviation of the elevations of the source DEM, before any filtering or reprojection, but after conversion to meters.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zstep',
        description: |||
          Elevation Resolution

          For DEMs derived from standard USGS paper map series, this field,
          together with ZUNIT, defines vertical resolution of the source DEM.
          Typical values are 1 and 0.1, though others are possible.

          Example: ZSTEP = 0.1 This indicates that the source DEM records
          elevations to the nearest tenth of a meter.

          A value of 0 is used when this field does not apply, as in the case
          of source data with floating point precision.

          New high-resolution DEMs introduced after April 1, 2014 all have
          floating point precision, and this field will be populated with -100.
        |||,
        type: ee_const.var_type.double,
      },
      {
        name: 'zunit',
        description: |||
          Elevation Unit

          This code represents the unit of elevation values in source DEM.
          Valid values:

            * 0: International Feet
            * 1: Meters
            * 2: U.S. Survey Feet
            * 3: Decimal degrees
            * 4: Centimeters
            * 5: Inches
            * 99: Other
        |||,
        type: ee_const.var_type.int,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Mean Source DEM Elevation',
        lookat: {
          lat: 37.649,
          lon: -99.844,
          zoom: 5,
        },
        polygon_visualization: {
          property_name: 'zmean',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              2000.0,
            ],
            palette: [
              '0000ff',
              '00ffff',
              'ffff00',
              'ff0000',
              'ffffff',
            ],
          },
        },
      },
      {
        display_name: 'Mean Source DEM Elevation',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 12000,
      thinning_strategy: 'HIGHER_DENSITY',
      z_order_ranking: '.minZoomLevel DESC',
      prerender_tiles: true,
    },
  },
  'gee:terms_of_use': |||
    Most U.S. Geological Survey (USGS) information resides
    in the public domain and may be used without restriction. Additional
    information on [Acknowledging or Crediting USGS as Information
    Source](https://www.usgs.gov/information-policies-and-instructions/crediting-usgs)
    is available.
  |||,
  'gee:user_uploaded': true,
}
