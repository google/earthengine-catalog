local id = 'JRC/GHSL/P2023A/GHS_BUILT_S';
local versions = import 'versions.libsonnet';
local version_table = import 'templates/jrc_ldsmt_versions.libsonnet';

local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';
local units = import 'units.libsonnet';
local version_config = versions(subdir, version_table, id);
local version = version_config.version;

local license = spdx.proprietary;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'GHSL: Global built-up surface 1975-2030 (P2023A)',
  version: version,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This raster dataset depicts the distribution of built-up surfaces,
    expressed in square metres per 100 m grid cell.
    The dataset measures:
    a) the total built-up surface, and b) the built-up surface allocated to grid
    cells of predominant non-residential (NRES) use. Data are
    spatially-temporally interpolated or extrapolated from 1975 to 2030 in 5
    year intervals.

    The complete information about the GHSL main products can be
    found in the [GHSL Data Package 2023 report]
    (https://ghsl.jrc.ec.europa.eu/documents/GHSL_Data_Package_2023.pdf?t=1683540422)

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Centre, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + version_config.version_links,
  keywords: [
    'built',
    'builtup',
    'ghsl',
    'jrc',
    'landsat_derived',
    'sentinel2_derived',
    'copernicus',
    'landcover',
    'settlement',
    'sdg',
    'urban',
    'built_environment',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_buS2023.php'),
    ee.host_provider(version_config.ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2030-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'built_surface',
        description: 'Built-up surface per grid cell',
        'gee:units': units.area
      },
      {
        name: 'built_surface_nres',
        description: 'Non-residential built-up surface per grid cell',
        'gee:units': units.area
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Built-up surface per grid cell in square metres',
        lookat: {
          lat: 75,
          lon: 28,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              8000.0,
            ],
            palette: [
              '000000',
              'ffffff',
            ],
            bands: [
              'built_surface',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Pesaresi, Martino; Politis, Panagiotis (2023): GHS-BUILT-S R2023A - GHS
    built-up surface grid, derived from Sentinel2 composite and Landsat,
    multitemporal (1975-2030). European Commission, Joint Research Centre (JRC)
    [PID: http://data.europa.eu/89h/9f06f36f-4b11-47ec-abb0-4f8b7b1d72ea](http://data.europa.eu/89h/9f06f36f-4b11-47ec-abb0-4f8b7b1d72ea)
    [doi:10.2905/9F06F36F-4B11-47EC-ABB0-4F8B7B1D72EA](https://doi.org/10.2905/9F06F36F-4B11-47EC-ABB0-4F8B7B1D72EA)
  |||,
  'sci:doi': '10.2905/9F06F36F-4B11-47EC-ABB0-4F8B7B1D72EA',
  'gee:terms_of_use': |||
    The GHSL has been produced by the European Commission Joint Research Centre
    as open and free data. Reuse is authorised, provided the source is
    acknowledged. For more information, please read the use conditions ([European
    Commission Reuse and Copyright Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}
