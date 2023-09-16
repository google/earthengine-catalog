local id = 'JRC/GHSL/P2023A/GHS_BUILT_H';
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
  title: 'GHSL: Global Human Settlement Layers, Built-Up Height 2018 (P2023A)',
  version: 'P2023A',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The GHS-BUILT-H spatial raster dataset contains building heights as
    extracted from the filtering of a composite of global digital elevation
    models (DEM) and the filtering of satellite imagery using linear regression
    techniques.

    The used input DEMs are the ALOS World 3D - 30m (AW3D30, 2006-2011) and the
    Shuttle Radar Topography Mission 30m (SRTM30, 2000). The building heights
    extracted from these sources are updated using the support of the shadow
    markers extracted from the Sentinel2 image data composite of the year 2018
    (GHS-composite-S2 R2020A).

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
        description: 'Multitemporal Built-up Height',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Multitemporal Built-up Height',
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
    Pesaresi, Martino; Politis, Panagiotis (2023):
    GHS-BUILT-H R2023A - GHS building height, derived from AW3D30, SRTM30, and
    Sentinel2 composite (2018). European Commission, Joint Research Centre (JRC)
    PID: http://data.europa.eu/89h/85005901-3a49-48dd-9d19-6261354f56fe
    [doi:10.2905/85005901-3A49-48DD-9D19-6261354F56FE](https://doi.org/10.2905/85005901-3A49-48DD-9D19-6261354F56FE)
  |||,
  'sci:doi': '10.2905/85005901-3A49-48DD-9D19-6261354F56FE',
  'gee:terms_of_use': |||
    The GHSL has been produced by the EC JRC as open and free data. Reuse is
    authorised, provided the source is acknowledged. For more information,
    please read the use conditions ([European Commission Reuse and Copyright
    Notice](https://ec.europa.eu/info/legal-notice_en)).
  |||,
}