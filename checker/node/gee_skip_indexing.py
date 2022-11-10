"""Checks for gee:skip_indexing validity.

gee:skip_indexing specifies whether a dataset should be omitted from the
public index. Useful for publishing drafts and for datasets which do not
meet the requirements (for example they are missing example javascript or
preview images) for the public index.

Requirements and specification:
- If the node is a catalog, it cannot have the field.
- If the field exists, its value must be a boolean.
"""

from typing import Iterator

from checker import stac

GEE_SKIP_INDEXING = 'gee:skip_indexing'


class Check(stac.NodeCheck):
  """Checks for gee:skip_indexing."""
  name = 'gee_skip_indexing'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if GEE_SKIP_INDEXING in node.stac:
      if node.type == stac.StacType.CATALOG:
        yield cls.new_issue(
            node, f'Catalogs may not have a {GEE_SKIP_INDEXING} field')
      elif node.type == stac.StacType.COLLECTION:
        field_value = node.stac.get(GEE_SKIP_INDEXING)
        if not isinstance(field_value, bool):
          yield cls.new_issue(node, f'{GEE_SKIP_INDEXING} must be a bool')
