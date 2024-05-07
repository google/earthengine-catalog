local id = 'JRC/GHSL/P2023A/GHS_BUILT_V';
local subdir = 'JRC';

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
  title: 'GHSL: Global building volume 1975-2030 (P2023A)',
  version: 'P2023A',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This raster dataset depicts the global distribution of building volume,
    expressed in cubic metres per 100 m grid cell. The dataset measures the
    total building volume and the building volume allocated to grid cells of
    predominant non-residential (NRES) use. Estimates are based on the [built-up
    surface](https://developers.google.com/earth-engine/datasets/catalog/JRC_GHSL_P2023A_GHS_BUILT_S)
    and [building height](https://developers.google.com/earth-engine/datasets/catalog/JRC_GHSL_P2023A_GHS_BUILT_H)
    products.

    More information about the GHSL data products can be found in the [GHSL Data
    Package 2023 report](https://ghsl.jrc.ec.europa.eu/documents/GHSL_Data_Package_2023.pdf?t=1683540422)

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Centre, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'ghsl',
    'jrc',
    'dem',
    'alos',
    'srtm',
    'sentinel2_derived',
    'copernicus',
    'building',
    'sdg',
    'urban',
    'built_environment',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_buV2023.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2030-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'built_volume_total',
        description: 'Total building volume per grid cell',
        'gee:units': units.volume,
      },
      {
        name: 'built_volume_nres',
        description: 'Non-residential building volume per grid cell',
        'gee:units': units.volume,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total building volume per grid cell in cubic meters',
        lookat: {
          lat: 77.15,
          lon: 28.65,
          zoom: 10,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              80000,
            ],
            palette: [
              '000000',
              '400000',
              'a00000',
              '00ffff',
            ],
            bands: [
              'built_volume_total',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Pesaresi, Martino; Politis, Panagiotis (2023): GHS-BUILT-V R2023A - GHS
    built-up volume grids derived from joint assessment of Sentinel2, Landsat,
    and global DEM data, multitemporal (1975-2030). European Commission, Joint
    Research Centre (JRC)
    [PID: http://data.europa.eu/89h/ab2f107a-03cd-47a3-85e5-139d8ec63283](http://data.europa.eu/89h/ab2f107a-03cd-47a3-85e5-139d8ec63283)
    [doi:10.2905/AB2F107A-03CD-47A3-85E5-139D8EC63283](https://doi.org/10.2905/AB2F107A-03CD-47A3-85E5-139D8EC63283)
  |||,
  'sci:doi': '10.2905/AB2F107A-03CD-47A3-85E5-139D8EC63283',
  'gee:terms_of_use': |||
    The GHSL has been produced by the European Commission Joint Research Centre
    as open and free data. Reuse is authorised, provided the source is
    acknowledged. For more information, please read the use conditions ([European
    Commission Reuse and Copyright Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}
