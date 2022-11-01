"""Checks for gee:is_derived.

This field is used to flag old older computed datasets that should not be
shown in the Earth Engine html catalog.

The properties and rules:

- It can only be present in datasets from LANDSAT, MODIS, and WHBU
- The field is a bool
- If it is present, it must be set to True
"""

from typing import Iterator

from checker import stac

GEE_IS_DERIVED = 'gee:is_derived'


class Check(stac.NodeCheck):
  """Checks the stac_version field."""
  name = 'gee_is_derived'

  @classmethod
  def run(cls, node: stac.Node) -> Iterator[stac.Issue]:
    if node.type == stac.StacType.CATALOG:
      if GEE_IS_DERIVED in node.stac:
        yield cls.new_issue(
            node, f'{stac.StacType.CATALOG} cannot have {GEE_IS_DERIVED}')
      return

    if GEE_IS_DERIVED not in node.stac:
      return

    is_derived = node.stac[GEE_IS_DERIVED]
    if not isinstance(is_derived, bool):
      yield cls.new_issue(node, f'{GEE_IS_DERIVED} must be a bool')
      return

    if ('LANDSAT' not in node.id and
        'MODIS' not in node.id and
        'WHBU' not in node.id):
      yield cls.new_issue(node, f'{GEE_IS_DERIVED} not allowed in dataset')
      return

    if not is_derived:
      yield cls.new_issue(node, f'{GEE_IS_DERIVED} can only be present as true')
