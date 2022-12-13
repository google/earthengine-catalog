"""Checks for the type field.

The 'type' filed in a STAC file must be present and have one of these values:
- 'Catalog'
- 'Collection'
"""

from typing import Iterator

from checker import stac

CATALOG = 'Catalog'
COLLECTION = 'Collection'
TYPE = 'type'
TYPE_VALUES = frozenset({CATALOG, COLLECTION})


class Check(stac.NodeCheck):
  """Checks the type field."""
  name = 'type_field'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if TYPE not in node.stac:
      yield cls.new_issue(node, f'Missing: {TYPE}')
      return

    type_field = node.stac[TYPE]
    if not isinstance(type_field, str):
      yield cls.new_issue(node, f'{TYPE} must be a str')
      return

    if type_field not in TYPE_VALUES:
      yield cls.new_issue(node, f'{TYPE} must be one of {sorted(TYPE_VALUES)}')
      return

    if node.path.name == 'catalog.json':
      if type_field == stac.StacType.COLLECTION:
        yield cls.new_issue(
            node, f'catalog.json cannot have type {stac.StacType.COLLECTION}')
    elif type_field == stac.StacType.CATALOG:
      yield cls.new_issue(
          node,
          f'{stac.StacType.CATALOG} path must end with catalog.json. '
          f'Found: {node.path.name}')
