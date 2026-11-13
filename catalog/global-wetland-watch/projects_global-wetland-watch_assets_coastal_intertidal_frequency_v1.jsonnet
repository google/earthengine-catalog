local id = 'projects/global-wetland-watch/assets/coastal/intertidal_frequency/v1';
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
  title: 'Global Wetland Watch Coastal Inundation Frequency v' + version,
  version: version,
  description: |||
    The Global Wetland Watch coastal inundation frequency dataset gives, for
    each coastal pixel, the percentage of valid Sentinel-2 observations in
    which the pixel was inundated, at 10 m resolution. Pixels that are
    sometimes inundated and sometimes exposed form the intertidal zone. Water
    is detected by adaptive thresholding of Sentinel-2 shortwave-infrared
    bands. The product is designed for open water and tidal flats, but may
    also be useful in other coastal settings.

    The product is masked to coastal wetland types as defined in the Global
    Wetland Watch annual wetland typology (maximum extent across all years),
    with a 100 m buffer.

    Two variants are provided, identified by the `tide_state` property:

    * `all-tide`: frequency computed from all valid observations.
    * `low-tide`: frequency computed only from observations acquired at
      relative low tide, as defined for the Global Wetland Watch tidal
      composites.

    Images cover the periods 2017&ndash;2019, 2020&ndash;2022 and
    2023&ndash;2025, and a 6-year 2017&ndash;2022 period where clouds, low
    light or sea ice limit observations; some areas have both. Filter on
    `period` before mosaicking so that periods are not mixed.

    **Possible Uses:**

    * **Intertidal zone mapping:** Delineating tidal flats and the extent of
      regular tidal inundation.
    * **Coastal hydrology:** Characterizing how often coastal areas are
      inundated.
    * **Change analysis:** Comparing periods to detect changes in intertidal
      extent due to erosion, accretion or land reclamation.

    **Limitations:**

    * **Observation sampling:** Sentinel-2 acquires images at fixed local
      times, so the observed tides may not cover the full tidal range. The
      frequency describes observed conditions, not true tidal exposure time.
    * **Observation density:** Use `observationCount` to mask pixels with too
      few observations.
    * **Inundation under vegetation:** The method detects open water, so
      inundation beneath vegetation may not be captured. Very turbid water
      may also be misclassified.
    * **Coastal wetland mask:** Values are only provided within the mapped
      coastal wetland extent plus a 100 m buffer, so omissions in the
      typology also limit this product.
    * **Coverage:** Global coastlines, excluding Antarctica.
  |||,
  'gee:categories': ['oceans', 'surface-ground-water'],
  keywords: [
    'blue_carbon',
    'coastal',
    'copernicus',
    'intertidal',
    'sentinel',
    'water',
  ],
  providers: [
    gww.producer,
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -59.0, 180.0, 84.0,
                    '2017-01-01T00:00:00Z', '2026-01-01T00:00:00Z'),
  summaries: {
    gsd: [10.0],
    platform: ['Sentinel-2A', 'Sentinel-2B'],
    instruments: ['MSI'],
    'eo:bands': [
      {
        name: 'inundationFrequency',
        description: 'Percentage of valid observations in which the pixel was inundated.',
        'gee:units': units.percent,
      },
      {
        name: 'observationCount',
        description: 'Number of valid observations.',
        'gee:units': units.count,
      },
    ],
    inundationFrequency: {minimum: 0, maximum: 100, 'gee:estimated_range': false},
    'gee:visualizations': [
      {
        display_name: 'Inundation frequency, all tides (%)',
        lookat: {lon: 8.6, lat: 53.7, zoom: 11},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [100],
            palette: ['f7fcb9', 'addd8e', '41ab5d', '1d91c0', '253494'],
            bands: ['inundationFrequency'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'tide_state',
        description: 'Observations used: all-tide or low-tide',
        type: ee_const.var_type.string,
      },
      {
        name: 'period',
        description: 'Period covered, e.g. 2017-2019',
        type: ee_const.var_type.string,
      },
      {
        name: 'period_years',
        description: 'Length of the period in years',
        type: ee_const.var_type.int,
      },
      {
        name: 'cell_id',
        description: 'Processing grid cell identifier',
        type: ee_const.var_type.int,
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 3,
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
