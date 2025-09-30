local id = 'projects/ee-kbas-in-gee/assets/current';
local subdir = 'ee-kbas-in-gee';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  id: id,
  title: 'WDKBA: World Database of Key Biodiversity Areas (KBAS)',
  version: 'September 2025',

  description: |||
    **If you are interested in accessing the KBA dataset please complete the 
	[KBA data request form](https://www.keybiodiversityareas.org/kba-data/request) 
	which will allow access directly in GEE once approved.**
	
	Key Biodiversity Areas (KBAs) are 'sites contributing 
	significantly to the global persistence of biodiversity’, 
	in terrestrial, freshwater and marine ecosystems. Sites 
	can be identified as KBAs if they meet at least one of
	the KBA criteria set out in the KBA Standard (IUCN, 2016) for threatened or geographically 
	restricted species or ecosystems, ecological integrity, biological processes, or 
	irreplaceability. Both tabular and spatial data for KBAs are 
	managed in the World Database of Key Biodiversity Areas (WDKBA). 
	
	The identification of KBAs draws upon the efforts of huge networks 
	of local experts and relies on locally collected data. The process 
	to reassess existing or identify new KBAs, is highly inclusive, 
	consultative and nationally driven. Anyone with appropriate data may 
	propose a site as a KBA, although consultation with relevant stakeholders 
	at the local and national level is required when identifying the site and 
	needs to be documented in the proposal. KBAs can be identified by a KBA 
	National Coordination Group (KBA NCG) if this has been established in a 
	country or by an individual or small group of proposers. Further information 
	about KBAs can be found on the [KBA website](https://www.keybiodiversityareas.org/).
	
	**Data Sources.** Sites of importance for biodiversity that had been identified using other
	pre-existing criteria formed the basis of the KBA dataset prior to the 
	launch of the KBA Standard in 2016. These were principally the Important
	Bird and Biodiversity Areas (IBAs) identified by BirdLife International, 
	plus Alliance for Zero Extinction (AZE) sites and KBAs covering multiple 
	taxonomic groups in freshwater, marine and terrestrial systems under previously 
	published criteria. Since 2016, many of these sites have been reassessed 
	against the Global Standard.

	Currently, the global KBA network consists of >16,500 sites and these are classified
	as Global (those meeting Global KBA criteria), Regional (those not meeting Global KBA 
	criteria but continuing	to meet other pre-existing criteria) or Global/ Regional to
	be determined (those legacy sites with insufficient information to demonstrate whether
	they meet Global KBA criteria). Further details about the current KBA dataset are published
	on the KBA website.
	
	**Asset Naming Conventions.** An updated version of the WDKBA is currently
	released every six months. The most recent version is permanently available 
	as projects/ee-kbas-in-gee/assets/current. Previous versions, starting from 
	March 2025, are available in the format projects/ee-kbas-in-gee/assets/YYYYMM.	
  |||,

 
  'gee:categories': ['ecosystems', 'oceans'],

  keywords: [
    'biodiversity',
    'boundaries',
	'ecosystems',
	'global',
	'iucn',
	'management',
	'marine',
	'publisher-dataset'
  ],

  providers: [
    ee.producer_provider('BirdLife International', 'https://www.birdlife.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],

  extent: ee.extent_global('2016-01-01T00:00:00Z', '2025-04-01T00:00:00Z'),

  summaries: {

    'gee:schema': [
      {
        name: 'SitRecID',
        description: 'Unique identifier for a KBA.',
        type: ee_const.var_type.double,
      },
	  {
        name: 'Region',
        description: 'Name of region containing the KBA.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'Country',
        description: 'Name of country/territory containing the KBA.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'ISO3',
        description: 'ISO3 code of country/territory containing the KBA.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'NatName',
        description: 'Name of KBA used nationally, typically in the language of its country.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'IntName',
        description: 'Name of KBA to be used internationally, typically in English.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'SitLat',
        description: 'Latitude coordinate of centroid.',
        type: ee_const.var_type.double,	
      },
	  {
        name: 'SitLong',
        description: 'Longitude coordinate of centroid.',
        type: ee_const.var_type.double,
      },
	  {
        name: 'SitAreaKM2',
        description: 'Calculated site area in KM2.',
        type: ee_const.var_type.double,
      },
	  {
        name: 'KbaStatus',
        description: 'Current state of the KBA's assessment.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'KbaClass',
        description: |||
		  The classification of all KBAs is assigned as Global (KBAs that meet
          KBA criteria), Regional (KBAs identified prior to the KBA Standard
          that meet other pre-existing criteria) or Global/Regional TBD (KBAs
          identified prior to the KBA Standard using pre-existing criteria but
          with insufficient evidence to show whether they continue to meet
          criteria. Sites in this latter group are prioritised for reassessment).
		|||,
        type: ee_const.var_type.string,
      },
	  {
        name: 'IbaStatus',
        description: 'Whether or not the KBA is an Important Bird and Biodiversity Area (IBA).',
        type: ee_const.var_type.string,
      },
	  {
        name: 'LegacyKba',
        description: |||
		  Whether the KBA was identified using KBA criteria from before the publication
		  of the [KBA standard](https://www.keybiodiversityareas.org/working-with-kbas/proposing-updating/criteria).
		|||,
        type: ee_const.var_type.string,
      },
	  {
        name: 'AzeStatus',
        description: 'Whether or not the KBA is an Alliance for Zero Extinction (AZE) site.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'LastUpdate',
        description: 'Year in which the underlying KBA data was last updated.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'Source',
        description: 'Origin of the spatial data.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'DelTxt',
        description: 'Notes relating to the digitisation of the polygon.',
        type: ee_const.var_type.string,
      },
	  {
        name: 'RepAreaKM2',
        description: |||
		  Reported site area in KM2, this only applies to KBAs with no polygon boundary.
		  These are represented by a buffer around a central point.
		|||,
        type: ee_const.var_type.double,
      }
    ],


    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 1500,
      thinning_strategy: 'HIGHER_DENSITY',
    },

    'gee:visualizations': [
      {
        display_name: 'Key Biodiversity Areas',
        lookat: {
          lat: 0,
          lon: 0,
          zoom: 4,
        },
         table_visualization: {
           color: '#FFD700',
           fill_color: '#FFD70066',
         },
      },
    ],
  },
  'sci:citation': |||
        BirdLife International (year). Digital boundaries of Key Biodiversity
		Areas from the World Database of Key Biodiversity Areas. Developed by 
		the KBA Partnership: BirdLife International, International Union for 
		the Conservation of Nature, American Bird Conservancy, Amphibian Survival
		Alliance, Conservation International, Critical Ecosystem Partnership Fund,
		Global Environment Facility, Re:Wild, NatureServe, Rainforest Trust, Royal 
		Society for the Protection of Birds, Wildlife Conservation Society and World
		Wildlife Fund. [insert month/year of version used].  Available at http://www.keybiodiversityareas.org/kba-data/request.
      |||
  ],

   'gee:terms_of_use': |||
     Please visit the [full terms and conditions page](https://www.keybiodiversityareas.org/termsofservice)
	 of the World Database of KBAs. Select highlights below:
	 
	 **No Commercial Use.** You may not use, nor facilitate or assist others to use,
	 either (a) KBA Data or (b) any Derivative Works (as further defined in clause 5)
	 for Commercial Use without the prior written permission of BirdLife International
	 on behalf of the KBA Secretariat, which grants permission on behalf of the owners
	 of the relevant intellectual property rights. \"Commercial Use\" means a) any
	 use by, on behalf of, or to inform or assist the activities of, a commercial
	 entity (an entity that operates 'for profit') or b) use by any individual
     or non-profit entity for the purposes of revenue generation.
	 
	 **Disclaimer.** The designation of geographical entities on The KBA Website do
	 not imply the expression of, or represent, any opinion by the KBA Partners 
	 concerning the legal status of any country, territory or area, or concerning
	 the delimitation of its frontiers or boundaries.
	 
	 **Attribution.** The recipient of the data will provide full acknowledgement
	 and citation (which includes reference to the version of the KBA Data used)
	 in any materials or publications derived in part or in whole from the data.
   |||,

  // TODO(google): Remove gee:status when the dataset is ready.
  'gee:status': 'beta',
 
  'gee:type': ee_const.gee_type.table,

  license: license.id,

  links: ee.standardLinks(subdir, id)

  // This refers to a STAC term 'collection', not to Earth Engine collections.
  type: ee_const.stac_type.collection,
  stac_version: ee_const.stac_version,
  stac_extensions: [
    ee_const.ext_sci,
    // Include the version extension if the dataset uses any of:
    // - the deprecated fields
    // - the version fields
    // - successor link
    // - predecessor link
    // - latest link
    ee_const.ext_ver,
  ],
}
