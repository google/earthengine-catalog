local id = 'JRC/GHSL/P2023A/GHS_BUILT_H';
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
  title: 'GHSL: Global building height 2018 (P2023A)',
  version: 'P2023A',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This spatial raster dataset depicts the global distribution of building
    heights at a resolution of 100 m, referred to the year 2018. The input data
    used to predict building heights are the ALOS Global Digital Surface Model
    (30 m), the NASA Shuttle Radar Topographic Mission data (30 m), and a global
    Sentinel-2 image composite from L1C data for the period 2017-2018.

    More information about the GHSL data products can be found in the
    [GHSL Data Package 2023 report]
    (https://ghsl.jrc.ec.europa.eu/documents/GHSL_Data_Package_2023.pdf?t=1683540422),
    where the building height layer is referred to as the Average Net Building
    Height (ANBH).

    The Global Human Settlement Layer (GHSL) project is supported by the
    European Commission, Joint Research Centre, and Directorate-General for
    Regional and Urban Policy.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'built',
    'builtup',
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
    'height',
    'built_environment'
  ],
  providers: [
    ee.producer_provider('EC JRC', 'https://ghsl.jrc.ec.europa.eu/ghs_buH2023.php'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-01-01T00:00:00Z', '2018-12-31T00:00:00Z'),
  summaries: {
    gsd: [
      100.0,
    ],
    'eo:bands': [
      {
        name: 'built_height',
        description: 'Average building height per grid cell',
        'gee:units': units.meter
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Average building height per grid cell in meters',
        lookat: {
          lat: 74,
          lon: 31,
          zoom: 8,
        },
        image_visualization: {
          band_vis: {
            min: [
              0.0,
            ],
            max: [
              0.5,
            ],
            palette: [
              '000000',
              '400000',
              'a00000',
              '00ffff',
            ],
            bands: [
              'built_height',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    Pesaresi, Martino; Politis, Panagiotis (2023): GHS-BUILT-H R2023A - GHS
    building height, derived from AW3D30, SRTM30, and Sentinel2 composite
    (2018). European Commission, Joint Research Centre (JRC)
    [PID: http://data.europa.eu/89h/85005901-3a49-48dd-9d19-6261354f56fe](http://data.europa.eu/89h/85005901-3a49-48dd-9d19-6261354f56fe)
    [doi:10.2905/85005901-3A49-48DD-9D19-6261354F56FE](https://doi.org/10.2905/85005901-3A49-48DD-9D19-6261354F56FE)
    
  |||,
  'sci:doi': '10.2905/85005901-3A49-48DD-9D19-6261354F56FE',
  'gee:terms_of_use': |||
    The GHSL has been produced by the European Commission Joint Research Centre
    as open and free data. Reuse is authorised, provided the source is
    acknowledged. For more information, please read the use conditions ([European
    Commission Reuse and Copyright Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}
