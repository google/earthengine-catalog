local id = 'WWF/HydroATLAS/v1/Basins/level12';
local subdir = 'WWF';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local basename = std.strReplace(id, '/', '_');
local license = spdx.cc_by_4_0;
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'WWF HydroATLAS Basins Level 12',
  version: 'v1',
  'gee:type': ee_const.gee_type.table,
  description: |||
    BasinATLAS is a component of the
    [HydroATLAS database](https://www.hydrosheds.org/page/hydroatlas),
    which is a component of [HydroSHEDS](https://www.hydrosheds.org).

    BasinATLAS provides a standardized compendium of hydro-environmental
    attribute information for all watersheds of the world at high
    spatial resolution. This dataset includes data for 56 variables,
    partitioned into 281 attributes and organized in six categories: hydrology;
    physiography; climate; land cover & use; soils & geology; and anthropogenic
    influences (see Table 1 in the HydroATLAS documentation linked below).

    Watersheds range from level 1 (coarse) to level 12 (detailed), using
    Pfastetter codes. The underlying watershed deleniation uses the NASA
    SRTM Digital Elevatin Map (DEM) below 60oN latitude and the
    USGS HYDRO1k DEM above 60oN.

    Technical documentation:

    [https://www.hydrosheds.org/images/inpages/HydroATLAS_TechDoc_v10.pdf](https://www.hydrosheds.org/images/inpages/HydroATLAS_TechDoc_v10.pdf)

    Note that the quality of HydroATLAS data is significantly lower for regions
    above 60 degrees northern latitude as there is no underlying SRTM elevation
    data available and thus a coarser-resolution DEM was used
    (HYDRO1k provided by USGS).

    HydroSHEDS was developed by the World Wildlife Fund (WWF)
    Conservation Science Program in partnership with the U.S. Geological
    Survey, the International Centre for Tropical Agriculture, The
    Nature Conservancy, and the Center for Environmental Systems Research
    of the University of Kassel, Germany.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.license('https://www.hydrosheds.org/page/license'),
    {
      rel: ee_const.rel.source,
      href: 'https://figshare.com/ndownloader/files/20087237',
    },
  ],
  keywords: [
    'geophysical',
    'hydroatlas',
    'hydrography',
    'hydrology',
    'hydrosheds',
    'srtm',
    'water',
    'watershed',
    'wwf',
  ],
  providers: [
    ee.producer_provider('WWF', 'https://www.hydrosheds.org/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  // This is the time extent of the SRTM mission, which was used for the
  // underlying HydoBASINS DEM. Much more data was used to create these
  // HydroATLAS datasets, with different valid time periods.
  // Due to the complexity of the time validity of this dataset, we decided
  // to leave this time extent to match the HydroBASINS dataset, which provides
  // the spatial delineation for HydroATLAS.
  extent: ee.extent_global('2000-02-22T00:00:00Z', '2000-02-22T00:00:00Z'),
  summaries: {
    'gee:properties': [
      {
        name: 'HYBAS_ID',
        description: |||
          First 1 digit represents the region:
            * 1 = Africa
            * 2 = Europe
            * 3 = Siberia
            * 4 = Asia
            * 5 = Australia
            * 6 = South America
            * 7 = North America
            * 8 = Arctic (North America)
            * 9 = Greenland.

          Next 2 digits define the Pfafstetter level (01-12). The value '00' is used for the
          'Level 0' layer that contains all original sub-basins and all Pfafstetter codes (at
          all levels); 'Level 0' only exists in the standard format of HydroBASINS
          (without lakes).

          Next 6 digits represent a unique identifier within the HydroSHEDS network;
          values larger than 900,000 represent lakes and only occur in the customized
          format (with lakes)

          Last 1 digit indicates the side of a sub-basin in relation to the river network (0 =
          noSide; 1 = Left; 2 = Right). Sides are only defined for the customized format
          (with lakes).
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'COAST',
        description: |||
          Indicator for lumped coastal basins: 0 = no; 1 = yes. Coastal basins represent
          conglomerates of small coastal watersheds that drain into the ocean between larger
          river basins.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'DIST_MAIN',
        description: 'Distance from polygon outlet to the most downstream sink, in km.',
        type: ee_const.var_type.double,
      },
      {
        name: 'DIST_SINK',
        description: 'Distance from polygon outlet to the next downstream sink, in km.',
        type: ee_const.var_type.double,
      },
      {
        name: 'ENDO',
        description: |||
          Indicator for endorheic (inland) basins without surface flow connection to the
          ocean: 0 = not part of an endorheic basin; 1 = part of an endorheic basin; 2 = sink
          (i.e. most downstream polygon) of an endorheic basin.
        |||,
        type: ee_const.var_type.int,
      },
      {
        name: 'MAIN_BAS',
        description: 'Hybas_id of the most downstream sink, i.e. the outlet of the main river basin.',
        type: ee_const.var_type.int,
      },
      {
        name: 'NEXT_DOWN',
        description: 'Hybas_id of the next downstream polygon.',
        type: ee_const.var_type.int,
      },
      {
        name: 'NEXT_SINK',
        description: 'Hybas_id of the next downstream sink.',
        type: ee_const.var_type.int,
      },
      {
        name: 'PFAF_ID',
        description: 'The Pfafstetter code.',
        type: ee_const.var_type.int,
      },
      {
        name: 'SORT',
        description: |||
          Indicator showing the record number (sequence) in which the original polygons are
          stored in the shapefile (i.e. counting upwards from 1 in the original shapefile). The
          original polygons are sorted from downstream to upstream. This field can be used to
          sort the polygons back to their original sequence or to perform topological searches.
        |||,
        type: ee_const.var_type.property_type_unspecified,
      },
      {
        name: 'SUB_AREA',
        description: 'Area of basin, in square kilometers.',
        type: ee_const.var_type.double,
      },
      {
        name: 'UP_AREA',
        description: 'Total upstream area, in square kilometers.',
        type: ee_const.var_type.double,
      },
      {
        name: 'aet_mm_s01',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s02',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s03',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s04',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s05',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s06',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s07',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s08',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s09',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s10',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s11',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_s12',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_syr',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'aet_mm_uyr',
        description: 'Actual Evapotranspiration: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'ari_ix_sav',
        description: 'Global Aridity Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'ari_ix_uav',
        description: 'Global Aridity Index: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'cls_cl_smj',
        description: 'Climate Strata: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'cly_pc_sav',
        description: 'Clay Fraction in Soil: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'cly_pc_uav',
        description: 'Clay Fraction in Soil: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'clz_cl_smj',
        description: 'Climate Zones: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s01',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s02',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s03',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s04',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s05',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s06',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s07',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s08',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s09',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s10',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s11',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_s12',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_syr',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'cmi_ix_uyr',
        description: 'Climate Moisture Index: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'crp_pc_sse',
        description: 'Cropland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'crp_pc_use',
        description: 'Cropland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'dis_m3_pmn',
        description: 'Natural Discharge: Category = Hydrology; Spatial Extent = {p} at sub-bsin pour point; Dimensions = {mn} annual minimum',
        type: ee_const.var_type.double,
      },
      {
        name: 'dis_m3_pmx',
        description: 'Natural Discharge: Category = Hydrology; Spatial Extent = {p} at sub-bsin pour point; Dimensions = {mx} annual maximum',
        type: ee_const.var_type.double,
      },
      {
        name: 'dis_m3_pyr',
        description: 'Natural Discharge: Category = Hydrology; Spatial Extent = {p} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.double,
      },
      {
        name: 'dor_pc_pva',
        description: 'Degree of Regulation: Category = Hydrology; Spatial Extent = {p} at sub-bsin pour point; Dimensions = {va} value',
        type: ee_const.var_type.int,
      },
      {
        name: 'ele_mt_sav',
        description: 'Elevation: Category = Physiography; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'ele_mt_smn',
        description: 'Elevation: Category = Physiography; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mn} minimum',
        type: ee_const.var_type.int,
      },
      {
        name: 'ele_mt_smx',
        description: 'Elevation: Category = Physiography; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mx} maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'ele_mt_uav',
        description: 'Elevation: Category = Physiography; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'ero_kh_sav',
        description: 'Soil Erosion: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'ero_kh_uav',
        description: 'Soil Erosion: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'fec_cl_smj',
        description: 'Freshwater Ecoregions: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'fmh_cl_smj',
        description: 'Freshwater Major Habitat Types: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'for_pc_sse',
        description: 'Forest Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'for_pc_use',
        description: 'Forest Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'gad_id_smj',
        description: 'Global Administrative Areas: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'gdp_ud_sav',
        description: 'Gross Domestic Product: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'gdp_ud_ssu',
        description: 'Gross Domestic Product: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.int,
      },
      {
        name: 'gdp_ud_usu',
        description: 'Gross Domestic Product: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.int,
      },
      {
        name: 'gla_pc_sse',
        description: 'Glacier Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'gla_pc_use',
        description: 'Glacier Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_cl_smj',
        description: 'Land Cover Classes: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s01',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} % coverage: Tree Cover, broadleaved, evergreen',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s02',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} % coverage: Tree Cover, broadleaved, deciduous, closed',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s03',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} % coverage: Tree Cover, broadleaved, deciduous, open',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s04',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} % coverage: Tree Cover, needle-leaved, evergreen',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s05',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} % coverage: Tree Cover, needle-leaved, deciduous',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s06',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} % coverage: Tree Cover, mixed leaf type',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s07',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} % coverage: Tree Cover, regularly flooded, fresh  water (& brackish)',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s08',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} % coverage: Tree Cover, regularly flooded, saline water',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s09',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} % coverage: Mosaic: Tree cover / Other natural vegetation',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s10',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} % coverage: Tree Cover, burnt',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s11',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} % coverage: Shrub Cover, closed-open, evergreen',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s12',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} % coverage: Shrub Cover, closed-open, deciduous',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s13',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {13} % coverage: Herbaceous Cover, closed-open',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s14',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {14} % coverage: Sparse Herbaceous or sparse Shrub Cover',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s15',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {15} % coverage: Regularly flooded Shrub and/or Herbaceous Cover',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s16',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {16} % coverage: Cultivated and managed areas',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s17',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {17} % coverage: Mosaic: Cropland / Tree Cover / Other natural vegetation',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s18',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {18} % coverage: Mosaic: Cropland / Shrub or Grass Cover',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s19',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {19} % coverage: Bare Areas',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s20',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {20} % coverage: Water Bodies',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s21',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {21} % coverage: Snow and Ice',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_s22',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {22} % coverage: Artificial surfaces and associated areas',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u01',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {01} % coverage: Tree Cover, broadleaved, evergreen',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u02',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {02} % coverage: Tree Cover, broadleaved, deciduous, closed',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u03',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {03} % coverage: Tree Cover, broadleaved, deciduous, open',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u04',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {04} % coverage: Tree Cover, needle-leaved, evergreen',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u05',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {05} % coverage: Tree Cover, needle-leaved, deciduous',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u06',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {06} % coverage: Tree Cover, mixed leaf type',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u07',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {07} % coverage: Tree Cover, regularly flooded, fresh  water (& brackish)',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u08',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {08} % coverage: Tree Cover, regularly flooded, saline water',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u09',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {09} % coverage: Mosaic: Tree cover / Other natural vegetation',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u10',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {10} % coverage: Tree Cover, burnt',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u11',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {11} % coverage: Shrub Cover, closed-open, evergreen',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u12',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {12} % coverage: Shrub Cover, closed-open, deciduous',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u13',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {13} % coverage: Herbaceous Cover, closed-open',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u14',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {14} % coverage: Sparse Herbaceous or sparse Shrub Cover',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u15',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {15} % coverage: Regularly flooded Shrub and/or Herbaceous Cover',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u16',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {16} % coverage: Cultivated and managed areas',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u17',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {17} % coverage: Mosaic: Cropland / Tree Cover / Other natural vegetation',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u18',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {18} % coverage: Mosaic: Cropland / Shrub or Grass Cover',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u19',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {19} % coverage: Bare Areas',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u20',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {20} % coverage: Water Bodies',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u21',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {21} % coverage: Snow and Ice',
        type: ee_const.var_type.int,
      },
      {
        name: 'glc_pc_u22',
        description: 'Land Cover Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {22} % coverage: Artificial surfaces and associated areas',
        type: ee_const.var_type.int,
      },
      {
        name: 'gwt_cm_sav',
        description: 'Groundwater Table Depth: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'hdi_ix_sav',
        description: 'Human Development Index: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'hft_ix_s09',
        description: 'Human Footprint: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} year 2009',
        type: ee_const.var_type.int,
      },
      {
        name: 'hft_ix_s93',
        description: 'Human Footprint: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {93} year 1993',
        type: ee_const.var_type.int,
      },
      {
        name: 'hft_ix_u09',
        description: 'Human Footprint: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {09} year 2009',
        type: ee_const.var_type.int,
      },
      {
        name: 'hft_ix_u93',
        description: 'Human Footprint: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {93} year 1993',
        type: ee_const.var_type.int,
      },
      {
        name: 'inu_pc_slt',
        description: 'Inundation Extent: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {lt} long-term maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'inu_pc_smn',
        description: 'Inundation Extent: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mn} annual minimum',
        type: ee_const.var_type.int,
      },
      {
        name: 'inu_pc_smx',
        description: 'Inundation Extent: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mx} annual maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'inu_pc_ult',
        description: 'Inundation Extent: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {lt} long-term maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'inu_pc_umn',
        description: 'Inundation Extent: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {mn} annual minimum',
        type: ee_const.var_type.int,
      },
      {
        name: 'inu_pc_umx',
        description: 'Inundation Extent: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {mx} annual maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'ire_pc_sse',
        description: 'Irrigated Area Extent (Equipped): Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'ire_pc_use',
        description: 'Irrigated Area Extent (Equipped): Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'kar_pc_sse',
        description: 'Karst Area Extent: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'kar_pc_use',
        description: 'Karst Area Extent: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'lit_cl_smj',
        description: 'Lithological Classes: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'lka_pc_sse',
        description: 'Limnicity (Percent Lake Area): Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'lka_pc_use',
        description: 'Limnicity (Percent Lake Area): Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'lkv_mc_usu',
        description: 'Lake Volume: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.int,
      },
      {
        name: 'nli_ix_sav',
        description: 'Nighttime Lights: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'nli_ix_uav',
        description: 'Nighttime Lights: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'pac_pc_sse',
        description: 'Protected Area Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'pac_pc_use',
        description: 'Protected Area Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s01',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s02',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s03',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s04',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s05',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s06',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s07',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s08',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s09',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s10',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s11',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_s12',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_syr',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'pet_mm_uyr',
        description: 'Potential Evapotranspiration: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_cl_smj',
        description: 'Potential Natural Vegetation Classes: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s01',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} % coverage: Tropical Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s02',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} % coverage: Tropical Deciduous Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s03',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} % coverage: Temperate Broadleaf Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s04',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} % coverage: Temperate Needleleaf Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s05',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} % coverage: Temperate Dciduous Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s06',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} % coverage: Boreal Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s07',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} % coverage: Boreal Deciduous Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s08',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} % coverage: Mixed Forest',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s09',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} % coverage: Savanna',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s10',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} % coverage: Grassland/Steppe',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s11',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} % coverage: Dense Shrubland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s12',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} % coverage: Open Shrubland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s13',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {13} % coverage: Tundra',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s14',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {14} % coverage: Desert',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_s15',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {15} % coverage: Polar Desert/Rock/Ice',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u01',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {01} % coverage: Tropical Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u02',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {02} % coverage: Tropical Deciduous Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u03',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {03} % coverage: Temperate Broadleaf Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u04',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {04} % coverage: Temperate Needleleaf Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u05',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {05} % coverage: Temperate Dciduous Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u06',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {06} % coverage: Boreal Evergreen Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u07',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {07} % coverage: Boreal Deciduous Forest/Woodland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u08',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {08} % coverage: Mixed Forest',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u09',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {09} % coverage: Savanna',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u10',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {10} % coverage: Grassland/Steppe',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u11',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {11} % coverage: Dense Shrubland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u12',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {12} % coverage: Open Shrubland',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u13',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {13} % coverage: Tundra',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u14',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {14} % coverage: Desert',
        type: ee_const.var_type.int,
      },
      {
        name: 'pnv_pc_u15',
        description: 'Potential Natural Vegetation Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {15} % coverage: Polar Desert/Rock/Ice',
        type: ee_const.var_type.int,
      },
      {
        name: 'pop_ct_ssu',
        description: 'Population Count: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.double,
      },
      {
        name: 'pop_ct_usu',
        description: 'Population Count: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.double,
      },
      {
        name: 'ppd_pk_sav',
        description: 'Population Density: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.double,
      },
      {
        name: 'ppd_pk_uav',
        description: 'Population Density: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.double,
      },
      {
        name: 'pre_mm_s01',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s02',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s03',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s04',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s05',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s06',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s07',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s08',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s09',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s10',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s11',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_s12',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_syr',
        description: 'Precipitation: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'pre_mm_uyr',
        description: 'Precipitation: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'prm_pc_sse',
        description: 'Permafrost Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'prm_pc_use',
        description: 'Permafrost Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'pst_pc_sse',
        description: 'Pasture Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'pst_pc_use',
        description: 'Pasture Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'rdd_mk_sav',
        description: 'Road Density: Category = Anthropogenic; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'rdd_mk_uav',
        description: 'Road Density: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'rev_mc_usu',
        description: 'Reservoir Volume: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.int,
      },
      {
        name: 'ria_ha_ssu',
        description: 'River Area: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.double,
      },
      {
        name: 'ria_ha_usu',
        description: 'River Area: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.double,
      },
      {
        name: 'riv_tc_ssu',
        description: 'River Volume: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.double,
      },
      {
        name: 'riv_tc_usu',
        description: 'River Volume: Category = Hydrology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {su} sum',
        type: ee_const.var_type.double,
      },
      {
        name: 'run_mm_syr',
        description: 'Land Surface Runoff: Category = Hydrology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'sgr_dk_sav',
        description: 'Stream Gradient: Category = Physiography; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'slp_dg_sav',
        description: 'Terrain Slope: Category = Physiography; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'slp_dg_uav',
        description: 'Terrain Slope: Category = Physiography; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'slt_pc_sav',
        description: 'Silt Fraction in Soil: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'slt_pc_uav',
        description: 'Silt Fraction in Soil: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'snd_pc_sav',
        description: 'Sand Fraction in Soil: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'snd_pc_uav',
        description: 'Sand Fraction in Soil: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s01',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s02',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s03',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s04',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s05',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s06',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s07',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s08',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s09',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s10',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s11',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_s12',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_smx',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mx} annual maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_syr',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'snw_pc_uyr',
        description: 'Snow Cover Extent: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'soc_th_sav',
        description: 'Organic Carbon Content in Soil: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'soc_th_uav',
        description: 'Organic Carbon Content in Soil: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {av} average',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s01',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s02',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s03',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s04',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s05',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s06',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s07',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s08',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s09',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s10',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s11',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_s12',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_syr',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'swc_pc_uyr',
        description: 'Soil Water Content: Category = Soils & Geology; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'tbi_cl_smj',
        description: 'Terrestrial Biomes: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'tec_cl_smj',
        description: 'Terrestrial Ecoregions: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s01',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} January',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s02',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} February',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s03',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} March',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s04',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} April',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s05',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} May',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s06',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} June',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s07',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} July',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s08',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} August',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s09',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} September',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s10',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {10} October',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s11',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {11} November',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_s12',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {12} December',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_smn',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mn} annual minimum',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_smx',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mx} annual maximum',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_syr',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'tmp_dc_uyr',
        description: 'Air Temperature: Category = Climate; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {yr} annual average',
        type: ee_const.var_type.int,
      },
      {
        name: 'urb_pc_sse',
        description: 'Urban Extent: Category = Anthropogenic; Spatial Extent = {s} in reach catchment; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'urb_pc_use',
        description: 'Urban Extent: Category = Anthropogenic; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {se} spatial extent (%)',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_cl_smj',
        description: 'Wetland Classes: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {mj} spatial majority',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s01',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {01} Wetland class #1: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s02',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {02} Wetland class #2: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s03',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {03} Wetland class #3: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s04',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {04} Wetland class #4: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s05',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {05} Wetland class #5: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s06',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {06} Wetland class #6: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s07',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {07} Wetland class #7: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s08',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {08} Wetland class #8: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_s09',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {09} Wetland class #9: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_sg1',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {g1} Wetland class grouping; see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_sg2',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {s} at sub-bsin pour point; Dimensions = {g2} Wetland class grouping; see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u01',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {01} Wetland class #1: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u02',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {02} Wetland class #2: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u03',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {03} Wetland class #3: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u04',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {04} Wetland class #4: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u05',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {05} Wetland class #5: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u06',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {06} Wetland class #6: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u07',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {07} Wetland class #7: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u08',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {08} Wetland class #8: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_u09',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {09} Wetland class #9: see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_ug1',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {g1} Wetland class grouping; see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
      {
        name: 'wet_pc_ug2',
        description: 'Wetland Extent: Category = Landcover; Spatial Extent = {u} in total watershed upstream of sub-basin pour point; Dimensions = {g2} Wetland class grouping; see https://www.worldwildlife.org/pages/global-lakes-and-wetlands-database',
        type: ee_const.var_type.int,
      },
    ],
    'gee:visualizations': [
        {
          display_name: 'Upstream Drainage Area [mm]',
          lookat: {
              lat: 36.07,
              lon: 19.97,
              zoom: 5
          },
          table_visualization: {
              palette: ['0300ff', '418504', 'efff07', 'efff07', 'ff0303'],
              max: 5000,
          },
        },
    ],
  },
  'sci:citation': |||
    'Linke, S., Lehner, B., Ouellet Dallaire, C., Ariwi, J., Grill, G.,
    Anand, M., Beames, P., Burchard-Levine, V., Maxwell, S., Moidu, H., Tan, F.,
    Thieme, M. (2019). Global hydro-environmental sub-basin and river reach
    characteristics at high spatial resolution. Scientific Data 6: 283.
    [DOI:10.1038/s41597-019-0300-6](https://doi.org/10.1038/s41597-019-0300-6).'
  |||,
  'sci:publications': [
    {
      citation: '[doi:10.6084/m9.figshare.9890531](https://doi.org/10.6084/m9.figshare.9890531)',
    },
  ],
  'gee:terms_of_use': |||
    'The HydroATLAS database is licensed under a Creative Commons Attribution
    (CC-BY) 4.0 International License. Please also refer to the HydroATLAS
    [Technical Documentation](https://data.hydrosheds.org/file/technical-documentation/HydroATLAS_TechDoc_v10.pdf)
    for more details on the license and requested citations.

    By downloading and using the data the user agrees to the terms and
    conditions of this license.'
  |||,
}
