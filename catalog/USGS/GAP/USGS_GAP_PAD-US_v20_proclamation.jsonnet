local id = 'USGS/GAP/PAD-US/v20/proclamation';
local subdir = 'USGS/GAP';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local parent_url = catalog_subdir_url + 'catalog.json';
local self_url = catalog_subdir_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
  ],
  id: id,
  title: 'Proclamation: USGS GAP PAD-US v2.0',
  'gee:type': ee_const.gee_type.table,
  description: |||
    PAD-US is America's official national inventory of U.S. terrestrial and
    marine protected areas that are dedicated to the preservation of biological
    diversity and to other natural, recreation and cultural uses, managed for these
    purposes through legal or other effective means.  This database is separated
    into 4 separate table assets: designation, easement, fee, and proclamation.

    The 'Proclamation' asset includes boundaries that provide
    additional context for the features in the 'Fee', 'Designation', or 'Easement'
    assets, suitable for display as an outline because internal ownership is not
    represented. These include Military Lands, Proclamation Boundaries (National
    Park Service and Forest Service), or Approved Acquisition Boundaries (U.S. Fish
    and Wildlife Service).

    The PAD-US database strives to be a complete inventory of areas dedicated to
    the preservation of biological diversity, and other natural (including
    extraction), recreational or cultural uses, managed for these purposes through
    legal or other effective means.  PAD-US is an aggregation of \"best available\"
    spatial data provided by agencies and organizations at a point in time.  This
    includes both fee ownership of lands as well as management through leases,
    easements, or other binding agreements.  The data also tracks Congressional
    designations, Executive designations, and administrative designations
    identified in management plans (e.g. Bureau of Land Management's 'Area of
    Environmental Concern').  These factors provide for a robust dataset offering a
    spatial representation of the complex U.S. protected areas network.  It is
    important to have in mind a specific analysis question when approaching how to
    work with the data.  As a full inventory of areas aggregated from authoritative
    source data, PAD-US includes overlapping designation types and small boundary
    discrepancies between agency datasets.  Overlapping designations largely occur
    in the Federal estate of the 'Designation' or 'Combined' feature classes (e.g.
    'Wilderness Area' over a 'Wild and Scenic River' and 'National Forest').

    It is important to note the presence of overlaps, especially when trying to
    calculate area statistics; overlapping boundaries count the same area of ground
    multiple times.  While minor boundary discrepancies remain, most major overlaps
    have been removed from the 'Fee' asset and this is the best source for
    overall land area calculations by land manager ('Manager Name') within the
    PAD-US database (data gaps limit calculations by fee ownership or 'Owner
    Name').  Statistics summarizing 'Public Access' or Protection Status ('GAP
    Status Code') by managing agency or organization from an analysis of the PAD-US
    1.4 'Combined' feature class are [available](https://www.usgs.gov/core-science-systems/science-analytics-and-synthesis/gap/science/pad-us-statistics-and-reports)
    and will be updated with PAD-US 2.0.  As the PAD-US database is a direct
    aggregation of source data, the PAD-US development team does not alter spatial
    linework.  The exception is to \"clip\" lands data along State boundary lines
    (using the authoritative State boundary file provided by the U.S. Census
    Bureau) and remove the small segments of boundaries created by this process
    associated with State or local lands (not Federal or nonprofit lands).  Some
    boundary discrepancies (or slivers) remain in the dataset.  Data overlaps have
    been identified and are shared, along with the U.S. Census Bureau State
    jurisdictional boundary file, with agency data stewards to facilitate edits in
    source files that will then be incorporated in subsequent PAD-US versions over
    time. The PAD-US database is built in collaboration with many partners and
    data stewards.
    [Information regarding data stewards is available](https://www.usgs.gov/core-science-systems/science-analytics-and-synthesis/gap/science/pad-us-data-stewards).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.example(id, basename + '_FeatureView'),
    {
      rel: ee_const.rel.cite_as,
      href: 'https://doi.org/10.5066/P955KPLE',
    },
  ],
  keywords: [
    'conservation_easements',
    'designation',
    'management',
    'ownership',
    'protected_areas',
    'public_lands',
    'usgs',
  ],
  providers: [
    ee.producer_provider('US Geological Survey', 'https://www.usgs.gov/core-science-systems/science-analytics-and-synthesis/gap/science/protected-areas'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2018-09-01T00:00:00Z', '2018-09-01T00:00:00Z'),
  summaries: {
    'gee:schema': [
      {
        name: 'Agg_Src',
        description: 'Source of data aggregator.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Category',
        description: 'The type of protection: designation, easement, fee, marine, other,\nproclamation, or unknown.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Comments',
        description: 'Additional comments.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Date_Est',
        description: 'Year protected area established.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Des_Tp',
        description: |||
          The detailed type of designation, e.g. 'area of critical environmental
          concern', 'local park', 'national park', 'wilderness area', etc.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'EsmtHldr',
        description: 'The organization that holds the easement.',
        type: ee_const.var_type.string,
      },
      {
        name: 'EHoldTyp',
        description: 'The type of easement holder.',
        type: ee_const.var_type.string,
      },
      {
        name: 'FeatClass',
        description: 'Unique id.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GAP_Sts',
        description: |||
          The level of protection or "status":

          * 1: managed for biodiversity, disturbance events proceed or are mimicked
          * 2: managed for biodiversity, disturbance events suppressed
          * 3: managed for multiple uses, subject to extractive (e.g. mining or logging) or OHV use
          * 4: no known mandate for biodiversity protection.
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'GAPCdDt',
        description: 'Date the status code was determined.',
        type: ee_const.var_type.string,
      },
      {
        name: 'GAPCdSrc',
        description: 'Source of the status code.',
        type: ee_const.var_type.string,
      },
      {
        name: 'GIS_Acres',
        description: 'Number of acres of the protected area calculated.',
        type: ee_const.var_type.double,
      },
      {
        name: 'GIS_Src',
        description: 'The source of the GIS data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Src_Date',
        description: 'The date the GIS data represent.',
        type: ee_const.var_type.string,
      },
      {
        name: 'IUCN_Cat',
        description: |||
          The level of protection using IUCN protection status:

          * Ia: Strict nature reserves
          * Ib: Wilderness areas
          * II: National park
          * III: Natural monument or feature
          * IV: Habitat/species management; Other Conservation Area; Unassigned
          * V: Protected landscape / seascape
          * VI: Protected area with sustainable use of natural resources
        |||,
        type: ee_const.var_type.string,
      },
      {
        name: 'IUCNCtDt',
        description: 'Date of the IUCN category.',
        type: ee_const.var_type.string,
      },
      {
        name: 'IUCNCtSrc',
        description: 'Source of the IUCN protected status.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Loc_Ds',
        description: 'Designation of the protected area at the local level.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Loc_Mang',
        description: 'The manager of the protected area.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Loc_Nm',
        description: 'The name of the protected area.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Loc_Own',
        description: 'The owner of the protected area.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Mang_Name',
        description: 'The name of the managing organization.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Mang_Type',
        description: 'The manager type.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Own_Name',
        description: 'The name of the owner of the protected area.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Own_Type',
        description: 'The type of owner organization.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Access',
        description: 'Accessibility to the protected area.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Access_Dt',
        description: 'The date of the access.',
        type: ee_const.var_type.string,
      },
      {
        name: 'Access_Src',
        description: 'The source of the access data.',
        type: ee_const.var_type.string,
      },
      {
        name: 'ID',
        description: 'The id of the protected area.',
        type: ee_const.var_type.string,
      },
      {
        name: 'State_Nm',
        description: 'State names in two letter abbreviations',
        type: ee_const.var_type.string,
      },
      {
        name: 'Unit_Nm',
        description: 'Units name',
        type: ee_const.var_type.string,
      },
      {
        name: 'WDPA_Cd',
        description: 'The site code associated with the WDPA dataset.',
        type: ee_const.var_type.string,
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Features',
        lookat: {
          lat: 43.0,
          lon: -73.0,
          zoom: 8,
        },
        table_visualization: {
          color: '0000be',
          width: 3.0,
          fill_color: '000070',
        },
      },
      {
        display_name: 'Features',
        visualize_as: 'FeatureView',
        lookat: {
          lat: 43.0,
          lon: -73.0,
          zoom: 8,
        },
      },
    ],
    'gee:feature_view_ingestion_params': {
      max_features_per_tile: 4000,
      thinning_strategy: 'HIGHER_DENSITY',
      thinning_ranking: ['GIS_Acres DESC'],
      z_order_ranking: ['GIS_Acres DESC'],
      prerender_tiles: true,
    },
  },
  'sci:doi': '10.5066/P955KPLE',
  'sci:citation': |||
    U.S. Geological Survey (USGS) Gap Analysis Project (GAP), 2018,
    Protected Areas Database of the United States (PAD-US): U.S.
    Geological Survey data release, [doi:10.5066/P955KPLE](https://doi.org/10.5066/P955KPLE).
  |||,
  'gee:terms_of_use': |||
    The Digital Object Identifier [doi:10.5066/P955KPLE](https://doi.org/10.5066/P955KPLE) for PAD-US 2.0
    provides the persistent reference that should be used to obtain the data for
    use. The U.S. Geological Survey and all contributing data partners shall not be
    held liable for improper or incorrect use of the data described and (or)
    contained herein. All information is created with a specific end use or uses in
    mind. This is especially true for GIS data, which is expensive to produce and
    must be directed to meet the immediate program needs. These data were created
    with the expectation that they would be used for other applications; however,
    inappropriate uses are listed below. This list is in no way exhaustive but
    should serve as a guide to assess whether a proposed use can or cannot be
    supported by these data. For many uses, it is unlikely that PAD-US will provide
    the only data needed, and for uses with a regulatory outcome, authoritative
    agency data and field surveys should verify the result. PAD-US is recommended
    for users seeking basic information about more than one agency or organizations
    lands. Users should seek authoritative source data directly to answer questions
    regarding one agency or those requiring more frequent updates. Ultimately, it
    will be the responsibility of each data user to determine if these data can
    answer the question being asked. Inappropriate uses include: Using PAD-US for
    applications or analyses associated with one agency or a particular unit
    (agencies are always the best and authoritative source of their lands data and
    many publish updates more frequently than PAD-US). Using some data to map small
    areas (less than thousands of hectares), typically requiring mapping resolution
    at 1:24,000 scale (as boundary quality varies by data source) and using aerial
    photographs or ground surveys in areas where data are incomplete. Combining
    these data with other data finer than 1:100,000 scale to produce new hybrid
    maps or answer queries. Generating specific areal measurements from the data
    finer than the nearest thousand hectares. Representing boundaries as a legal
    representation for regulation or acquisition. Establishing definite occurrence
    or non-occurrence of any feature for an exact geographic area. Determining
    abundance, health, or condition of any feature. Using the data without
    acquiring and reviewing the metadata.
  |||,
  'gee:user_uploaded': true,
}
