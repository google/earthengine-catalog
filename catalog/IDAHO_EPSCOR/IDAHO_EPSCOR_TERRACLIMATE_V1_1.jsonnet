local id = 'IDAHO_EPSCOR/TERRACLIMATE_V1_1';
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
  title: terraclimate.title + ' v' + version,
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    TerraClimate is a dataset of monthly climate and climatic water balance for
    global terrestrial surfaces from 1950-present. It provides important inputs
    for ecological and hydrological studies at global scales that require high
    spatial resolution and time-varying data. All data have monthly temporal
    resolution and a ~4-km (1/24th degree) spatial resolution.

    TerraClimate uses climatically aided interpolation, combining high-spatial
    resolution climatological normals from the 
    [WorldClim dataset](http://worldclim.org/version2) with coarser spatial
    resolution time-varying data. TerraClimate v1.1 uses time-varying data
    solely from
    [ERA5](https://cds.climate.copernicus.eu/datasets/reanalysis-era5-single-levels?tab=overview). 
    Conceptually, the procedure applies interpolated time-varying anomalies to 
    the high-spatial resolution climatology of WorldClim to create a 
    high-spatial resolution dataset that covers a broader temporal record.

    Key improvements and changes in v1.1:

    1. TerraClimate now uses climatically aided interpolation from ERA5 
       reanalyses monthly anomalies superposed with high-spatial resolution 
       climatological normals from the WorldClim version 1.4 and version 2 
       datasets to extend the start date farther back, to 1950.

    2. Reference evapotranspiration is calculated using a modified 
       Penman-Monteith approach that accounts for rising carbon dioxide 
       concentrations 
       ([Yang et al., 2018](https://www.nature.com/articles/s41558-018-0361-0)).

    3. Runoff calculations now account for carryover contributions of surplus 
       month to month 
       ([Wolock and McCabe 1999](https://iopscience.iop.org/article/10.1088/2976-601X/adacec/meta#erfsadacecbib46)).
       An rfractor of 0.5 is applied, also see 
       [Kinnebrew et al., (2025)](https://iopscience.iop.org/article/10.1088/2976-601X/adacec/meta).

    4. We have updated the +2C and +4C scenarios of TerraClimate using pattern 
       scaling from a multimodel average from GCM participating in CMIP6.

    5. We have produced a counterfactual climate scenario that removes the 
       influence of modeled climate change on the observed data during 
       1950-2025.

    Data Limitations:

    1. Long-term trends in data are inherited from parent datasets.
       TerraClimate should not be used directly for independent assessments of
       trends.

    2. TerraClimate will not capture temporal variability at finer scales than
       parent datasets and thus is not able to capture variability in
       orographic precipitation ratios and inversions.

    3. The water balance model is simple and does not account for
       heterogeneity in vegetation types.

    4. Limited validation in data-sparse regions (e.g., Antarctica).

    5. Likely unrealistic extrapolation of winter inversions into high
       elevations in boreal systems (e.g., Alaska) inherited from WorldClim 
       v2.1.

    6. We do not recommend mixing data from TerraClimate v1.0 with
       TerraClimate v1.1.
  |||,
  license: terraclimate.license,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  'gee:categories': terraclimate['gee:categories'],
  keywords: terraclimate.keywords,
  providers: terraclimate.providers(self_ee_catalog_url),
  extent: ee.extent_global('1950-01-01T00:00:00Z', null),
  summaries: terraclimate.summaries {
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
