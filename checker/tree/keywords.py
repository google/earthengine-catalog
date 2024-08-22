"""Checks for keywords that need the entire tree.

Each keyword should occur in at least two datasets.  One of the primary purposes
of keywords is to connect multiple datasets by concepts.
"""

import collections
from typing import Iterator

from checker import stac

KEYWORDS = 'keywords'

# TODO(simonf): Comment out these keywords in the catalog or use the keyword
# in more than one STAC collection.
# Do not add more keywords to this list.
EXCEPTIONS = frozenset({
    '30_year',
    '4_day',
    'aafc',
    'aerial',
    'aim',
    'air_temperature',
    'alerts',
    'aot',
    'argillic',
    'asia',
    'aura',
    'avnir_2',
    'backscatter',
    'bathymetry',
    'belowground',
    'bioclim',
    'biome',
    'biopama',
    'biota',
    'bnu',
    'brandenburg',
    'built_up',
    'bulk',
    'bulk_density',
    'burnseverity',
    'c2s',
    'c3s',
    'calcium',
    'calibrated',
    'caltech',
    'carbon_organic',
    'cci',
    'cdem',
    'cdl',
    'cgiar',
    'change',
    'china',
    'chip',
    'ciesin_derived',
    'clc',
    'climatic_water_balance',
    'cloudtostreet',
    'coldest',
    'condensation',
    'coral',
    'corine',
    'corine_derived',
    'cpom',
    'cryosat_2',
    'dartmouth',
    'daymet',
    'demographic',
    'dess',
    'development',
    'dfo',
    'digital_soil_mapping',
    'diurnal',
    'driest',
    'ecosystem',
    'eddi',
    'emc',
    'endangered',
    'energy',
    'environment',
    'eo_1',
    'eorc',
    'eos',
    'famine',
    'fcc',
    'fireburning',
    'firecci',
    'firecci51',
    'fldas',
    'flow_regulation',
    'forest_inventory_and_analysis',
    'forest_type',
    'fpac',
    'friction',
    'fundamental',
    'gcos',
    'ged',
    'geostationary',
    'germany',
    'ges_disc',
    'gfd',
    'gfs',
    'gfsad',
    'gimms',
    'glad',
    'glas',
    'globalsoilmap',
    'globcover',
    'goddard',
    'grsg',
    'gtopo30',
    'habitats',
    'half_hourly',
    'hansen',
    'hapludalfs',
    'health',
    'hsl',
    'human',
    'hyperion',
    'igbp',
    'impervious',
    'infrastructure',
    'inundation',
    'iran',
    'iron',
    'irrigated_land',
    'isccp',
    'isothermality',
    'kbdi',
    'kntu',
    'label',
    'lake',
    'landscape',
    'lcms',
    'lst_derived',
    'lt8',
    'magnesium',
    'mask',
    'mavi',
    'mcd115a3h',
    'mcd12q1',
    'mcd12q2',
    'mcd15a3h',
    'mcd19a2',
    'mcd43a1',
    'mcd43a3',
    'mcd43c3',
    'metop',
    'ml',
    'mod08',
    'mod08_m3',
    'mod09a1',
    'mod09ga',
    'mod09gq',
    'mod10a1',
    'mod11a1',
    'mod13a1',
    'mod13a2',
    'mod13q1',
    'mod14a1',
    'mod14a2',
    'mod15a2h',
    'mod17a2',
    'mod17a3gf',
    'mod44b',
    'modocga',
    'myd08',
    'myd08_m3',
    'myd09a1',
    'myd09ga',
    'myd09gq',
    'myd09q1',
    'myd10a1',
    'myd11a1',
    'myd11a2',
    'myd13a1',
    'myd13a2',
    'myd13q1',
    'myd14a1',
    'myd14a2',
    'myd15a2h',
    'myd17a2',
    'myd17a3gf',
    'mydocga',
    'naip',
    'nasadem',
    'nass',
    'ncdc',
    'ndmc',
    'ned',
    'nfdrs',
    'nitrogen',
    'nldas',
    'nrcan',
    'olci',
    'omega',
    'omi',
    'open_buildings',
    'organic',
    'orthorectified',
    'pantropical',
    'particulate_matter',
    'pathfinder',
    'persiann',
    'phosphorus',
    'planet_derived',
    'pnoa',
    'poes',
    'polarization',
    'potassium',
    'power',
    'power_plants',
    'precipitable',
    'prescribedfire',
    'protection',
    'quality',
    'radarsat_1',
    'range',
    'real_time',
    'recurrence',
    'reef',
    'resolve',
    'rgbn',
    'river_networks',
    'rmrs',
    'rtma',
    'salinity',
    'saltmarsh',
    'seagrass',
    'sea_ice',
    'sea_level_changes',
    'seasonality',
    'seawifs',
    'sentinelhub',
    'silt',
    'slga',
    'slv',
    'smod',
    'smos',
    'social',
    'soil_depth',
    'soil_temperature',
    'south_asia',
    'southeast_asia',
    'spain',
    'spei',
    'spi',
    'ssh',
    'stone',
    'stray_light',
    'structure',
    'sulfur',
    'swissimage',
    'swisstopo',
    'taxonomy',
    'terrace',
    'terradat',
    'terrestrialaim',
    'texture',
    'tidal_flat',
    'tidal_marsh',
    'tile',
    'tir',
    'tirs',
    'tnc',
    'toms',
    'treemap',
    'tropical',
    'urban_gradient',
    'ukraine',
    'unep',
    'utokyo',
    'viirs_derived',
    'visibility',
    'vnir',
    'vnp09ga',
    'vnp13a1',
    'void_filled',
    'warmest',
    'watercontent',
    'water_temp',
    'wetness',
    'wettest',
    'whoi',
    'wildlife',
    'wtlab',
    'zcta',
    'zinc',
    'zip_code',
})


# Use a function to allow a mock during testing.
def is_single_use_exception(keyword: str) -> bool:
  return keyword in EXCEPTIONS


class Check(stac.TreeCheck):
  """Checks keywords across collections."""
  name = 'keywords_tree'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    dataset_nodes = [
        node for node in nodes if node.type != stac.StacType.CATALOG
    ]
    # Skip this check for deprecated datasets - if a dataset is updated
    # to a new version, keywords that used to be single would be
    # duplicated, but since we skip deprecated datasets in tag searches,
    # users will still effectively see a single keyword.
    nodes = [
        x
        for x in dataset_nodes
        if x.stac.get(stac.GEE_STATUS) != stac.Status.DEPRECATED.value
    ]

    counts = collections.Counter()
    for node in nodes:
      counts.update(node.stac.get(KEYWORDS, []))

    single_keywords = {
        k for k, v in counts.items()
        if v == 1 and not is_single_use_exception(k)}

    if single_keywords:
      for node in nodes:
        for keyword in node.stac.get(KEYWORDS, []):
          if keyword in single_keywords:
            # To add a keyword to the system, it should to occur in at least
            # two datasets.  For those where the keyword is critical, but there
            # is currently only one keyword, add the keyword to the exception
            # list.
            yield cls.new_issue(node, f'Only one instance of "{keyword}"')

    multiple_use_keywords = {k for k, v in counts.items() if v > 1}
    no_longer_single_use = multiple_use_keywords.intersection(EXCEPTIONS)
    unknown_node = stac.Node(
        stac.UNKNOWN_ID, stac.UNKNOWN_PATH, stac.StacType.COLLECTION,
        stac.GeeType.NONE, {})
    for keyword in sorted(no_longer_single_use):
      yield cls.new_issue(
          unknown_node,
          f'"{keyword}" should be removed from exceptions')
