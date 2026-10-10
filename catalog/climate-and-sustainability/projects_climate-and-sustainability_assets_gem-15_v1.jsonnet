local id = 'projects/climate-and-sustainability/assets/gem-15_v1';
local subdir = 'climate-and-sustainability';

local ee = import 'earthengine.libsonnet';
local ee_const = import 'earthengine_const.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';

local license = spdx.cc_by_4_0;
local basename = std.strReplace(id, '/', '_');
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
  title: 'GEM-15: Global Surface and Terrain Elevation Models (15m)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Google's Global Elevation Models at 15m (GEM-15) is a near-global elevation
    dataset at 15m grid spacing derived from sub-meter optical stereo satellite
    imagery. The dataset is built from optical stereo imagery acquired through
    2024 (primarily 2022&ndash;2024 30cm Pl&eacute;iades Neo imagery,
    supplemented by WorldView-2/3/4, GeoEye-1, Pl&eacute;iades 1A/1B, and 1.5m
    SPOT stereo imagery), aggregating native 0.5m DSM reconstructions and 1.0m
    DTM predictions to 15m resolution.

    Alongside the primary 15m Digital Surface Model (`dsm`), GEM-15 includes
    within-cell elevation percentiles (`dsm_percentile_5`, `dsm_percentile_50`,
    `dsm_percentile_95`), sub-grid elevation standard deviation (`dsm_std`), and
    a bare-earth Digital Terrain Model (`dtm`) predicted at 1.0m resolution
    using a deep learning model prior to aggregation. You can also explore the
    elevation layers interactively through the
    [GEM-15 Earth Engine App](https://climate-and-sustainability.projects.earthengine.app/view/gem-15).

    All elevation layers report orthometric heights in meters referenced to the
    EGM96 geoid vertical datum ([EPSG:5773](https://epsg.io/5773)) and are
    projected in local UTM zones at 15m pixel resolution.

    **Example Uses:**

    * **Flood and hydrological modeling:** Using the 15m bare-earth `dtm` and
      `dsm` layers for watershed delineation, river network extraction, and
      flood inundation modeling.
    * **Canopy and building height estimation:** Combining `dsm_percentile_95`
      (or `dsm`) with `dtm` to estimate above-ground building and forest canopy
      heights (`dsm - dtm`) and local vertical variability (`dsm_std`).
    * **Topographic analysis:** Using the 15m elevation layers for satellite
      imagery orthorectification and slope or aspect calculation.

    **Limitations:**

    * **Multi-temporal imagery:** Tiles are constructed from multi-view imagery
      across three sensor tiers: 60.4% of mapped tiles use 2022&ndash;2024 30cm
      Pl&eacute;iades Neo imagery, 24.6% use other sub-meter sensors
      (WorldView-2/3/4, GeoEye-1, Pl&eacute;iades 1A/1B), and 15.0% use 1.5m
      SPOT imagery. Temporal transitions can appear along acquisition
      boundaries.
    * **Coverage exclusions:** Coverage spans latitudes 60&deg;S to 84&deg;N and
      excludes Russia, China, Mongolia, Greenland, and Antarctica. India data is
      offset to comply with India Geospatial regulations.
    * **Water masking and voids:** Water bodies (plus a 9m buffer), snow/ice or
      desert stereo artifacts (~1&ndash;3% of cells), and pixels differing by
      more than 50m from Copernicus GLO-30 are masked as no-data.
    * **Dense forest canopy:** Because the elevations are derived from optical
      stereo imagery rather than LiDAR, bare-earth `dtm` accuracy is lower in
      dense rainforests where the ground is not visible from above.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  'gee:categories': ['elevation-topography'],
  keywords: [
    'dem',
    'elevation',
    'geophysical',
    'topography',
  ],
  providers: [
    ee.producer_provider('Google Research', 'https://research.google/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent(-179.0, -61.0, 180.0, 84.0,
                    '2020-01-01T00:00:00Z', '2024-12-31T23:59:59Z'),
  summaries: {
    gsd: [
      15.0,
    ],
    'eo:bands': [
      {
        name: 'dsm',
        description: 'Digital Surface Model (mean of native 0.5m surface elevation within each 15m cell)',
        'gee:units': units.meter,
      },
      {
        name: 'dsm_std',
        description: 'Standard deviation of native 0.5m surface elevation within each 15m cell',
        'gee:units': units.meter,
      },
      {
        name: 'dsm_percentile_5',
        description: '5th percentile of native 0.5m surface elevation within each 15m cell',
        'gee:units': units.meter,
      },
      {
        name: 'dsm_percentile_50',
        description: '50th percentile (median) of native 0.5m surface elevation within each 15m cell',
        'gee:units': units.meter,
      },
      {
        name: 'dsm_percentile_95',
        description: '95th percentile of native 0.5m surface elevation within each 15m cell',
        'gee:units': units.meter,
      },
      {
        name: 'dtm',
        description: 'Bare-earth Digital Terrain Model (15m)',
        'gee:units': units.meter,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Digital Surface Model (DSM)',
        lookat: {
          lon: 2.165,
          lat: 41.395,
          zoom: 14,
        },
        image_visualization: {
          band_vis: {
            min: [
              20.0,
            ],
            max: [
              100.0,
            ],
            bands: [
              'dsm',
            ],
            palette: [
              'fadd67',
              'b8b257',
              '7ca88f',
              '4aa4ca',
              '3869d1',
              '6f5bc8',
              'b862b0',
              'bc3a6b',
              'cb3438',
              'f08429',
              'fbd227',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Batchu, V. V., et al. (2026). GEM-15: Global surface and terrain elevation
    models (15 meters) from sub-meter optical stereo imagery.
  |||,
  'gee:terms_of_use': |||
    This dataset is licensed under
    [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) and requires the
    following attribution: "This dataset is produced by Google".
  |||,
}
