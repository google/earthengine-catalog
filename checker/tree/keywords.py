"""Checks for keywords that need the entire tree.

Each keyword must occur in at least two datasets.  One of the primary purposes
of keywords is to connect multiple datasets by concepts.
"""

import collections
from typing import Iterator

from checker import stac

KEYWORDS = 'keywords'

# TODO(schwehr): Comment out these keywords in the catalog or use the keyword
# in more than one STAC collection.
# Do not add more keywords to this list.
EXCEPTIONS = frozenset({
    '30_year', 'aafc', 'aer', 'aerial', 'aim', 'air_temperature', 'alerts',
    'aod', 'aot', 'argillic', 'asia', 'aura', 'avnir_2', 'backscattering',
    'belowground', 'bioclim', 'biome', 'biopama', 'biota', 'bnu', 'builtup',
    'bulk', 'bulk_density', 'burnseverity', 'c2s', 'c3s', 'calcium',
    'calibrated', 'caltech', 'canopy', 'carbon_organic', 'cci', 'cdem', 'cdl',
    'cgiar', 'ch4', 'china', 'chip', 'ciesin_derived', 'classification',
    'climatic_water_balance', 'cloudtostreet', 'coldest', 'condensation',
    'coral', 'corine_derived', 'cpom', 'cryosat_2', 'dartmouth', 'day',
    'demographic', 'dess', 'development', 'dfo', 'digital_soil_mapping',
    'disturbance', 'diurnal', 'driest', 'dust', 'ecosystem', 'eddi', 'emc',
    'endangered', 'energy', 'environment', 'eo_1', 'eorc', 'eos', 'eosdis',
    'famine', 'fcc', 'fireburning', 'firecci', 'firecci51', 'firms', 'fldas',
    'flood', 'flow_regulation', 'fpac', 'fundamental', 'gcos', 'gddp', 'ged',
    'geostationary', 'ges_disc', 'gfd', 'gfs', 'gimms', 'glad', 'glas',
    'globalsoilmap', 'globcover', 'goddard', 'grsg', 'gtopo30', 'habitats',
    'half_hourly', 'hapludalfs', 'health', 'human', 'hydroatlas', 'hyperion',
    'hyperspectral', 'igbp', 'impervious', 'infrastructure', 'inundation',
    'iran', 'iron', 'irrigated_land', 'isccp', 'isothermality', 'kbdi', 'kntu',
    'label', 'lance', 'landscan', 'landscape', 'lst_derived', 'lt8',
    'magnesium', 'maiac', 'mask', 'mcd115a3h', 'mcd12q1', 'mcd12q2', 'mcd15a3h',
    'mcd19a2', 'mcd43a3', 'mcd43c3', 'methane', 'metop', 'ml', 'mod17a2',
    'mod17a3gf', 'mod44b', 'modocga', 'multitemporal', 'myd17a2', 'myd17a3gf',
    'mydocga', 'naip', 'nasadem', 'nass', 'ncdc', 'ned', 'nfdrs', 'night',
    'nitrogen', 'nldas', 'nrcan', 'oilpalm', 'olci', 'omega', 'omi',
    'onset_greenness', 'organic', 'orthorectified', 'pantropical', 'par',
    'particulate_matter', 'pathfinder', 'persiann', 'phosphorus',
    'planet_derived', 'plantation', 'poes', 'polarization', 'potassium',
    'power', 'power_plants', 'precipitable', 'prescribedfire', 'protection',
    'radar', 'radarsat_1', 'range', 'reef', 'resolve', 'rgb', 'river_networks',
    'roads', 'rtma', 'saltmarsh', 'sea_ice', 'sea_salt', 'seagrass',
    'seasonality', 'seawifs', 'sentinelhub', 'settlement', 'settlements',
    'shortwave', 'silt', 'slga', 'slv', 'smod', 'smos', 'so4', 'social',
    'soil_depth', 'soil_moisture', 'soil_temperature', 'south_asia',
    'southeast_asia', 'spei', 'spi', 'stone',
    'stray_light', 'sulfur', 'taxonomy', 'terrace', 'terradat',
    'terrestrialaim', 'texture', 'tidal_flat', 'tidal_marsh', 'tile', 'tir',
    'tirs', 'tnc', 'toms', 'tree', 'tree_cover', 'trends', 'tropical',
    'ukraine', 'unep', 'utokyo', 'visibility', 'vnir', 'vnp09ga', 'vnp13a1',
    'void_filled', 'warmest', 'watercontent', 'wetness', 'wettest', 'whoi',
    'wildlife', 'wtlab', 'zcta', 'zinc', 'zip', 'zipcode'
})


# Use a function to allow a mock during testing.
def is_single_use_exception(keyword: str) -> bool:
  return keyword in EXCEPTIONS


def normalize_keyword(keyword: str) -> str:
  return keyword.lower().replace('-', '_')


class Check(stac.TreeCheck):
  """Checks keywords across collections."""
  name = 'keywords_tree'

  @classmethod
  def run(cls, nodes: list[stac.Node]) -> Iterator[stac.Issue]:
    counts = collections.Counter()

    for node in nodes:
      if node.type != stac.StacType.COLLECTION:
        continue

      original_keywords = node.stac.get(KEYWORDS, [])
      keywords = [normalize_keyword(k) for k in original_keywords]
      counts.update(keywords)

    single_keywords = {
        k for k, v in counts.items()
        if v == 1 and not is_single_use_exception(k)}

    if single_keywords:
      for node in nodes:
        if node.type != stac.StacType.COLLECTION:
          continue
        for keyword in node.stac.get(KEYWORDS, []):
          keyword = normalize_keyword(keyword)
          if keyword in single_keywords:
            # To add a keyword to the system, it needs to occur in at least
            # two datasets.  You can stage a keyword for later use by commenting
            # it out in the STAC Collection Jsonnet file.
            yield cls.new_issue(node, f'Only one instance of "{keyword}"')
