local id = 'MODIS/MCD43A1';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/MCD43A1_versions.libsonnet';

local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;
local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MCD43A1.005 BRDF-Albedo Model Parameters 16-Day L3 Global 500m [deprecated]',
  'gee:status': 'deprecated',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODerate-resolution Imaging Spectroradiometer
    (MODIS) BRDF/Albedo Model Parameters product (MCD43A1) contains datasets
    providing users with weighting parameters for the models used to derive the
    Albedo and BRDF products (MCD43A3 and MCD43A4). The models support the spatial
    relationship and parameter characterization best describing the differences in
    radiation due to the scattering (anisotropy) of each pixel, relying on
    multi-date, atmospherically corrected, cloud-cleared input data measured over
    16-day periods. Both Terra and Aqua data are used in the generation of this
    product, providing the highest probability for quality input data and
    designating it as an MCD, meaning Combined, product.

    Version-5 MODIS/Terra+Aqua BRDF/Albedo
    products are Validated Stage 1, meaning that accuracy has been
    estimated using a small number of independent measurements obtained
    from selected locations and time periods and ground-truth/field
    program efforts. Although there may be later improved versions, these
    data are ready for use in scientific publications.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    '16_day',
    'albedo',
    'brdf',
    'global',
    'mcd43a1',
    'modis',
    'reflectance',
    'usgs',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/mcd43a1'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('2000-02-18T00:00:00Z', '2017-03-14T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'BRDF Albedo Parameters',
        lookat: {
          lat: 31.052933985705163,
          lon: -7.03125,
          zoom: 2,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              255.0,
            ],
            bands: [
              'BRDF_Albedo_Parameters_Band1_iso',
              'BRDF_Albedo_Parameters_Band4_iso',
              'BRDF_Albedo_Parameters_Band3_iso',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 8,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  version: ee_const.version_unknown,
}
