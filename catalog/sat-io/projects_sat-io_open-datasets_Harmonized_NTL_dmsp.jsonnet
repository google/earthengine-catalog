local id = 'projects/sat-io/open-datasets/Harmonized_NTL/dmsp';
local subdir = 'sat-io';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.cc_by_4_0;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  // TODO: remove 'gee:skip_indexing'
  'gee:skip_indexing': true,
  'gee:user_uploaded': true,
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Harmonized Global Night Time Lights DMSP',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    This dataset comprises nighttime light (NTL) data sourced from the Defense Meteorological Satellite Program (DMSP)/Operational Linescan System (OLS) and the Visible Infrared Imaging Radiometer Suite (VIIRS) on the Suomi National Polar-orbiting Partnership satellite, offering comprehensive insights into human activities on both regional and global scales. While prior records of nocturnal illumination from DMSP (1992–2013) and VIIRS (2012–2018) exist, the historical NTL archive has remained underutilized due to substantial disparities between DMSP and VIIRS data. In this research endeavor, we have developed a consolidated and uniform NTL dataset at a global scope by harmonizing inter-calibrated NTL observations from DMSP and simulated DMSP-like NTL observations from VIIRS. This newly generated DMSP NTL time-series dataset, spanning from 1992 to 2018, exhibits coherent temporal patterns, presenting a valuable resource for diverse studies related to human activities, including electricity consumption and urban expansion dynamics.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'nighttime light',
    'calibration',
    'VIIRS',
    'DMSP
  ],
  providers: [
    ee.producer_provider('Nature Scientific Data', 'https://www.nature.com'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1992-01-01T00:00:00Z', '2013-12-31T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'country',
        description: 'Country',
        type: ee_const.var_type.string,
      },
      {
        name: 'year',
        description: 'Year',
        type: ee_const.var_type.double,
      },
    ],
    gsd: [
      1000,
    ],
    'eo:bands': [
      {
        name: 'b1',
        description: 'DN',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Harmonized DN Night Time Lights DMSP',
        lookat: {
          lat: 48.2875,
          lon: 31.175,
          zoom: 5,
        },
        image_visualization: {
          band_vis: {
            min: [
               50,
            ],
            max: [
              63,
            ],
            bands: [
              'b1',
            ],
            palette:["4d4d4d", "878787", "bababa", "e0e0e0", "ffffff", "fddbc7", "f4a582", "d6604d", "b2182b", "67001f"],
          },
        },
      },
    ],
    b1: {
      minimum: 3,
      maximum: 63,
      'gee:estimated_range': true,
    },
  },
  'sci:citation':|||
        Li, Xuecao; Zhou, Yuyu; zhao, Min; Zhao, Xia (2020). Harmonization of DMSP and VIIRS nighttime light data from 1992-2021 at the global scale. figshare. Dataset. https://doi.org/10.6084/m9.figshare.9828827.v7
  |||,
  'sci:doi': 'm9.figshare.9828827.v7',
  'gee:terms_of_use': |||
    Harmonized NTL datasets are licensed under the Creative Commons Attribution 4.0
    International License. Users are free to use, copy, distribute, transmit,
    and adapt the work for commercial and non-commercial purposes, without
    restriction, as long as clear attribution of the source is provided.
  |||,
}
