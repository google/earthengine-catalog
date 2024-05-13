local id = 'USGS';
local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';

local basename = 'catalog';
local base_filename = basename + '.json';
local base_url = ee_const.catalog_base + 'USGS/';
local parent_url = ee_const.catalog_base + 'catalog.json';
local self_url = base_url + base_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.catalog,
  id: id,
  title: id,
  description: importstr 'description.md',
  links: [
    ee.link.root(),
    ee.link.parent(parent_url),
    ee.link.self_link(self_url),

    ee.link.child_collection('USGS_GMTED2010', base_url),
    ee.link.child_collection('USGS_GMTED2010_FULL', base_url),
    ee.link.child_collection('USGS_GTOPO30', base_url),
    ee.link.child_collection('USGS_NED', base_url),
    ee.link.child_collection('USGS_NLCD', base_url),
    ee.link.child_collection('USGS_SRTMGL1_003', base_url),

    ee.link.child_collection('USGS_3DEP_10m', base_url),
    ee.link.child_collection('USGS_3DEP_10m_metadata', base_url),
    ee.link.child_collection('USGS_3DEP_1m', base_url),

    ee.link.child_collection('USGS_GAP_AK_2001', base_url),
    ee.link.child_collection('USGS_GAP_CONUS_2011', base_url),
    ee.link.child_collection('USGS_GAP_HI_2001', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_designation', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_easement', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_fee', base_url),
    ee.link.child_collection('USGS_GAP_PAD-US_v20_proclamation', base_url),
    ee.link.child_collection('USGS_GAP_PR_2001', base_url),

    ee.link.child_collection('USGS_GFSAD1000_V0', base_url),
    ee.link.child_collection('USGS_GFSAD1000_V1', base_url),

    ee.link.child_collection('USGS_LIMA_MOSAIC', base_url),
    ee.link.child_collection('USGS_LIMA_SR', base_url),
    ee.link.child_collection('USGS_LIMA_SR_METADATA', base_url),

    ee.link.child_collection('USGS_NLCD_RELEASES_2016_REL', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2019_REL_NLCD', base_url),

    ee.link.child_collection(
      'USGS_NLCD_RELEASES_2019_REL_RCMAP_V4_COVER', base_url),
    ee.link.child_collection(
      'USGS_NLCD_RELEASES_2019_REL_RCMAP_V5_COVER', base_url),
    ee.link.child_collection(
      'USGS_NLCD_RELEASES_2023_REL_RCMAP_V6_COVER', base_url),
    ee.link.child_collection(
      'USGS_NLCD_RELEASES_2019_REL_RCMAP_V5_TRENDS', base_url),
    ee.link.child_collection(
      'USGS_NLCD_RELEASES_2019_REL_RCMAP_V5_TRENDS_YEAR', base_url),
    ee.link.child_collection(
      'USGS_NLCD_RELEASES_2023_REL_RCMAP_V6_TRENDS_YEAR', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2020_REL_NALCMS', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2021_REL_NLCD', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2021_REL_TCC_v2021-4', base_url),
    ee.link.child_collection('USGS_NLCD_RELEASES_2023_REL_RCMAP_V6_TRENDS', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC02', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC04', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC06', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC08', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC10', base_url),
    ee.link.child_collection('USGS_WBD_2017_HUC12', base_url),
  ],
}