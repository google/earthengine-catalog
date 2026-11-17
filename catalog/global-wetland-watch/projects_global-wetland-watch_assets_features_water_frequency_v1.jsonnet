local id = 'projects/global-wetland-watch/assets/features/water/frequency/v1';
local version = '1';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local gww = import 'gww.libsonnet';

local subdir = gww.subdir;
local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'Global Wetland Watch Surface Water Frequency v' + version,
  version: version,
  description: |||
    The surface water frequency dataset shows how often open surface water was
    observed at each 10 m pixel: the percentage of valid monthly observations
    classified as water. Annual images (one per year, 2017&ndash;2025) and a
    multiannual image (2017&ndash;2025) are provided; use the `product`
    property (`annual` or `multiannual`) and the `startYear` and `endYear`
    properties to select images.

    Monthly water maps are produced by fusing Sentinel-1 radar and Sentinel-2
    optical observations with regionally calibrated logistic regression
    models, adapted from
    [Druce et al. (2021)](https://doi.org/10.3390/rs13091663). Unlike in the
    original method, clouds are masked with Cloud Score+ and each month is
    summarized by its median rather than a best-available-pixel composite.
    To reduce false detections, the results are masked using the maximum
    wetland probability of the Global Wetland Watch wetland typology.

    **Possible Uses:**

    * **Seasonality:** Separating permanent water from seasonally inundated
      areas such as floodplains.
    * **Year-to-year variation:** Comparing annual images to identify wet and
      dry years and longer-term trends in surface water extent.
    * **Water storage:** Monitoring the extent of reservoirs and lakes.
    * **Floods and droughts:** Identifying unusually wet or dry years relative
      to the multiannual image.

    **Limitations:**

    * **Open water only:** Water beneath vegetation and saturated soils
      without visible open water are not detected.
    * **Not a maximum flood extent:** Monthly compositing smooths out
      short-lived floods, so the maximum flood extent is often larger.
    * **Commission errors:** False detections can occur over dark volcanic
      or arid sandy and rocky surfaces, mine sites, saturated organic soils,
      snow and ice, terrain shadow, and residual cloud or cloud shadow.
    * **Observation density:** Clouds, low winter light at high latitudes and
      image quality issues reduce the number of valid months (`count`), and
      frequencies based on few observations are less reliable.
    * **Accuracy:** The original method achieved 94% overall accuracy in
      mainland China (Druce et al., 2021); the global product has not been
      independently validated.
    * **Coverage:** Global, excluding Antarctica, Greenland and Russia. Some
      years are still in production in some regions: a missing year means no
      data yet, not no water.
  |||,
  'gee:categories': ['surface-ground-water'],
  keywords: [
    'copernicus',
    'global',
    'hydrology',
    'sentinel',
    'water',
  ],
  providers: [
    gww.producer,
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -57.0, 180.0, 84.0,
                    '2017-01-01T00:00:00Z', '2026-01-01T00:00:00Z'),
  summaries: {
    gsd: [10.0],
    platform: ['Sentinel-1A', 'Sentinel-1B', 'Sentinel-2A', 'Sentinel-2B'],
    instruments: ['C-SAR', 'MSI'],
    'eo:bands': [
      {
        name: 'swf',
        description: 'Surface water frequency: percentage of valid observations classified as open water.',
        'gee:units': units.percent,
      },
      {
        name: 'count',
        description: 'Number of valid monthly observations used to compute swf. Months can be masked because of clouds, low light (e.g. polar winter) or other image quality issues, so annual images do not always have 12 observations.',
        'gee:units': units.count,
      },
    ],
    swf: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Surface water frequency (2017-2025)',
        lookat: {lon: -122.02, lat: 37.48, zoom: 12},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: ['ffffff', 'e8e5fa', 'd0ccf5', 'bab3f1', '989be7', '6181d0', '3669ad',
                      '275186'],
            bands: ['swf'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'product',
        description: 'Aggregation type: annual or multiannual',
        type: ee_const.var_type.string,
      },
      {
        name: 'startYear',
        description: 'First year of the aggregation period',
        type: ee_const.var_type.int,
      },
      {
        name: 'endYear',
        description: 'Last year of the aggregation period (inclusive)',
        type: ee_const.var_type.int,
      },
      {
        name: 'duration',
        description: 'Length of the aggregation period in years',
        type: ee_const.var_type.int,
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'sci:citation': gww.citation,
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "Global Wetland Watch (DHI, UNEP-DHI, UNEP), 2026". It contains modified
    Copernicus Sentinel data (2017&ndash;2025).
  |||,
  'gee:status': 'beta',
  'gee:type': ee_const.gee_type.image_collection,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
}
