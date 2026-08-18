"""Checks that the title field is valid.

TODO(simonf): Describe title requirements.

Checking of deprecated assets is done in the version extension check.
"""

import re
from typing import Iterator

from checker import stac

EXCEPTION_IDS = frozenset({
    'USGS/3DEP',
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

    deprecated_count = title.lower().count('deprecated')
    if deprecated_count > 1:
      yield cls.new_issue(
          node,
          f'"{TITLE}" must contain "deprecated" at most once, '
          f'found {deprecated_count} times',
      )

    if node.type == stac.StacType.CATALOG:
      if node.id == GEE_CATALOG:
        # The top level node as a catalog title: 'Google Earth Engine Catalog'
        return

      if len(node.path.parts) != 2:
        last_part = node.id.split('/')[-1]
        if last_part != title:
          message = (
              f'Catalog {TITLE} is usually the dataset id:'
              f' "{node.id}" != "{title}"')
          yield cls.new_issue(node, message, stac.IssueLevel.WARNING)
    else:
      title = title.removesuffix(DEPRECATED)

    if node.id in EXCEPTION_IDS:
      return

    type_str = str(node.type).split('.')[-1].capitalize()
    if len(title) < 2:
      yield cls.new_issue(node, f'{type_str} {TITLE} is too short: "{title}"')
      return
    if len(title) > 140:
      yield cls.new_issue(node, f'{type_str} {TITLE} is too long: "{title}"')
      return

    if not re.fullmatch(r'[a-zA-Z][-+ .,_:/&<()\'a-zA-Z0-9]*', title):
      yield cls.new_issue(
          node, f'{type_str} {TITLE} has invalid characters: "{title}"'
      )
