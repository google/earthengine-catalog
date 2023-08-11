local id = 'JRC/GHSL/P2023A/GHS_BUILT_S';
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
  title: 'GHSL: Global Human Settlement Layers, Built-Up Surface Grid 1975-2030 (P2023A)',
  version: 'P2023A',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GHS-BUILT-S spatial raster dataset depicts the distribution of the
    built-up (BU) surface estimates between 1975 and 2030 in 5 year intervals.
    The data is made by spatial-temporal interpolation of five observed
    collections of multiple-sensor, multiple-platform satellite imagery datasets:
    Landsat (MSS, TM, ETM sensor) data supports the 1975, 1990, 2000, and 2014
    epochs, while a Sentinel-2 (S2) image composite (GHS-composite-S2 R2020A)
    supports the 2018 epoch.

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
    'multitemporal',
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_buS2023.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1975-01-01T00:00:00Z', '2030-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      38.0,
    ],
    'eo:bands': [
      {
        name: 'built_surface',
        description: 'Multitemporal Built-up Surface',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Multitemporal Built-up Surface',
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
              30.0,
            ],
            palette: [
              '000000',
              '400000',
              'a00000',
              '00ffff',
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
    Pesaresi M., Politis P. (2023):
    GHS-BUILT-S R2023A - GHS built-up surface grid, derived from Sentinel2
    composite and Landsat, multitemporal (1975-2030)European Commission,
    Joint Research Centre (JRC)
    PID: http://data.europa.eu/89h/9f06f36f-4b11-47ec-abb0-4f8b7b1d72ea
    [doi:10.2905/9F06F36F-4B11-47EC-ABB0-4F8B7B1D72EA](https://doi.org/10.2905/9F06F36F-4B11-47EC-ABB0-4F8B7B1D72EA)
  |||,
  'sci:doi': '10.2905/9F06F36F-4B11-47EC-ABB0-4F8B7B1D72EA',
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}
