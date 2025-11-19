local id = 'FAO/GHG/1/DROS-A';
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
  title: 'UN FAO Drained Organic Soils (Area, Annual)',
  version: '2.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
			The UN FAO DRained Organic Soils Area (DROS-A) dataset disseminates annual estimates of the area of cropland and grassland organic soils that are drained 
		for agricultural activities. This image collections consists of 2 bands:
		  1. Drained area under cropland organic soils.
		  2. Drained area under grazed grassland organic soils.
			Values are expressed in hectares (ha) and are available for the period 1992–2020. The data is available globally at a 
		resolution of 0.0083333 X 0.0083333 degrees (~1 km at the equator). This image collection is accompanied by the DROS-Emissions (DROS-E) dataset which disseminates the annual greenhouse gas (GHG) emissions that are associated with the drainage of organic soils, in a separate image collection.
			The GHG emissions from drained organic soils dataset are computed in the Google Earth Engine (GEE) platform applying Tier I methods 
		from the Intergovernmental Guidelines on Climate Change (IPCC) (IPCC, 2014). The FAO estimates use the distribution of histosols as a proxy for the presence of organic 
		soils, in agreement with IPCC, and annual land cover maps as time-dependent components for yearly cropland and grassland extents. Finally, a geospatial layer of the distribution of ruminants from the FAO Gridded Livestock of the World was used to identify the grassland that is grazed.
			Organic soils are wet soils ecosystems, characterized by high levels of organic matter, which accumulates under the anoxic conditions 
		that exist in the presence of water. They include tropical and boreal peatlands, high-latitude bogs, ferns and mires. While organic soils 
		cover globally a mere 3 percent of the terrestrial land area, they represent up to 30 percent of the total soil carbon, playing an 
		important role in maintaining the earth’s carbon balance. Agriculture is a major cause of drainage of organic soils around the world and 
		restoration of degraded organic soils is currently a priority in several countries as part of their commitments under the climate convention.
			DROS-A and DROS-E are the basis for the country, regional and global statistics on drained organic soils that are disseminated in FAOSTAT (FAO 2020, 2022). This ‘DROS-A’ asset supersedes an earlier version, which is accessable at 'FAO/GHG/1/DROSA_A'. 
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
	'agriculture'
	'climate-change'
    'GHG-emissions'
	'IPCC-Tier-1'
	'organic-soils'
	'drainage-for-agriculture'
	'Area'
    'Global',
	'FAO',
  ],
  providers: [
    ee.producer_provider('FAOSTAT', 'https://www.fao.org/faostat/en/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1992-01-01T00:00:00Z', '2020-01-01T00:00:00Z'),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'cropland',
        description: 'Area of drained cropland organic soils (histosols)',
        'gee:units': 'ha',
      },
      {
        name: 'grassland',
        description: 'Area of drained grassland organic soils (histosols)',
        'gee:units': 'ha',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Cropland area drained (Annual)',
        lookat: {
          lat: -0.4,
          lon: 108.0,
          zoom: 6,
        },
        image_visualization: {
          global_vis: {
			min: [
              0,
            ],
            max: [
              60,
            ],
            palette: [
              'yellow',
			  'red',
            ],
            bands: [
              'cropland',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
	[FAO 2022.  Drained organic soils. FAO, Rome.](https://www.fao.org/faostat/en/#data/GV)
	[FAO 2020.  Drained organic soils 1990–2019. Global, regional and country trends. FAOSTAT Analytical Brief Series No 4. FAO, Rome.]
	(https://www.fao.org/3/cb0489en/CB0489EN.pdf)
	[IPCC 2014.  2013 Supplement to the 2006 IPCC Guidelines for National Greenhouse Gas Inventories: Wetlands. IPCC, Switzerland.]
	(https://www.ipcc.ch/publication/2013-supplement-to-the-2006-ipcc-guidelines-for-national-greenhouse-gas-inventories-wetlands/)
  |||,
  'sci:publications': [
    {
      citation: |||
		Conchedda, G. & Tubiello, F. N. 2020. Drainage of organic soils and GHG emissions: validation with country data, Earth System Science Data		
        [10.1016/j.oneear.2020.08.016](https://doi.org/10.5194/essd-12-3113-2020)
      |||,
      doi: '10.5194/essd-12-3113-2020',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
		The Food and Agriculture Organization of the United Nations (FAO) is mandated to collect, analyze, interpret, and disseminate 
	information related to nutrition, food, and agriculture. In this regard, it publishes a number of databases on topics related 
	to FAO's mandate, and encourages the use of them for scientific and research purposes. Consistent with the principles of 
	openness and sharing envisioned under the Open Data Licensing For Statistical Databases, and consistent with the mandate of FAO, 
	data on GHG emissions from agriculture activities on organic soils as part of FAOSTAT - FAO's database on Food and Agriculture 
	data, is available free to the user community. 
  |||,
  'gee:user_uploaded': true,
}