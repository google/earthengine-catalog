local id = 'JRC/GHSL/P2023A/GHS_BUILT_V';
local subdir = 'JRC';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

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
  title: 'GHSL: Global Human Settlement Layers, Built-Up Volume Grid 1975-2030 (P2023A)',
  version: 'P2023A',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GHS-BUILT-V spatial raster dataset depicts the distribution of the
    built-up volumes, expressed as number in cubic meters. The dataset contains two
    bands: the total built-up volume and the built-up volume allocated to dominant
    nonresidential (NRES).

    The data is made by spatial-temporal interpolation of satellite imagery:
    Landsat (MSS, TM, ETM sensor) data supports the 1975, 1990, 2000, and 2014
    epochs, while a Sentinel-2 (S2) image composite (GHS-composite-S2 R2020A)
    supports the 2018 epoch. In the intermediate epochs not covered by direct
    satellite observations, in areas not covered by satellite imagery
    (i.e. satellite data gaps in the 1975 epoch), or in the future epochs 2025
    and 2030, the BU prediction is created by spatial-temporal interpolation
    or extrapolation based on a rank-optimal spatial allocation method.

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Center, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'built',
    'builtup',
    'ghsl',
    'jrc',
    'landsat_derived',
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
        description: 'Total (Residential and Non-Residential) Built-up Volume',
      },
      {
        name: 'built_volume_nres',
        description: 'Non-Residential Built-up Volume',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Total (Residential and Non-Residential) Built-up Volume',
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
    Pesaresi, Martino; Politis, Panagiotis (2023):
    GHS-BUILT-V R2023A - GHS built-up volume grids derived from joint assessment
    of Sentinel2, Landsat, and global DEM data, multitemporal (1975-2030).
    European Commission, Joint Research Centre (JRC) [Dataset]
    PID: http://data.europa.eu/89h/ab2f107a-03cd-47a3-85e5-139d8ec63283
    [doi:10.2905/AB2F107A-03CD-47A3-85E5-139D8EC63283](https://doi.org/10.2905/AB2F107A-03CD-47A3-85E5-139D8EC63283)
  |||,
  'sci:doi': '10.2905/AB2F107A-03CD-47A3-85E5-139D8EC63283',
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}