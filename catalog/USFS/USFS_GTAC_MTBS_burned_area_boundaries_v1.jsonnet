local id = 'USFS/GTAC/MTBS/burned_area_boundaries/v1';
local subdir = 'USFS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: 'Collection',
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'MTBS Burned Area Boundaries',
  'gee:type': ee_const.gee_type.table,
  description: |||
    The
    [Monitoring Trends in Burn Severity (MTBS)](https://www.mtbs.gov/project-overview)
    burned area boundaries dataset contains the extent polygons of the burned
    areas of all currently completed MTBS fires for the continental
    United States, Alaska, Hawaii, and Puerto Rico.

    Below NBR stands for "Normalized Burn Ratio", while dNBR stands for
    "delta NBR", or "PreFire NBR - PostFire NBR".

    Notes on the threshold values:

    * dNBR is used when available, but sometimes NBR must be used.
    * NBR and dNBR, in this situation, have an inverse relationship
    * Therefore, thresholds are determined based both on the type of incoming
      data and the range of the data
    * The 9999 and -9999 values are fill values representing the cases when
      an analyst did not use a threshold (for example, a low severity incident
      would not warrant the use of a high severity threshold).
    * In some cases values of 999 and -999 were entered (instead of 9999
      and -9999).

    More information:

    * [MTBS Contact Page](https://www.mtbs.gov/contact)
    * [MTBS Data Explorer](https://apps.fs.usda.gov/lcms-viewer/mtbs.html)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'BurnSeverity',
    'EROS',
    'Fire',
    'GTAC',
    'MTBS',
    'PrescribedFire',
    'USDA',
    'USFS',
    'USGS',
    'Wildfire',
  ],
  providers: [
    ee.producer_provider('USDA Forest Service (USFS) Geospatial Technology and Applications Center (GTAC), DOI United States Geological Survey (USGS) Earth Resources Observation and Science (EROS) Center', 'https://www.mtbs.gov/product-descriptions'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(
      -180.0, 19, -64.435, 71.567,
      '1984-01-01T00:00:00Z', '2022-06-01T00:00:00Z'),
  'sci:citation': |||
    USDA Forest Service;US Geological Survey. Monitoring Trends in Burn
    Severity Thematic Burn Severity. Salt Lake City, Utah;Sioux Falls,
    South Dakota
  |||,
  'gee:user_uploaded': true,
  'gee:terms_of_use': |||
    The USDA Forest Service makes no warranty, expressed or implied, including
    the warranties of merchantability and fitness for a particular purpose, nor
    assumes any legal liability or responsibility for the accuracy, reliability,
    completeness or utility of these geospatial data, or for the improper or
    incorrect use of these geospatial data. These geospatial data and related
    maps or graphics are not legal documents and are not intended to be used
    as such.

    The data and maps may not be used to determine title, ownership, legal
    descriptions or boundaries, legal jurisdiction, or restrictions that may be
    in place on either public or private land. Natural hazards may or may not be
    depicted on the data and maps, and land users should exercise due caution.
    The data are dynamic and may change over time. The user is responsible to
    verify the limitations of the geospatial data and to use the data
    accordingly.  These data were collected using funding from the U.S.
    Government and can be used without additional permissions or fees. If you
    use these data in a publication, presentation, or other research product
    please use the following citation:
    USDA Forest Service/US Geological Survey. Monitoring Trends in Burn Severity
    Thematic Burn Severity. Salt Lake City, Utah/Sioux Falls, South Dakota
  |||,
  summaries: {
    'gee:schema': [
      {
        name: 'Asmnt_Type',
        description: |||
          Assessment Type: Which mapping strategy is being used?

          "SS" means "Single Scene", or a mapping where just a post-fire image
          was used.

          * Initial
          * Extended
          * Initial (SS)
          * Extended (SS)
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'BurnBndAc',
        description: 'Burn boundary acreage.',
        type: ee_const.var_type.int,
      },
      {
        name: 'BurnBndLat',
        description: 'Latitude for burned area boundary centroid.',
        type: ee_const.var_type.string,
      },
      {
        name: 'BurnBndLon',
        description: 'Longitude for burned area boundary centroid.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Comment',
        description: 'Comments for delineated perimeter.',
        type: ee_const.var_type.string,
      },
      {
        name: 'dNBR_offst',
        description: 'dNBR offset calculated by the analyst.',
        type: ee_const.var_type.int,
      },
      {
        name: 'dNBR_stdDv',
        description: |||
          Standard deviation offset calculated by the the analyst.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'Event_ID',
        description: |||
          Unique identifier for each event (21 characters). Calculated from
          source data (ICS209, FedFire, etc.) each time an event is created
          or updated using the state, lat/long coordinates (ig_lat, ig_long).
          Note that for longitudes less than 100&deg; a leading zero is added
          to maintain 21 characters.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'High_T',
        description: |||
          High threshold: dNBR values above which, or NBR values below which
          a fire is considered High Severity by the analyst.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'Ig_Date',
        description: |||
          Date of ignition in Unix Epoch Time  (the number of milliseconds since
          1970-01-01T00:00:00Z).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'IncGreen_T',
        description: |||
          Increased greenness threshold: dNBR values above which, or NBR values
          below which an area is considered to have Increased greenness by
          the analyst.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'Incid_Name',
        description: 'Incident Name: common name of the event or "UNNAMED".',
        type: ee_const.var_type.string,
      },
      {
        name: 'Incid_Type',
        description: |||
          Type of event:

          * Wildfire
          * Prescribed Fire
          * Wildland Fire Use
          * Unknown
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'irwinID',
        description: |||
          Unique, alphanumeric identifier assigned to each incident record in
          [IRWIN](https://www.forestsandrangelands.gov/WFIT/applications/IRWIN/background.shtml)
           or an empty string.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'Low_T',
        description: |||
          Low threshold: dNBR values above which, or NBR values below which
          a fire is considered Low Severity by the analyst.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'Map_ID',
        description: 'Mapping ID (ID for a specific mapping activity).',
        type: ee_const.var_type.int,
      },
      {
        name: 'Map_Prog',
        description: |||
          Map Program: which program was this mapping activity completed by?
          E.g., `MTBS`'
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'Mod_T',
        description: |||
          Moderate threshold: dNBR values above which, or NBR values below which
          a fire is considered Moderate Severity by the analyst.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'NoData_T',
        description: |||
          Threshold for no data: dNBR values above which, or NBR values below
          which a fire is considered to represent No Data by the analyst.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'Perim_ID',
        description: |||
          Scene ID for perimeter scene. Perimeter scenes are scenes selected to
          help the analyst better identify the fire perimeter. Perimeter scenes
          are only selected when pre-fire and post-fire scenes are not
          sufficient to define a perimeter.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'Post_ID',
        description: |||
          Scene ID for pre-fire scene. If a pre-fire scene was not available
          at the time of mapping, the mapping analyst uses NBR from the
          post-fire scene to calculate severity.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'Pre_ID',
        description: 'Scene ID for pre-fire scene or an empty string.',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Fire boundaries',
        lookat: {
          lat: 39.255,
          lon: -105.277,
          zoom: 4,
        },
        polygon_visualization: {
          property_name: 'High_T',
          property_vis: {
            min: [
              0.0,
            ],
            max: [
              1.0,
            ],
            palette: ['ff0000']
          },
        },
      },
      {
        display_name: 'Fire boundaries',
        visualize_as: 'FeatureView',
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 2000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: 'BurnBndAc DESC',
      z_order_ranking: 'BurnBndAc DESC',
      prerender_tiles: true,
    },
  },
}

