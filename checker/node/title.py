"""Checks that the title field is valid.

TODO(schwehr): Describe title requirements.

Checking of deprecated assets is done in the version extension check.
"""

import re
from typing import Iterator

from checker import stac

CATALOG_EXCEPTIONS_IDS = frozenset({'USGS/3DEP'})

COLLECTION_EXCEPTION_IDS = frozenset({
    'ISDASOIL/Africa/v1/aluminium_extractable',
    'ISDASOIL/Africa/v1/bedrock_depth',
    'ISDASOIL/Africa/v1/bulk_density',
    'ISDASOIL/Africa/v1/calcium_extractable',
    'ISDASOIL/Africa/v1/carbon_organic',
    'ISDASOIL/Africa/v1/carbon_total',
    'ISDASOIL/Africa/v1/cation_exchange_capacity',
    'ISDASOIL/Africa/v1/clay_content',
    'ISDASOIL/Africa/v1/fcc',
    'ISDASOIL/Africa/v1/iron_extractable',
    'ISDASOIL/Africa/v1/magnesium_extractable',
    'ISDASOIL/Africa/v1/nitrogen_total',
    'ISDASOIL/Africa/v1/ph',
    'ISDASOIL/Africa/v1/phosphorus_extractable',
    'ISDASOIL/Africa/v1/potassium_extractable',
    'ISDASOIL/Africa/v1/sand_content',
    'ISDASOIL/Africa/v1/silt_content',
    'ISDASOIL/Africa/v1/stone_content',
    'ISDASOIL/Africa/v1/sulphur_extractable',
    'ISDASOIL/Africa/v1/texture_class',
    'ISDASOIL/Africa/v1/zinc_extractable',
    'OSU/GIMP/2000_IMAGERY_MOSAIC',
})

DEPRECATED = ' [deprecated]'
GEE_CATALOG = 'GEE_catalog'
TITLE = 'title'


class Check(stac.NodeCheck):
  """Checks the title field."""
  name = 'title'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if TITLE not in node.stac:
      yield cls.new_issue(node, f'Missing {TITLE}')
      return

    title = node.stac[TITLE]
    if not isinstance(title, str):
      yield cls.new_issue(node, f'"{TITLE}" must be a str')
      return

    if node.type == stac.StacType.CATALOG:
      if node.id == GEE_CATALOG:
        # The top level node as a catalog title: 'Google Earth Engine Catalog'
        return

      # Handles 1 level and 2 level cases.
      last_part = node.id.split('/')[-1]
      if last_part != title:
        message = (
            f'Catalog {TITLE} is usually the dataset id:'
            f' "{node.id}" != "{title}"')
        yield cls.new_issue(node, message, stac.IssueLevel.WARNING)

      if node.id not in CATALOG_EXCEPTIONS_IDS:
        if not re.fullmatch('[a-zA-Z][-_a-zA-Z0-9]{1,30}', title):
          yield cls.new_issue(node, f'Catalog {TITLE} not valid: "{title}"')
      return

    title = title.removesuffix(DEPRECATED)

    if node.id in COLLECTION_EXCEPTION_IDS:
      return
    if not re.fullmatch('[A-Z][-+ .,_:/&<()a-zA-Z0-9]{1,140}', title):
      yield cls.new_issue(node, f'Collection {TITLE} not valid: "{title}"')
