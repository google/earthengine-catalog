local id = 'IDAHO_EPSCOR/TERRACLIMATE';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/TERRACLIMATE_versions.libsonnet';

local subdir = 'IDAHO_EPSCOR';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local terraclimate = import 'templates/TERRACLIMATE.libsonnet';

local version_config = versions(subdir, version_table, id);
local version = version_config.version;

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
  title: terraclimate.title + ' v' + version + ' [deprecated]',
  version: version,
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    TerraClimate is a dataset of monthly climate and climatic water balance for
    global terrestrial surfaces. It uses climatically aided interpolation,
    combining high-spatial resolution climatological normals from the
    [WorldClim dataset](https://www.worldclim.org/), with coarser spatial
    resolution, but time-varying data from
    [CRU Ts4.0](https://data.ceda.ac.uk/badc/cru/data/cru_ts/) and the
    [Japanese 55-year Reanalysis (JRA55)](https://jra.kishou.go.jp/JRA-55/index_en.html).
    Conceptually, the procedure applies interpolated time-varying anomalies
    from CRU Ts4.0/JRA55 to the high-spatial resolution climatology of
    WorldClim to create a high-spatial resolution dataset that covers a broader
    temporal record.

    Temporal information is inherited from CRU Ts4.0 for most global land
    surfaces for temperature, precipitation, and vapor pressure. However,
    JRA55 data is used for regions where CRU data had zero climate stations
    contributing (including all of Antarctica, and parts of Africa,
    South America, and scattered islands). For primary climate variables of
    temperature, vapor pressure, and precipitation, the University of Idaho
    provides additional data on the number of stations (between 0 and 8) that
    contributed to the CRU Ts4.0 data used by TerraClimate. JRA55 was used
    exclusively for solar radiation and wind speeds.

    TerraClimate additionally produces monthly surface water balance datasets
    using a water balance model that incorporates reference evapotranspiration,
    precipitation, temperature, and interpolated plant extractable soil water
    capacity. A modified Thornthwaite-Mather climatic water-balance model and
    extractable soil water storage capacity data was used at a 0.5° grid from
    Wang-Erlandsson et al. (2016).

    Data Limitations:

     1. Long-term trends in data are inherited from parent datasets.
        TerraClimate should not be used directly for independent assessments of
        trends.

     2. TerraClimate will not capture temporal variability at finer scales than
        parent datasets and thus is not able to capture variability in
        orographic precipitation ratios and inversions.

     3. The water balance model is very simple and does not account for
        heterogeneity in vegetation types or their physiological response to
        changing environmental conditions.

     4. Limited validation in data-sparse regions (e.g., Antarctica).
  |||,
  license: terraclimate.license,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': terraclimate['gee:categories'],
  keywords: terraclimate.keywords,
  providers: terraclimate.providers(self_ee_catalog_url),
  extent: ee.extent_global('1958-01-01T00:00:00Z', null),
  summaries: terraclimate.summaries {
    'gee:schema': [
      {
        name: 'status',
        description: "'provisional' or 'permanent'",
        type: ee_const.var_type.string,
      },
    ],
    'eo:bands': terraclimate.bands,
    'gee:visualizations': terraclimate.visualizations,
  },
  'sci:citation': terraclimate.citation,
  'gee:interval': {
    type: 'cadence',
    unit: 'month',
    interval: 1,
  },
  'gee:terms_of_use': terraclimate.terms_of_use,
}
