local id = 'projects/global-wetland-watch/assets/coastal/tidal_composites/v1';
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

local s2_band(name, desc, wl) = {
  name: name,
  description: desc,
  'gee:units': units.dn,
  'gee:scale': 0.0001,
  'gee:wavelength': wl,
};

{
  id: id,
  title: 'Global Wetland Watch Sentinel-2 High- and Low-Tide Coastal Composites v' + version,
  version: version,
  description: |||
    The Global Wetland Watch tidal composites are Sentinel-2 surface
    reflectance composites of the world's coasts, built separately from
    observations acquired at high tide and at low tide. Together they show the
    coastal zone both when the intertidal area is exposed and when it is
    inundated.

    Each Sentinel-2 observation is assigned a relative tidal state using
    predicted tide heights from the
    [MIKE 21 Global Tide Model](https://www.mikepoweredbydhi.com/download/mike-by-dhi-tools/coastandseatools/global-tide-model)
    (DHI), based on the DTU10 global ocean tide model of the Technical University of
    Denmark. High-tide observations are those more than one standard deviation
    above the mean predicted tide height, and low-tide observations those
    more than one standard deviation below it. After cloud masking with Cloud
    Score+, each subset is summarized as a geometric median
    ([Roberts et al., 2017](https://doi.org/10.1109/TGRS.2017.2723896)), which preserves the spectral relationships between bands.

    Composites cover 3-year periods (2017&ndash;2019, 2020&ndash;2022 and
    2023&ndash;2025), or a single 6-year period (2017&ndash;2022) where
    clouds, low light or sea ice limit observations. In Arctic regions, only
    June to November observations are used; the `months` image property
    records the months used (`6-11` or `1-12`). Each tile has either the 6-year
    composite or the 3-year composites, never both, so a 3-year period has
    no coverage in tiles that use the 6-year period. Use the `tide_state`
    (`high` or `low`) and `period` image properties to select images.

    **Possible Uses:**

    * **Intertidal mapping:** Contrasting low- and high-tide composites to
      delineate intertidal flats and the extent of tidal inundation.
    * **Coastal wetland classification:** As inputs for mapping mangroves,
      salt marshes, seagrass and tidal flats, including for blue carbon
      assessments.
    * **Shoreline change:** Comparing periods to assess coastal erosion and
      accretion.

    **Limitations:**

    * **Relative tidal state:** Tidal states are relative to the predicted
      tides at each location, not absolute water levels.
    * **Seasonal effects:** High- and low-tide observations can fall in
      different seasons, so differences between the composites may reflect
      seasonal changes (e.g. in vegetation, snow or water turbidity) rather
      than tides.
    * **Image quality:** Residual cloud, haze and shadow can remain, and the
      number of observations (`count`) varies, especially in persistently
      cloudy tropical regions and at high latitudes.
    * **Coastal domain:** Only the coastal zone is covered: coastal river
      basins, areas within 100 km of the coast or below 50 m elevation, and a
      15 km offshore buffer.
    * **Coverage:** Global coastlines, excluding Antarctica.
  |||,
  'gee:categories': ['satellite-imagery', 'oceans'],
  keywords: [
    'blue_carbon',
    'coastal',
    'copernicus',
    'intertidal',
    'msi',
    'reflectance',
    'sentinel',
  ],
  providers: [
    gww.producer,
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-180.0, -59.0, 180.0, 83.0,
                    '2017-01-01T00:00:00Z', '2026-01-01T00:00:00Z'),
  summaries: {
    gsd: [10.0],
    platform: ['Sentinel-2A', 'Sentinel-2B'],
    instruments: ['MSI'],
    'eo:bands': [
      s2_band('B2', 'Blue', '496.6nm (S2A) / 492.1nm (S2B)'),
      s2_band('B3', 'Green', '560nm (S2A) / 559nm (S2B)'),
      s2_band('B4', 'Red', '664.5nm (S2A) / 665nm (S2B)'),
      s2_band('B8', 'Near infrared', '835.1nm (S2A) / 833nm (S2B)'),
      s2_band('B11', 'Shortwave infrared 1', '1613.7nm (S2A) / 1610.4nm (S2B)'),
      s2_band('B12', 'Shortwave infrared 2', '2202.4nm (S2A) / 2185.7nm (S2B)'),
      s2_band('B5', 'Red Edge 1', '703.9nm (S2A) / 703.8nm (S2B)'),
      s2_band('B6', 'Red Edge 2', '740.2nm (S2A) / 739.1nm (S2B)'),
      s2_band('B7', 'Red Edge 3', '782.5nm (S2A) / 779.7nm (S2B)'),
      s2_band('B8A', 'Red Edge 4', '864.8nm (S2A) / 864nm (S2B)'),
      {
        name: 'count',
        description: 'Number of valid observations in the composite.',
        'gee:units': units.count,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Low-tide true color',
        lookat: {lon: 8.6, lat: 53.7, zoom: 11},
        image_visualization: {
          band_vis: {
            min: [0],
            max: [2500],
            bands: ['B4', 'B3', 'B2'],
          },
        },
      },
    ],
    'gee:schema': [
      {
        name: 'tide_state',
        description: 'Tidal state of the composite: high or low',
        type: ee_const.var_type.string,
      },
      {
        name: 'period',
        description: 'Compositing period, e.g. 2017-2019',
        type: ee_const.var_type.string,
      },
      {
        name: 'start',
        description: 'First year of the compositing period',
        type: ee_const.var_type.int,
      },
      {
        name: 'end',
        description: 'Last year of the compositing period (inclusive)',
        type: ee_const.var_type.int,
      },
      {
        name: 'tile',
        description: 'Sentinel-2 Military Grid Reference System (MGRS) tile',
        type: ee_const.var_type.string,
      },
      {
        name: 'months',
        description: 'Months of the year used in the composite: 6-11 (June to November, Arctic tiles) or 1-12 (all months)',
        type: ee_const.var_type.string,
      },
      {
        name: 'cs',
        description: 'Cloud Score+ threshold used for cloud masking',
        type: ee_const.var_type.double,
      },
      {
        name: 'cs_cdf',
        description: 'Cloud Score+ cumulative distribution (cs_cdf) threshold used for cloud masking',
        type: ee_const.var_type.double,
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
