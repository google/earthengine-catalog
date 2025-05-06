local id = 'FAO/GAEZv5/HWSDv2';
local subdir = 'FAO';

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
  title: 'The Harmonized World Soil Database version 2.0',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
		The Harmonized World Soil Database version 2.0 (HWSD v2.0) is developed by FAO and IIASA 
		as a unique global soil inventory providing information on the morphological, chemical and 
		physical properties of soils at approximately 1 km resolution. Its main objective is to serve 
		as a basis for prospective studies on agro-ecological zoning, food security and climate change.
		
		This updated version (HWSD v2.0) is built on the previous versions of HWSD with several improvements 
		on (i) the data source that now includes several national soil databases, (ii) an enhanced number of 
		soil attributes available for seven soil depth layers, instead of two in HWSD v1.2, and (iii) a common 
		soil reference for all soil units (FAO1990 and the World Reference Base for Soil Resources). This 
		contributes to a further harmonization of the database. 
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
	'global',
	'soil-classification',
    'soil-properties',
	'soil-surveys',
	'soil-types'
  ],
  providers: [
    ee.producer_provider('FAO-GAEZ', 'https://data.apps.fao.org/catalog/organization/about/fao-gaez'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2022-01-01', '2022-12-31'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'polygonID',
        description: 'polygonID of the target pixel, which is the index of finding more information from the HWSDv2 dataset',
        'gee:units': 'none',
      },
      {
        name: 'DominantSoilType',
        description: 'dominant soil type, which provides color information for map visualization',
        'gee:units': 'none',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'HWSDv2',
        lookat: {
          lat: -0.4,
          lon: 108.0,
          zoom: 6,
        },
        image_visualization: {
          global_vis: {
			min: [
              1,
            ],
            max: [
              34,
            ],
            palette: [
              'ffffbe',
			  '730000',
			  'f79804',
			  'f2f2f2',
			  '40c0e9',
			  'fe0000',
			  '4b3dac',
			  'f5d4a1',
			  '8083d9',
			  'cf9804',
			  '914d35',
			  'fef400',
			  'febe00',
			  '00fefd',
			  'bd6446',
			  'fe00fa',
			  'ff8721',
			  'd4d4d4',
			  'fef6a4',
			  '706b66',
			  '383838',
			  'ca937f',
			  'd1d1d1',
			  'fa8484',
			  'ffbebe',
			  'ffa77f',
			  'fec2c2',
			  'f77d3a',
			  '0cd900',
			  'fee3a4',
			  'f9c2fe',
			  '91009d',
			  'c930fd',
			  '4752dc',
            ],
            bands: [
              'DominantSoilType',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
	[FAO & IIASA. 2023. Harmonized World Soil Database version 2.0. Rome and Laxenburg.]
	(https://doi.org/10.4060/cc3823en)
  |||,
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
		All rights reserved. No part of this Harmonized World Soil Database may be reproduced, 
		stored in a retrieval system or transmitted by any means for resale or other commercial 
		purposes without written permission of the copyright holders. Reproduction and dissemination 
		of material in this information product for educational or other noncommercial purposes are 
		authorized without any prior written permission from the copyright holders provided the source 
		is fully acknowledged. 
  |||,
  'gee:user_uploaded': true,
}