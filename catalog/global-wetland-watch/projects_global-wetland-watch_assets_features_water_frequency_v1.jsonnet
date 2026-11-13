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
    The Global Wetland Watch surface water frequency dataset gives the
    proportion of valid monthly observations in which a pixel was classified
    as open surface water, at 10 m resolution. It is provided as annual
    products (one per year, 2017&ndash;2025) and a multiannual product
    (2017&ndash;2025).

    Each image has two bands: `swf`, the surface water frequency in percent, and
    `count`, the number of valid monthly observations used. Use the `product`
    property (`annual` or `multiannual`) and the `startYear` and `endYear`
    properties to select images.

    Monthly water maps are derived by fusing Sentinel-1 radar and Sentinel-2
    optical observations with regionally calibrated logistic regression
    models, adapted from
    [Druce et al. (2021)](https://doi.org/10.3390/rs13091663). Compared with that publication,
    cloud masking now uses Cloud Score+ and monthly observations are
    summarized by the median rather than a best-available-pixel composite.

    **Possible Uses:**

    * **Permanent and seasonal water:** Separating permanent water bodies from
      seasonally inundated areas and floodplains.
    * **Wetland hydrology:** Characterizing the hydroperiod of wetlands, in
      combination with the Global Wetland Watch wetland typology.
    * **Inter-annual variability:** Comparing annual products to identify wet
      and dry years and long-term changes in surface water extent.
    * **Water storage:** Monitoring changes in the water extent of reservoirs
      and lakes.
    * **Floods and droughts:** Characterizing unusually wet or dry years
      relative to the multiannual product.

    **Limitations:**

    * **Open water only:** The product represents open, non-vegetated surface
      water. Water under vegetation and saturated soils without visible open
      water are not captured.
    * **Not a maximum flood extent:** The product is derived from monthly
      composites, so short-lived floods are smoothed out. Maximum flood extent
      is often larger than shown here.
    * **Commission errors:** False water detections can occur over dark
      volcanic surfaces, dry sandy or rocky surfaces in arid regions (e.g.
      south-western Africa, parts of Australia and the western United
      States), saturated organic soils, snow and ice, terrain shadow, and
      residual cloud or cloud shadow.
    * **Observation density:** Monthly observations can be missing because
      of clouds, low light in high-latitude winters or image quality issues,
      so the number of observations (`count`) varies between pixels and
      years. Frequencies based on few observations are less reliable; mask
      pixels with low `count` where needed.
    * **Accuracy:** The original method achieved an overall accuracy of 94%
      against independent high-resolution reference imagery across mainland
      China (Druce et al., 2021). In an intercomparison of 14 surface water
      mapping approaches, combined optical and radar approaches performed
      best for large-scale mapping ([T&oslash;ttrup et al., 2022](https://doi.org/10.3390/rs14102410)). The current
      global product has not been independently validated.
    * **Coverage:** Global, excluding Antarctica, Greenland and Russia.
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
        lookat: {lon: -57.2, lat: -18.2, zoom: 9},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: ['ffffff', 'b3cde3', '6497b1', '005b96', '03396c'],
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
