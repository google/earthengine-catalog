"""Checks for example scripts.

- All datassets must have a dataset example script
- ee.Tables must have a FeatureView example script, except when
  gee:skip_featureview_generation is set to true
"""

# TODO(schwehr): Add a tree check to find unused scripts.
# TODO(schwehr): Add a generate_examples script and add a message to use it.

import pathlib
from typing import Iterator

from checker import stac


_EXCEPTIONS_RAW = frozenset((
    'LANDSAT_LC8',
    'LANDSAT_LC8_L1T',
    'LANDSAT_LC8_L1T_32DAY_BAI',
    'LANDSAT_LC8_L1T_32DAY_EVI',
    'LANDSAT_LC8_L1T_32DAY_NBRT',
    'LANDSAT_LC8_L1T_32DAY_NDSI',
    'LANDSAT_LC8_L1T_32DAY_NDVI',
    'LANDSAT_LC8_L1T_32DAY_NDWI',
    'LANDSAT_LC8_L1T_32DAY_RAW',
    'LANDSAT_LC8_L1T_32DAY_TOA',
    'LANDSAT_LC8_L1T_8DAY_BAI',
    'LANDSAT_LC8_L1T_8DAY_EVI',
    'LANDSAT_LC8_L1T_8DAY_NBRT',
    'LANDSAT_LC8_L1T_8DAY_NDSI',
    'LANDSAT_LC8_L1T_8DAY_NDVI',
    'LANDSAT_LC8_L1T_8DAY_NDWI',
    'LANDSAT_LC8_L1T_8DAY_RAW',
    'LANDSAT_LC8_L1T_8DAY_TOA',
    'LANDSAT_LC8_L1T_ANNUAL_BAI',
    'LANDSAT_LC8_L1T_ANNUAL_EVI',
    'LANDSAT_LC8_L1T_ANNUAL_NBRT',
    'LANDSAT_LC8_L1T_ANNUAL_NDSI',
    'LANDSAT_LC8_L1T_ANNUAL_NDVI',
    'LANDSAT_LC8_L1T_ANNUAL_NDWI',
    'LANDSAT_LC8_L1T_ANNUAL_RAW',
    'LANDSAT_LC8_L1T_ANNUAL_TOA',
    'LANDSAT_LC8_L1T_TOA',
    'LANDSAT_LE7',
    'LANDSAT_LE7_L1T',
    'LANDSAT_LE7_L1T_32DAY_BAI',
    'LANDSAT_LE7_L1T_32DAY_EVI',
    'LANDSAT_LE7_L1T_32DAY_NBRT',
    'LANDSAT_LE7_L1T_32DAY_NDSI',
    'LANDSAT_LE7_L1T_32DAY_NDVI',
    'LANDSAT_LE7_L1T_32DAY_NDWI',
    'LANDSAT_LE7_L1T_32DAY_RAW',
    'LANDSAT_LE7_L1T_32DAY_TOA',
    'LANDSAT_LE7_L1T_8DAY_BAI',
    'LANDSAT_LE7_L1T_8DAY_EVI',
    'LANDSAT_LE7_L1T_8DAY_NBRT',
    'LANDSAT_LE7_L1T_8DAY_NDSI',
    'LANDSAT_LE7_L1T_8DAY_NDVI',
    'LANDSAT_LE7_L1T_8DAY_NDWI',
    'LANDSAT_LE7_L1T_8DAY_RAW',
    'LANDSAT_LE7_L1T_8DAY_TOA',
    'LANDSAT_LE7_L1T_ANNUAL_BAI',
    'LANDSAT_LE7_L1T_ANNUAL_EVI',
    'LANDSAT_LE7_L1T_ANNUAL_NBRT',
    'LANDSAT_LE7_L1T_ANNUAL_NDSI',
    'LANDSAT_LE7_L1T_ANNUAL_NDVI',
    'LANDSAT_LE7_L1T_ANNUAL_NDWI',
    'LANDSAT_LE7_L1T_ANNUAL_RAW',
    'LANDSAT_LE7_L1T_ANNUAL_TOA',
    'LANDSAT_LE7_L1T_TOA',
    'LANDSAT_LM1',
    'LANDSAT_LM1_L1T',
    'LANDSAT_LM2',
    'LANDSAT_LM2_L1T',
    'LANDSAT_LM3',
    'LANDSAT_LM3_L1T',
    'LANDSAT_LM4',
    'LANDSAT_LM4_L1T',
    'LANDSAT_LM5',
    'LANDSAT_LM5_L1T',
    'LANDSAT_LT4',
    'LANDSAT_LT4_L1T',
    'LANDSAT_LT4_L1T_32DAY_BAI',
    'LANDSAT_LT4_L1T_32DAY_EVI',
    'LANDSAT_LT4_L1T_32DAY_NBRT',
    'LANDSAT_LT4_L1T_32DAY_NDSI',
    'LANDSAT_LT4_L1T_32DAY_NDVI',
    'LANDSAT_LT4_L1T_32DAY_NDWI',
    'LANDSAT_LT4_L1T_32DAY_RAW',
    'LANDSAT_LT4_L1T_32DAY_TOA',
    'LANDSAT_LT4_L1T_8DAY_BAI',
    'LANDSAT_LT4_L1T_8DAY_EVI',
    'LANDSAT_LT4_L1T_8DAY_NBRT',
    'LANDSAT_LT4_L1T_8DAY_NDSI',
    'LANDSAT_LT4_L1T_8DAY_NDVI',
    'LANDSAT_LT4_L1T_8DAY_NDWI',
    'LANDSAT_LT4_L1T_8DAY_RAW',
    'LANDSAT_LT4_L1T_8DAY_TOA',
    'LANDSAT_LT4_L1T_ANNUAL_BAI',
    'LANDSAT_LT4_L1T_ANNUAL_EVI',
    'LANDSAT_LT4_L1T_ANNUAL_NBRT',
    'LANDSAT_LT4_L1T_ANNUAL_NDSI',
    'LANDSAT_LT4_L1T_ANNUAL_NDVI',
    'LANDSAT_LT4_L1T_ANNUAL_NDWI',
    'LANDSAT_LT4_L1T_ANNUAL_RAW',
    'LANDSAT_LT4_L1T_ANNUAL_TOA',
    'LANDSAT_LT4_L1T_TOA',
    'LANDSAT_LT5',
    'LANDSAT_LT5_L1T',
    'LANDSAT_LT5_L1T_32DAY_BAI',
    'LANDSAT_LT5_L1T_32DAY_EVI',
    'LANDSAT_LT5_L1T_32DAY_NBRT',
    'LANDSAT_LT5_L1T_32DAY_NDSI',
    'LANDSAT_LT5_L1T_32DAY_NDVI',
    'LANDSAT_LT5_L1T_32DAY_NDWI',
    'LANDSAT_LT5_L1T_32DAY_RAW',
    'LANDSAT_LT5_L1T_32DAY_TOA',
    'LANDSAT_LT5_L1T_8DAY_BAI',
    'LANDSAT_LT5_L1T_8DAY_EVI',
    'LANDSAT_LT5_L1T_8DAY_NBRT',
    'LANDSAT_LT5_L1T_8DAY_NDSI',
    'LANDSAT_LT5_L1T_8DAY_NDVI',
    'LANDSAT_LT5_L1T_8DAY_NDWI',
    'LANDSAT_LT5_L1T_8DAY_RAW',
    'LANDSAT_LT5_L1T_8DAY_TOA',
    'LANDSAT_LT5_L1T_ANNUAL_BAI',
    'LANDSAT_LT5_L1T_ANNUAL_EVI',
    'LANDSAT_LT5_L1T_ANNUAL_NBRT',
    'LANDSAT_LT5_L1T_ANNUAL_NDSI',
    'LANDSAT_LT5_L1T_ANNUAL_NDVI',
    'LANDSAT_LT5_L1T_ANNUAL_NDWI',
    'LANDSAT_LT5_L1T_ANNUAL_RAW',
    'LANDSAT_LT5_L1T_ANNUAL_TOA',
    'LANDSAT_LT5_L1T_TOA',
    'MODIS_MCD43A1',
    'MODIS_MCD43A2',
    'MODIS_MCD43A4',
    'MODIS_MCD43A4_BAI',
    'MODIS_MCD43A4_EVI',
    'MODIS_MCD43A4_NDSI',
    'MODIS_MCD43A4_NDVI',
    'MODIS_MCD43A4_NDWI',
    'MODIS_MOD09A1',
    'MODIS_MOD09GA',
    'MODIS_MOD09GA_BAI',
    'MODIS_MOD09GA_EVI',
    'MODIS_MOD09GA_NDSI',
    'MODIS_MOD09GA_NDVI',
    'MODIS_MOD09GA_NDWI',
    'MODIS_MOD09GQ',
    'MODIS_MOD09Q1',
    'MODIS_MOD11A1',
    'MODIS_MOD11A2',
    'MODIS_MOD13Q1',
    'MODIS_MYD09A1',
    'MODIS_MYD09GA',
    'MODIS_MYD09GA_BAI',
    'MODIS_MYD09GA_EVI',
    'MODIS_MYD09GA_NDSI',
    'MODIS_MYD09GA_NDVI',
    'MODIS_MYD09GA_NDWI',
    'MODIS_MYD09GQ',
    'MODIS_MYD09Q1',
    'MODIS_MYD10A1',
    'MODIS_MYD11A1',
    'MODIS_MYD11A2',
    'MODIS_MYD13Q1',
    ))
