"""Checks for gee:status validity.

gee:status specifies whether a dataset is not completely active.

Requirements and specification:
- If the node is a catalog, it cannot have the field.
- If the field is set, its value must be one of several enum values.
"""

from typing import Iterator

from checker import stac

GEE_STATUS = 'gee:status'


class Check(stac.NodeCheck):
  """Checks for gee:status."""
  name = 'gee_status'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if GEE_STATUS in node.stac:
      if node.type == stac.StacType.CATALOG:
        yield cls.new_issue(node, f'Catalogs may not have a {GEE_STATUS} field')
      elif node.type == stac.StacType.COLLECTION:
        field_value = node.stac.get(GEE_STATUS)
        if field_value not in stac.Status.allowed_statuses():
          yield cls.new_issue(
              node,
              f'{GEE_STATUS} must be one of'
              f' {sorted(stac.Status.allowed_statuses())}',
          )
