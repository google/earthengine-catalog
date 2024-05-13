local id = 'FIRMS';  // Warning: FIRMS/catalog.jsonnet has the same id.
local subdir = 'FIRMS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'FIRMS: Fire Information for Resource Management System',
  version: '6',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The Earth Engine version of the Fire Information for Resource Management
    System (FIRMS) dataset contains the LANCE fire detection product in
    rasterized form. The near real-time (NRT) active fire locations are
    processed by LANCE using the standard MODIS MOD14/MYD14 Fire and Thermal
    Anomalies product. Each active fire location represents the centroid of a
    1km pixel that is flagged by the algorithm as containing one or more fires
    within the pixel. The data are rasterized as follows: for each FIRMS active
    fire point, a 1km bounding box (BB) is defined; pixels in the MODIS
    sinusoidal projection that intersect the FIRMS BB are identified; if
    multiple FIRMS BBs intersect the same pixel, the one with higher confidence
    is retained; in case of a tie, the brighter one is retained.

    The data in the near-real-time dataset are not considered to be of science
    quality.

    Additional information can be found [here](https://earthdata.nasa.gov/earth-observation-data/near-real-time/firms/about-firms).

    NOTE: VIIRS FIRMS datasets from NOAA20 and SUOMI are also available:

    * [NASA/LANCE/NOAA20_VIIRS/C2](NASA_LANCE_NOAA20_VIIRS_C2)
    * [NASA/LANCE/SNPP_VIIRS/C2](NASA_LANCE_SNPP_VIIRS_C2)
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'eosdis',
    'fire',
    'firms',
    'geophysical',
    'hotspot',
    'lance',
    'modis',
    'nasa',
    'thermal',
  ],
  providers: [
    ee.producer_provider('NASA / LANCE / EOSDIS', 'https://earthdata.nasa.gov/earth-observation-data/near-real-time/firms'),
    ee.host_provider(self_ee_catalog_url),
  ],
  'gee:provider_ids': [
    'C1227495594-LANCEMODIS',
  ],
  extent: ee.extent_global('2000-11-01T00:00:00Z', null),
  summaries: {
    gsd: [
      1000.0,
    ],
    'eo:bands': [
      {
        name: 'T21',
        description: 'The brightness temperature of a fire pixel using MODIS channels 21/22.',
        'gee:units': units.kelvin,
      },
      {
        name: 'confidence',
        description: |||
          A detection confidence intended to help users gauge the
          quality of individual active fire pixels. The confidence estimate ranges
          between 0% and 100% for all fire pixels within the fire mask. The
          confidence field should be used with caution; it is likely that it will
          vary in meaning in different parts of the world.
        |||,
        'gee:units': units.percent,
      },
      {
        name: 'line_number',
        description: 'Line number in the FIRMS CSV file that the pixel came from.',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Fires',
        lookat: {
          lat: 7.71,
          lon: 17.93,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              325.0,
            ],
            max: [
              400.0,
            ],
            palette: [
              'red',
              'orange',
              'yellow',
            ],
            bands: [
              'T21',
            ],
          },
        },
      },
    ],
    T21: {
      minimum: 300.0,
      maximum: 509.29,
      'gee:estimated_range': true,
    },
    confidence: {
      minimum: 0.0,
      maximum: 100.0,
      'gee:estimated_range': false,
    },
    line_number: {
      minimum: 1.0,
      maximum: 35302.0,
      'gee:estimated_range': true,
    },
  },
  'sci:citation': |||
    MODIS Collection 6 NRT Hotspot / Active Fire Detections MCD14DL.
    Available on-line [https://earthdata.nasa.gov/firms](https://earthdata.nasa.gov/firms).
    [doi:10.5067/FIRMS/MODIS/MCD14DL.NRT.006](https://doi.org/10.5067/FIRMS/MODIS/MCD14DL.NRT.006)
  |||,
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    NASA promotes the full and open sharing of all data with the research and
    applications communities, private industry, academia, and the general
    public. Read the [NASA Data and Information Policy]
    (https://www.earthdata.nasa.gov/learn/use-data/data-use-policy).

    If you provide the
    [Land, Atmosphere Near real-time Capability for EOS (LANCE) / Fire Information for Resource Management System (FIRMS)](https://earthdata.nasa.gov/earth-observation-data/near-real-time)
    data to a third party, follow the guidelines in the
    [LANCE Citation, Acknowledgements, and Disclaimer](https://earthdata.nasa.gov/earth-observation-data/near-real-time/citation#ed-lance-disclaimer)
    site and replicate or provide a link to the
    [disclaimer](https://earthdata.nasa.gov/earth-observation-data/near-real-time/citation#ed-lance-disclaimer).
  |||,
}