_EXCEPTIONS = frozenset({x + '.js' for x in _EXCEPTIONS_RAW})

_FEATURE_VIEW_EXCEPTIONS = frozenset({
    'JRC/JRC_LUCAS_HARMO_COPERNICUS_POLYGONS_V1_2018_FeatureView.js',
    'LARSE/LARSE_GEDI_GEDI02_A_002_INDEX_FeatureView.js',
    'LARSE/LARSE_GEDI_GEDI02_B_002_INDEX_FeatureView.js',
    'LARSE/LARSE_GEDI_GEDI04_A_002_INDEX_FeatureView.js',
    'TIGER/TIGER_2010_BG_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level12_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level11_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level10_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level09_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level08_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level07_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level06_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level05_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level04_FeatureView.js',
    'WWF/WWF_HydroATLAS_v1_Basins_level03_FeatureView.js',
})

_GEE_SKIP_FEATUREVIEW_GENERATION = 'gee:skip_featureview_generation'
_GEE_SKIP_INDEXING = 'gee:skip_indexing'


def load(examples_root: pathlib.Path) -> set[str]:
  return {str(path.relative_to(examples_root))
          for path in examples_root.rglob('*.js')}


class Check(stac.NodeCheck):
  """Checks for examples."""
  name = 'examples'
  scripts: set[str] = set()

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG: return
    if _GEE_SKIP_INDEXING in node.stac: return

    if not cls.scripts:
      cls.scripts = load(stac.examples_root())

    stem = node.path.stem
    name = stem + '.js'
    subdir = (node.id.split('/')[1] if node.id.startswith('projects/')
              else node.id.split('/')[0])
    basename = subdir + '/' + node.id.replace('/', '_')
    filename = basename + '.js'
    featureview_filename = basename + '_FeatureView.js'

    if filename not in cls.scripts and name not in _EXCEPTIONS:
      yield cls.new_issue(node, f'Missing script: {filename}')

    if node.gee_type == stac.GeeType.TABLE:
      if (featureview_filename not in cls.scripts and
          _GEE_SKIP_FEATUREVIEW_GENERATION not in node.stac and
          str(featureview_filename) not in _FEATURE_VIEW_EXCEPTIONS):
        yield cls.new_issue(
            node, f'Missing FeatureView script: {featureview_filename}')
    else:
      if featureview_filename in cls.scripts:
        yield cls.new_issue(
            node,
            'Only a table can have a FeatureView script: ' +
            str(featureview_filename))
