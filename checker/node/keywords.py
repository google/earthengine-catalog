"""Checks that the keywords field is valid.

Keywords should be sorted and there should be no duplicates.

- Each keyword must:
  - Be 2 to 50 characters
  - All letters must be lower case
  - Must start with a letter or number
  - Contain letters, numbers, and underscores
"""

import re
from typing import Iterator

from checker import stac

KEYWORDS = 'keywords'

EXCEPTIONS = frozenset({
    '16-day', '3-hourly', '30-year', '3dep', '4-day', '8-day', 'Africa',
    'BurnSeverity', 'China', 'EROS', 'EU', 'Fire', 'GPP', 'GTAC', 'JRC', 'MTBS',
    'PAR', 'PrescribedFire', 'Tsinghua', 'USDA', 'USFS', 'USGS', 'Wildfire',
    'air-temperature', 'avnir-2', 'built-up', 'bulk-density', 'carbon-organic',
    'change-detection', 'chlorophyll-a', 'conservation-easements',
    'corine-derived', 'cryosat-2', 'eo-1', 'era5-land', 'g-portal', 'gcom-c',
    'goes-16', 'goes-17', 'goes-east', 'goes-r', 'goes-s', 'goes-west',
    'half-hourly', 'iSDA', 'modis-derived',
    'nature-conservancy', 'open-buildings', 'planet-derived', 'protected-areas',
    'public-lands', 'radarsat-1', 'real-time', 'redcastle-resources',
    'sea-salt', 'sentinel1-derived', 'sentinel2-derived', 'stray-light',
    'surface-reflectance', 'time-series', 'viirs-derived', 'void-filled'
})


class Check(stac.NodeCheck):
  """Checks the keywords field."""
  name = 'keywords'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if KEYWORDS in node.stac:
        yield cls.new_issue(node, f'Catalogs cannot have "{KEYWORDS}"')
      return

    if KEYWORDS not in node.stac:
      yield cls.new_issue(node, f'Collections must have "{KEYWORDS}"')
      return

    keywords = node.stac[KEYWORDS]
    if not isinstance(keywords, list):
      yield cls.new_issue(node, f'"{KEYWORDS}" must be a list')
      return

    if not keywords:
      yield cls.new_issue(node, f'"{KEYWORDS}" must have at least one keyword')

    for keyword in keywords:
      if not isinstance(keyword, str):
        yield cls.new_issue(node, f'keyword must be a string: "{keyword}"')
      elif keyword not in EXCEPTIONS:
        if not re.fullmatch('[a-z][_a-z0-9]{1,49}', keyword):
          yield cls.new_issue(
              node,
              f'keyword must contain only letters, digits, and underscores '
              f'and be at most 49 characters long: "{keyword}"'
          )

    if keywords != sorted(keywords):
      yield cls.new_issue(node, f'"{KEYWORDS}" must be sorted')

    if len(keywords) != len(set(keywords)):
      yield cls.new_issue(node, 'duplicate keyword found')
